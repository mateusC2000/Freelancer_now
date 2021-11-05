require 'rails_helper'

describe 'Visitor visits home page' do
  it 'successfuly' do
    visit root_path

    expect(page).to have_content('FreelancerNow')
    expect(page).to have_content('Sua próxima contratação está aqui!')
  end

  it 'and sees available projects' do
    create(:project, title: 'Desenvolvedor de Sites')

    visit root_path
    click_on 'Desenvolvedor de Sites'

    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).to have_content('Desenvolvimento de sites e-commerce e institucionais')
    expect(page).to have_content('Buscamos pessoas com experiência em e-commerce Google ADS CMS SEO')
    expect(page).to have_content('Máximo pago por hora: R$ 10,00')
    expect(page).to have_content('Último dia útil: 20/11/2021')
    expect(page).to have_content('Remoto')
    expect(page).to have_link('Voltar')
  end

  it 'and search projects' do
    kurt = create(:project_owner)
    jane = create(:project_owner)
    love = create(:project_owner)
    create(:project, title: 'Desenvolvedor de Sites', project_owner: kurt)
    create(:project, title: 'Desenvolvedor de Aplicativos', project_owner: jane)
    create(:project, title: 'Front on Fire', project_owner: love)

    visit root_path
    find(:id, 'q').set('Desenvolvedor')
    click_on 'Pesquisar'

    expect(page).to have_content('Desenvolvedor de Aplicativos')
    expect(page).to have_content('Desenvolvedor de Sites')
    expect(page).not_to have_content('Front on Fire')
  end
end
