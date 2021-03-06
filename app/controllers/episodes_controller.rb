class EpisodesController < ApplicationController
before_action :authenticate_podcast!, except: [:show]
before_action :view_only_my_account, except: [:show]
before_action :find_podcast
before_action :find_episode, only: [:show, :edit, :update, :destroy]

	
	def new
			@episode = @podcast.episodes.new
	end


	def create
			@episode = @podcast.episodes.new episode_params	
			if @episode.save
			redirect_to podcast_episode_path(@podcast, @episode)
			else 
			render 'new'
			end	
	end


	def show
		@episodes =  Episode.where(podcast_id: @podcast).order("created_at DESC").paginate(:page => params[:page], :per_page => 3)
		# .reject {|e| e.id == @episode.id}

	end

	def edit
		
	end


	def update
		if @episode.update episode_params
			redirect_to podcast_episode_path(@podcast, @episode), notice: "Episode was succesfully updated!"
		else
		render 'edit'
		end
	end

	def destroy
		@episode.destroy
		redirect_to root_path
	end





	private

		def episode_params
			params.require(:episode).permit(:title, :description, :episode_thumbnail, :mp3)
		end
	
		def find_podcast
			@podcast = Podcast.find(params[:podcast_id])
		end

	# def find_podcast
	# 	if params[:id].nil?
	# 		@podcast = current_podcast
	# 	else
	# 		@podcast =Podcast.find(params[:id])
	# 	end
	# end

		

		def find_episode
			@episode = Episode.find(params[:id])
		end

		def view_only_my_account
			# episode's field podcast_id should match podcast id to view only my podcast id.
			@podcast = Podcast.find(params[:podcast_id])
			if current_podcast != @podcast
				redirect_to root_path, notice: "Sorry, you are not allowed to view that page !"
				# root_path of current_podcast id 
			end
		end

	
end
