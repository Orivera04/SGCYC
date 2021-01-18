class RolesController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Roles

  def index
    render template: "roles/index",  layout: 'layouts/application'
  end
end
