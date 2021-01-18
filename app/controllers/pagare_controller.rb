class PagareController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Pagare

  def index
    render template: "pagare/index",  layout: 'layouts/application'
  end

  def show
  end

  def new
    render template: "pagare/form",  layout: 'layouts/application'
  end
end
