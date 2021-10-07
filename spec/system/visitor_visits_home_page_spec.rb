require 'rails_helper'

describe 'Visitor visits home page' do
  it 'successfuly' do

    visit root_path

    expect(page).to have_content('Freelancer Now')
    expect(page).to have_content('Sua próxima contratação está aqui!')
  end
end
