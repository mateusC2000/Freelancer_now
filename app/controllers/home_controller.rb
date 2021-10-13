class HomeController < ApplicationController
  layout :change_layout

  def index
    @projects = Project.all
  end

  private

  def change_layout
    if project_owner_signed_in?
      'project_owner'
    elsif developer_signed_in?
      'developer'
    else
      'application'
    end
  end
end
