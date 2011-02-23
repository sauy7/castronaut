include Castronaut::Presenters

get '/' do
  redirect '/login'
end

get '/login' do
  no_cache
  present! Login
end

post '/login' do
  present! ProcessLogin
end

get '/logout' do
  present! Logout
end

get '/serviceValidate' do
  @format = 'xml'
  present! ServiceValidate
end

get '/proxyValidate' do
  @format = 'xml'
  present! ProxyValidate
end

private

def no_cache
  response.headers.merge!(
    'Pragma' => 'no-cache',
    'Cache-Control' => 'no-store',
    'Expires' => (Time.now - 5.years).rfc2822
  )
end

def present!(klass)
  @format ||= 'html'
  @presenter = klass.new(self)
  @presenter.represent!
  @presenter.your_mission.call
end
