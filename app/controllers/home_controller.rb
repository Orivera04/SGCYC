class HomeController < ApplicationController
 before_action :authenticate_usuario!

  def new
    render template: "home/index",  layout: 'layouts/application'
  end

end
