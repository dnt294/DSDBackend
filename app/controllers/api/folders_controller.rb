class Api::FoldersController < ApplicationController

	def index
		@folder = Folder.first#.children.arrange_serializable
		render json: @folder
	end

	def show
		
	end

	def create
		
	end

	def update
		
	end

	def destroy
		
	end

end