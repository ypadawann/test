require 'rubygems'
require 'active_record'
require 'mysql2'
require 'sinatra'
require 'sinatra/reloader'


ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection('development')

class Topic < ActiveRecord::Base
end

get '/' do
p 'hello world'
end

get '/topics' do
 topic = Topic.new
 topic.name = 'maki'
 topic.age = 15
 topic.save

 p 'topics'

end

get '/topics/:name/:age' do |n,a|
 topic = Topic.new

  topic.name = "#{n}"
  topic.age = "#{a}"
 topic.save

  p "topics/#{n}/#{a}"

end

get '/get/:name/:age' do |n,a|
  "get #{n} and #{a}"
end

get '/view' do
content_type:json, :charset => 'utf8'
topics = Topic.order("created_at DESC").limit(10)
# topics.to_json(:root => false)
p topics.to_s
end

get '/allview' do
  str = Topic.where(:name => "maki")
p str.name
end

get '/viewfile' do
 str = ""
 open('output3-3.txt','r') do |file|
  file.each do |line|
      str = "#{line}"
  end
 end
 p str
end

get '/testview' do
str = Topic.where(:age  => 18)
p str.all[2].name
end


get 'inprem/:id/:name' do |i,n|
topic = Topic.new
topic.id = "#{i}"
topic.name = "#{n}"
topic.save
end
