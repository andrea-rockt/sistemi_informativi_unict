class UserController < ApplicationController
	def index
		@users = User.all

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @user }
		end
	end

	# GET /user/1
	# GET /user/1.xml
	def show
		@user = User.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @user }
		end
	end

	# GET /user/new
	# GET /user/new.xml
	def new
		@user = User.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @user }
		end
	end

	# GET /user/1/edit
	def edit
		@user = User.find(params[:id])
	end

	# POST /user
	# POST /user.xml
	def create
		@user = User.new(params[:user])

		respond_to do |format|
			if @user.save
				format.html { redirect_to(@user, :notice => 'User was successfully created.') }
				format.xml  { render :xml => @user, :status => :created, :location => @user }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /user/1
	# PUT /user/1.xml
	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to(@user, :notice => 'Utente aggiornato con successo') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /user/1
	# DELETE /user/1.xml
	def destroy
		@user = User.find(params[:id])
		@user.destroy

		respond_to do |format|
			format.html { redirect_to(user_index_url) }
			format.xml  { head :ok }
		end
	end

end
