class UsersController < ApplicationController
    # wrap_parameters format: []
    # def create
    #     user = User.create(user_params)
    #     if user.valid?
    #     session[:user_id] = user.id
    #     render json:  user, status: :ok
    #     else  
    #      render json: {error: user.errors.full_messages}, status: 422
    #     end
    # end

    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end


    def show
        if (session.include? :user_id)
        user = User.find(session[:user_id])
        render json: user, status: :ok
        else
            render json: {}, status: 401
        end
    end


    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
