class Api::ApplicationController < ApplicationController
    # rails g controller Api::Application --no-assets --no-helper --skip-template-engine
    # 👆🏻Terminal command for generating Api::ApplicationController
    skip_before_action :verify_authenticity_token
    # For further reading abount CSRF 👉🏻 https://en.wikipedia.org/wiki/Cross-site_request_forgery
    #code
end
