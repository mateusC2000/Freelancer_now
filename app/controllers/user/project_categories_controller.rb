class User::ProjectCategoriesController < ApplicationController
  def show
    @category = ProjectCategory.find(params[:id])
  end
end