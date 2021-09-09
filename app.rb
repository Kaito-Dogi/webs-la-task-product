require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require './models'
require 'dotenv/load'

enable :sessions

get '/' do
    erb :index
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        puts session.to_hash
    end
    redirect '/search'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/signup' do
    erb :signup
end

post '/signup' do
    image_url = nil
    if params[:file]
        # 画像を保存するパスを指定．
        image_url = "./user_images/#{params[:file][:filename]}"
        # 画像の実体を読み込み，保存．
        File.open("./public/#{image_url}", 'wb') do |f|
          f.write(params[:file][:tempfile].read)
        end
    end
    
    # 新規ユーザーの登録．
    user = User.create(
        name: params[:name],
        image_url: image_url,
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    )
    if user.persisted?
        session[:user] = user.id
    end
    redirect '/search'
end

get '/search' do
    erb :search
end