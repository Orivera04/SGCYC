class LoginsController < ApplicationController
    @resource = "Usuario"

    def show
        render template: "logins/index", layout: "layouts/application"
    end
end
