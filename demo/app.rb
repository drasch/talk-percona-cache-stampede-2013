require 'rubygems'
require 'sinatra'
require 'mysql2'


get '/' do
  @client ||= Mysql2::Client.new(:database => "test")

  @data = @client.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")
  #@client.query("update wikimedia_hits set hits = hits+1 where id = 1")

  erb :data
end

















get '/hit' do
  @client ||= Mysql2::Client.new(:database => "test")

  @client.query("update wikimedia_hits set hits= hits +1 -1 where id = 1")
end

