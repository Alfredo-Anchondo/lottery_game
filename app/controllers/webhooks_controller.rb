class WebhooksController < ApplicationController
    skip_before_filter
    protect_from_forgery :except => :create
    
    def receive
        logger.info "entre"
        
    end
    
    def demo
        logger.info "jalo"
    end
    
end