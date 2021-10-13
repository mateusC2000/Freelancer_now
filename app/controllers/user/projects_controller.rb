class User::ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
  end
end
