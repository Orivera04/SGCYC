class HomeController < ApplicationController
  include Controleable

  def index
    render template: "home/index",  layout: 'layouts/application'
  end

end
