require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'gossip'


class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/new/' do
  	erb :new_gossip
  end

  post '/gossips/new/' do
  	puts "dans le serveur"
  	Gossip.new(params["gossip_author"], params["gossip_content"]).save
  	redirect '/'
  end

  get '/gossips/:id/' do
		erb :show, locals: { gossip: Gossip.find(params[:id]) }
	end

	get '/gossips/:id/edit/' do
		# binding.pry
		erb :edit, locals: { gossip: Gossip.find(params[:id]) }
	end


	post '/gossips/:id/edit/' do
	  puts "édité dans le serveur"
	  Gossip.new(params["gossip_author"], params["gossip_content"]).edit(params["id_save"])

	  redirect '/'
	  end

end