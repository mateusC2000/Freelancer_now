# FreelancerNow

##  Sobre o Projeto

O projeto consiste em uma plataforma web baseada em um negócio com foco de que criadores de projetos e profissionais da área de tecnologia possam se encontrar para fins profissionais.
Os profissionais podem criar uma conta na plataforma e completam seu perfil  para buscar projetos e enviar uma
proposta referente ao mesmo. Os donos de projetos cadastram seus projetos e avaliam as propostas e perfis dos profissionais, de forma que eles podem aceitar tal proposta ou não.

## Pré-requisitos:

 * Docker 20.10.11
 * Ruby 3.3.5
 * Rails 6.1.4.1

### Gems Complementares

#### Testes

  * RSpec  https://rubygems.org/gems/rspec/versions/3.10.0
  * Capybara  https://rubygems.org/gems/capybara/versions/3.35.3
  * Shoulda Matchers  https://github.com/thoughtbot/shoulda-matchers
  * Factory Bot  https://github.com/thoughtbot/factory_bot
  * Rubocop https://github.com/rubocop/rubocop
  * Rubocop-Rails https://github.com/rubocop/rubocop-rails
  * Faker https://github.com/faker-ruby/faker
                                          
#### Autorização/Autenticação

  * Devise  https://github.com/heartcombo/devise#getting-started

## Funcões

### Donos de Projetos

  * Cadastram projetos na aplicação.
  * Gerenciam propostas dos desenvolvedores interessados no projeto.

### Desenvolvedores

  * Cadastram propostas aos projetos na plataforma.

## Para execução do projeto: 

  * Clone o projeto em sua máquina

```
  git clone https://github.com/mateusC2000/Freelancer_now.git
```
### Construa a imagem da aplicação:

  * Rode o comando: 
```
cd Freelancer_now
```
  * Após, rode  o comando: 
```
docker image build -t <image-name> .
```

## Iniciar o projeto:

```
docker-compose run --rm --service-ports app bash
```

  * Rode o comando abaixo para instalar todas as dependencias necessárias.
```
bin/setup
```
  * Rode o comando abaixo para popular o banco de dados.
```
rails db:seed
```
  * Rode o comando abaixo para executar a aplicação.
```
rails s -b 0.0.0.0 -p 3000
```
  * Vá ao seu navegador e acesse:
```
http://localhost:3000
```
## Observações:

  * Dentre os dados do banco de dados há 5 logins já existentes para a área de dono de projetos com projetos já existentes, são eles:
```
email: kurt@weler.com.br, senha: 123456789
```
```
email: jane@doe.com.br, senha: 123456789
```
```
email: ryan@kaen.com.br, senha: 123456789
```
```
email: anjel@julian.com.br, senha: 123456789
```
```
email: chris@rock.com.br, senha: 123456789
```

  * E há um desenvolvedor com proposta feita a um dos projetos existentes:
```
email: darth@vader.com.br, senha: 123456789
```