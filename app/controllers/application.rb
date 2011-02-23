include Castronaut::Presenters

def path_regex path
  /^\/#{path}(\.json)?$/
end

get '/' do
  redirect '/login'
end

get(path_regex 'login') do |extension|
  no_cache
  present! Login, view_format(extension)
end

post(path_regex 'login') do |extension|
  present! ProcessLogin, view_format(extension)
end

get(path_regex 'logout') do |extension|
  present! Logout, view_format(extension)
end

get(path_regex 'serviceValidate') do |extension|
  present! ServiceValidate, view_format(extension, :xml)
end

get(path_regex 'proxyValidate') do |extension|
  present! ProxyValidate, view_format(extension, :xml)
end

private

def view_format(extension, default = :html)
  extension && extension.delete('.').to_sym || default
end

def no_cache
  response.headers.merge!(
    'Pragma' => 'no-cache',
    'Cache-Control' => 'no-store',
    'Expires' => (Time.now - 5.years).rfc2822
  )
end

def present!(klass, format = :html)
  @presenter = klass.new(self, format)
  @presenter.represent!
  @presenter.your_mission.call
end
