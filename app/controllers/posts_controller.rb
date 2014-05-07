get '/add_post' do
  if session["id"].nil?
    redirect '/'
  else
    erb :new_post
  end
end

post '/add_post' do
  @post = Post.create(:title => params[:title], :content => params[:content], :url => params[:url])
  User.find(session["id"]).posts << @post
  redirect '/profile/' + session["id"].to_s
end

get '/posts/:id/comments' do
  @post = Post.find(params[:id])
  @comments = @post.comments
  @users =
  erb :comments
end

delete '/delete_post/:id' do
  Post.find(params[:id]).delete
  redirect '/profile'
end
