require 'rubygems'
require 'sinatra'
require 'mysql2'

helpers do
  def db
    @client ||= Mysql2::Client.new(:database => "test")
  end
end

get '/v1' do
  @data = db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")
  #@client.query("update wikimedia_hits set hits = hits+1 where id = 1")

  erb :data
end

get '/hit' do
  db.query("update wikimedia_hits set hits= hits +1 -1 where id = 1")
end

