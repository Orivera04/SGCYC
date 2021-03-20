class ClientesMorososController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :ClientesMorosos

  def index
    render template: "clientes_morosos/index",  layout: 'layouts/application'
  end

  def show
  end

  def new
    render template: "clientes_morosos/form",  layout: 'layouts/application'
  end
end
