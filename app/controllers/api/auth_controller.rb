class Api::AuthController < Api::BaseController
	skip_before_action :authorize_request, except: [:restoreUser]

	def restoreUser
		token = jwt_encode(user_id: @current_user.id)
		render json: {token: token}
	end

	def login
		@user = User.find_by_email(params[:email])
		if @user.valid_password?(params[:password])
			token = jwt_encode(user_id: @user.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: "User not found or invalid credentials"}, status: :unauthorized
		end
	end

	def register
		@user = User.new(
			:email => params[:email],
			:password => params[:password],
			:password_confirmation => params[:password]
			)
		@user.skip_confirmation!
		@user.confirm
		if @user.save
			token = jwt_encode(user_id: @user.id)
			render json: {token: token}, status: :ok
		else
			render json: {error: "failed to create an account"},status: :unauthorized
		end
	end

end