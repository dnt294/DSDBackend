class Api::ApiController < ApplicationController

    skip_before_action :verify_authenticity_token
    acts_as_token_authentication_handler_for User, fallback_to_devise: false
    respond_to :json

end
