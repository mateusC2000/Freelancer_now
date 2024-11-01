class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::ActiveRecordError, with: :render_generic_error
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def login
    developer = Developer.find_by(email: params[:email])
    if developer&.valid_password?(params[:password])
      payload = { developer_email: developer.email }
      token = encode_token(payload)
      render status: :accepted, json: { token: token, message: "Bem-vindo #{params[:email]}" }
    else
      render status: :unauthorized, json: { message: 'Email ou senha inválida' }
    end
  end

  private

  def logged_in?
    !!session_user
  end

  def session_user
    return unless decoded_token

    developer_email = decoded_token[0]
    @developer = Developer.find_by(email: developer_email)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]
    JWT.decode(token, ENV.fetch('JWT_SECRET', nil), false, algorithm: 'HS256')
  end

  def require_login
    render json: { message: 'Por favor, faça login.' }, status: :unauthorized unless logged_in?
  end

  def encode_token(payload)
    JWT.encode(payload, ENV.fetch('JWT_SECRET', nil))
  end

  def render_not_found
    render status: :not_found, json: { message: 'Objeto não encontrado' }
  end

  def render_generic_error
    render status: :internal_server_error, json: { message: 'Erro geral' }
  end
end
