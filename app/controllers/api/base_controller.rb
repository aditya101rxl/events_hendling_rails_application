class Api::BaseController < ApplicationController
	skip_before_action :authenticate_user!

	include JsonWebToken
	before_action :authorize_request

	private
		def authorize_request
		  header = request.headers["Authorization"]
		  header = header.split(" ").last if header
		  decoded = jwt_decode(header)
		  @current_user = User.find(decoded[:user_id])
		end
end