class EmpresaController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Empresa

  def index
    render template: "empresa/index",  layout: 'layouts/application'
  end
end
