require 'sinatra'
require 'mysql2'
client = Mysql2::Client.new(:database => "test")

get '/' do
  client.query("select sql_no_cache  code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")
end


