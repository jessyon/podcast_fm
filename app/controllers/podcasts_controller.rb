class PodcastsController < ApplicationController
	before_action :find_podcast, only: [:show, :dashboard]
	before_action :find_episode, only: [:show, :dashboard]

	def index
		@podcasts = Podcast.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 4)

	end


	def show
		
	end


	def dashboard
		
	end

# There is no detroy and edit and update create method, so no need to authenticate
# People only can use show and index and I don't what dashboard method is !it is like show method i guess

	private


	def find_episode
		@episodes = Episode.where(podcast_id: @podcast).order("created_at DESC").paginate(:page => params[:page] , :per_page => 5)
	end

	def find_podcast
		if params[:id].nil?
			@podcast = current_podcast
		else
			@podcast =Podcast.find(params[:id])
		end
	end


end
