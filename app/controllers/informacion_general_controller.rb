class InformacionGeneralController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :InformacionGeneral

  def index
    render template: "informacion_general/index",  layout: 'layouts/application'
  end

  def show
  end

  def new
    render template: "informacion_general/form",  layout: 'layouts/application'
  end
end
