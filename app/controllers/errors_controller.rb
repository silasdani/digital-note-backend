class ErrorsController < ApplicationController

    def bad_request
      respond_to do |format|
        @status = 400
        @title = "Bad Request"
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Bad Request" }, status: @status}
      end
    end

    def unauthorized
      respond_to do |format|
        @status = 401
        @title = "Unauthorized"
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Unauthorized" }, status: @status}
      end
    end

    def forbidden
      respond_to do |format|
        @status = 403
        @title = "Forbidden: Access is denied"
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Forbidden" }, status: @status}
      end
    end

    def not_found
        respond_to do |format|
          @status = 404
          @title = "Resource not found"
          format.html { render 'error', status: @status}
          format.json { render json: { error: "Not Found" }, status: @status}
        end
      end
      
    def unacceptable
        respond_to do |format|
          @status = 422
          @title = "Entity not processable"
          format.html { render 'error', status: @status}
          format.json { render json: { error: "Params unacceptable" }, status: @status}
        end
      end

    def internal_error
        respond_to do |format|
          @status = 500
          @title = 'Internal server error'
          format.html { render 'error', status: @status}
          format.json { render json: { error: "Internal server error" }, status: @status}
        end
      end

    def bad_gateway
      respond_to do |format|
        @status = 502
        @title = "Bad gateway"
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Bad Gateway" }, status: @status}
      end
    end

    def unavailable
      respond_to do |format|
        @status = 503
        @title = "Service temporarily unavailable"
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Unavailable" }, status: @status}
      end
    end

    def timeout
      respond_to do |format|
        @status = 504
        @title = "Gateway timeout" 
        format.html { render 'error', status: @status}
        format.json { render json: { error: "Gateway Time-Out" }, status: @status}
      end
    end
  end