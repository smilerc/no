require 'sinatra'
require 'json'

class StableApp < Sinatra::Base
  set :port, ENV['PORT'] || 4567
  set :bind, '0.0.0.0'
  
  
  # Статические файлы
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :views, File.dirname(__FILE__) + '/views'
  
  # Главная страница
  get '/' do
    erb :index
  end
  
  # API статус
  get '/api/status' do
    content_type :json
    {
      status: 'stable',
      message: 'Stable version running',
      timestamp: Time.now.iso8601,
      version: '1.0.0'
    }.to_json
  end
  
  # Health check для Heroku
  get '/health' do
    'OK'
  end
  
  # 404 handler
  not_found do
    erb :not_found
  end
  
  # Error handler
  error do
    erb :error
  end
end