class DevelopersController < ApplicationController
  before_action :authenticate_developer!
  layout 'developer'
end
