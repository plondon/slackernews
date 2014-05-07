get '/' do
  @posts = Post.all.reverse.take(10)
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  #@username = params[:username]
  @email = params[:email]
  @password = params[:password]
  @user = User.where(email: @email).first
  if @user.nil?
    @messages = ["No user with that email!"]
    erb :login
  else
    if @user.password == @password
      session[:id] = @user.id
      erb :profile
    else
      @message = ["That was not the correct password for that email!"]
      erb :login
    end
  end
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  @username = params[:username]
  @email = params[:email]
  @password = params[:password]

  @user = User.create(username: @username, email: @email, password: @password)
  if @user.valid?
    redirect '/login'
  else
    @messages = @user.errors.full_messages
    erb :sign_up
  end
end

get '/profile' do
  @user = User.find(session["id"])
  erb :profile
end

get '/logout' do
  session.destroy
  p session.inspect
  redirect to '/'
end
