class Api::AuthController < Api::BaseController
	skip_before_action :authorize_request

	def login
		@user = User.find_by_email(params[:email])
		if @user.valid_password?(params[:password])
			token = jwt_encode(user_id: @user.id)
			render json: {user: @user, token: token, msg: "success"}, status: :ok
		else
			render json: {error: 'unauthorized', msg: "user not found or invalid credentials"}, status: :unauthorized
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
			render json: {user: @user, token: token, msg: "success"}, status: :ok
		else
			render json: {error: 'failed to create an account', msg: "please try after some time"}
		end
	end

end