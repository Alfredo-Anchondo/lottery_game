class WebhooksController < ApplicationController
    skip_before_filter
    protect_from_forgery :except => :create
    
    def create
        logger.info "entre"
        
    end
    
end