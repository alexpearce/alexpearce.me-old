class AlexPearce < Sinatra::Base
  
  set :gtalk,  'http://www.google.com/talk/service/badge/Show?tk=z01q6amlqnf4hducke7e7q8ati7ueb44v5fcu4cabfrlqb7b80e3pdjkej1a3nfri87556g269nn1bk4qhd07udf6s6utfgjtpscjavtf7nkbu4o2ga42dbvk6m1qqiv26g23ggs3nk3bjm95qpgn9ehggenvnegqerdj1u0n'
  set :lastfm, "http://ws.audioscrobbler.com/2.0/?method=user.getRecentTracks&limit=1&page=1&api_key=#{ENV['LASTFM_KEY']}&user=boba899&format=json"
  
  set :haml, :format => :html5, :attr_wrapper => '"'

  get '/' do
    haml :index
  end

  get '/work' do
    haml :work
  end

  get '/projects' do
    haml :projects
  end

  get '/contact' do
    haml :contact
  end

  post '/contact' do
    unless params[:name].blank? or params[:email].blank? or params[:message].blank?
      status = Pony.mail(
        :to => 'alex@alexpearce.me',
        :via => :smtp, :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'alex@alexpearce.me',
          :password             => ENV['GMAIL_PW'],
          :authentication       => :plain
        },
        :subject => "Message from #{params[:name]}",
        :body => params[:message],
        :headers => { 'Reply-To' => params[:email] }
      )
      @success = status.blank? ? false : true
      # clear the params if successful so they don't show up on the form
      params[:name] = params[:email] = params[:message] = '' if @success
    else
      @success = false
    end
    haml :contact
  end

  # "api"
  get '/lastfm' do
    require 'open-uri'
    content_type :json
    open(settings.lastfm)
  end

  # error pages
  not_found do
    haml :'404', :layout => false
  end

  error do
    haml :'500'
  end

  # helpers
  helpers do
    # persists form values on invalid submits
    def form_value(val)
      val.blank? ? '' : val
    end
  
    # compares the string with the current route, determining
    # if the nav li should be highlighted
    def nav_class(route)
      route == request.route ? 'current' : ''
    end
  
    # finds out if I'm on Google talk
    def is_online
      require 'open-uri'
      badge = open(settings.gtalk)
      badge.read.match /Available/
    end
  end

end