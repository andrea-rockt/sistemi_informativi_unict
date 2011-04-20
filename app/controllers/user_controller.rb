class UserController < ApplicationController
	before_filter :require_admin!, :except => [:index,:show,:update,:create]
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
		if current_user.is_admin
			@user = User.find(params[:id])
			respond_to do |format|
				format.html # show.html.erb
				format.xml  { render :xml => @user }
			end
		else
			
			if(current_user.id.to_i != params[:id].to_i)
				flash.now[:notice] = "I privilegi da te posseduti non sono sufficienti a visualizzare altri utenti"
			end
			@user = current_user
			
			respond_to do |format|
				format.html
				format.xml  { render :xml => @user }
			end
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
		respond_to do |format|
			format.html{ redirect_to @user}
		end 
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
		if current_user.is_admin
			@user = User.find(params[:id])
		else
			@user = current_user
		end

		respond_to do |format|
			
			if @user.update_attributes(params[:user])
				if(!params[:remote])
					format.html { redirect_to(@user, :notice => 'Utente aggiornato con successo') }
					format.xml  { head :ok }
				else
					format.html { render :text => params[:user].values[0].to_s}
				end
			else
				if(!params[:remote])
					format.html { render :action => "edit" }
					format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
				else
					format.html { render :text => "Il valore inserito non e' valido"}
				end
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
