class ProjectOwnersController < ApplicationController
  before_action :authenticate_project_owner!
  layout 'project_owner'
end
