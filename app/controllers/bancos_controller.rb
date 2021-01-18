class BancosController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Bancos

  def index
    render template: "bancos/index",  layout: 'layouts/application'
  end
end
