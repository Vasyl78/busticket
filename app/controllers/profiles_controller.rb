class ProfilesController < ApplicationController

	before_action  :find_profile, only: [:show, :edit, :update, :destroy, :upvote]

  def profile
  	@profile
  end

  def new
  	@profile = Profile.new(user_id: current_user.id)
  end

  def edit
   	
  end
  def show
    
  end

  def create
  	@profile = Profile.create(profile_params)
  	if @profile.errors.empty?
		redirect_to profile_path(@profile)
	else
		render "new"
	end  	
  end
  
  def update
  	@profile.update_attributes(profile_params)
	if @profile.errors.empty?
		flash.now[:success] = "Profile successfully updated!"
		redirect_to profile_path
	else
		flash.now[:error] = "You made mistakes in your form! Please correct them."
		render "edit"
	end  	
  end

  def destroy
  	@profile.destroy
	redirect_to action: "index"  	
  end

  private

  def find_profile
		@profile = current_user.profile
		render_404 unless @profile		
  end

  def profile_params
		params.require(:profile).permit(:first_name, :last_name, :phone_number)
		
  end
end	