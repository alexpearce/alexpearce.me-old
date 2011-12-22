require 'bundler'

Bundler.require

require File.join File.dirname(__FILE__), '..', '/application.rb'

require 'rack/test'

set :environment, :test

def app
  AlexPearce
end

describe 'AlexPearce.me' do
  include Rack::Test::Methods
  
  it "should use the HTML 5 doctype" do
    get '/'
    last_response.body.should include('<!DOCTYPE html>')
  end
  
  it "should respond to the root route" do
    get '/'
    last_response.should be_ok
  end
  
  it "should respond to the work route" do
    get '/work'
    last_response.should be_ok
  end
  
  it "should respond to the projects route" do
    get '/projects'
    last_response.should be_ok
  end
  
  it "should respond to the contact route" do
    get '/contact'
    last_response.should be_ok
  end
  
  it "should respond with 404 on an unknown route" do
    get '/fake-route'
    last_response.status.should == 404
  end
  
  it "should fetch the Last.fm JSON" do
    get '/lastfm'
    last_response.content_type.should == 'application/json'
  end
  
  it "should not allow blank contact form submission" do
    post '/contact'
    last_response.body.should include('Please fill in all fields.')
  end
  
  it "should not allow contact form submission with a blank name" do
    post '/contact', params = {:name => '', :email => 'email@domain.tld', :message => 'Hello there!'}
    last_response.body.should include('Please fill in all fields.')
  end
  
  it "should not allow contact form submission with a blank email address" do
    post '/contact', params = {:name => 'Some Name', :email => '', :message => 'Hello there!'}
    last_response.body.should include('Please fill in all fields.')
  end
  
  it "should not allow contact form submission with a blank message" do
    post '/contact', params = {:name => 'Some Name', :email => 'email@domain.tld', :message => ''}
    last_response.body.should include('Please fill in all fields.')
  end
  
  # it "should allow form submission with valid details" do
  #   post '/contact', params = {:name => 'Some Name', :email => 'email@address.tld', :message => 'Hello there!'}
  #   last_response.body.should include('Email Sent. I\'ll get back to you shortly.')
  # end
  
  
end