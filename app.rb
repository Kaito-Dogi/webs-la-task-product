require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'json'
require 'net/http'
require 'sinatra/activerecord'
require './models'
require 'dotenv/load'

enable :sessions

get '/' do
    @posts = Post.all
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
        image_url = "./upload/#{params[:file][:filename]}"
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
    unless session[:user]
        redirect '/'
    end
    erb :search
end

post '/search' do
    uri = URI("https://itunes.apple.com/search")
    uri.query = URI.encode_www_form({
        term: params[:keyword],
        limit: params[:limit]
    })
    res = Net::HTTP.get_response(uri)
    json = JSON.parse(res.body)
    @musics = json["results"]
    erb :search
end

post '/post' do
    Post.create(
        user_id: session[:user],
        image_url: params[:image_url],
        artist_name: params[:artist_name],
        collection_name: params[:collection_name],
        track_name: params[:track_name],
        preview_url: params[:preview_url],
        comment: params[:comment],
    )
    redirect '/mypage'
end

get '/mypage' do
    unless session[:user]
        redirect '/'
    end
    
    @user = User.find(session[:user])
    erb :mypage
end

get '/delete/:id' do
    _post = Post.find(params[:id])
    unless session[:user] && session[:user] == _post.user.id
        redirect '/mypage'
    end
    _post.destroy
    redirect '/mypage'
end

get '/edit/:id' do
    @post = Post.find(params[:id])
    unless session[:user] && session[:user] == @post.user.id
        redirect '/mypage'
    end
    erb :edit
end

post '/edit/:id' do
    _post = Post.find(params[:id])
    _post.comment = params[:comment]
    _post.save
    redirect '/mypage'
end

get '/favorite/:post_id' do
    unless session[:user]
        redirect '/'
    end
    
    # 既に保存されていないか確認．
    if Favorite.find_by(post_id: params[:post_id]).nil?
        Favorite.create(
            user_id: session[:user],
            post_id: params[:post_id]
        )
    end
    
    redirect '/'
end