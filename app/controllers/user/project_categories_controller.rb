class User::ProjectCategoriesController < DevelopersController
  def show
    @category = ProjectCategory.find(params[:id])
  end
end
