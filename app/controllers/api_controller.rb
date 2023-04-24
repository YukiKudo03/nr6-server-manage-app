class ApiController < ActionController::Base
    protect_from_forgery with: :null_session

    def set_csrf_token_header
        response.set_header('X-CSRF-Token', from_authenticity_token)
    end
end
