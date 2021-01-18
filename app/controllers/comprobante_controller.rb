class ComprobanteController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Comprobante

  def index
    render template: "comprobante/index",  layout: 'layouts/application'
  end

  def show
  end

  def new
    render template: "comprobante/form",  layout: 'layouts/application'
  end
end
