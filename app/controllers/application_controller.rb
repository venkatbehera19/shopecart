class ApplicationController < ActionController::Base
    include Pundit::Authorization
    include SessionsHelper
end
