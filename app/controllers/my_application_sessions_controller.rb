class MyApplicationSessionsController < Devise::SessionsController
    responders :my_application

    def create
      raise super.inspect
      super { |resource| 
        puts resource
        @resource = resource }
    end

    def new
      super { |resource| 
        puts resource.as_json
        @resource = resource }
    end

end