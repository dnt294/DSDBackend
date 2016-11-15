class Api::TokensController < Api::ApiController
	
	#skip_before_filter :authenticate_user!

	respond_to :json

	def create
		username = params[:username]
		password = params[:password]

		if request.format != :json
			render status: 406, json: {message: 'The request must be json!'}
			return
		end

		if (username.nil? or password.nil?)			
			render status: 400, json: {message: 'Must have username and password!'}
			return
		end

		@user = User.find_by(username: username)

		if @user.nil?
			render status: 401, json: {message: 'Invalid username!'}
			return
		end

		if @user.valid_password?(password)
			render status: 200, json: {token: @user.authentication_token, email: @user.email, id: @user.id}
			return
		else
			render status: 401, json: {message: 'Wrong password!'}
			return
		end
	end

	def destroy
		
	end
end