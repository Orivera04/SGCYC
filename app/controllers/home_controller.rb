class HomeController < ApplicationController
  include Controleable

  def index
    if can? :read, :InformacionGeneral
      redirect_to informacion_general_index_path
    else
      render template: "home/index",  layout: "layouts/application"
    end
  end

end
