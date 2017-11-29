require 'rubygems'
require 'sinatra/base'
require 'mysql2'
require 'dalli'


class App < Sinatra::Base

  get '/v1' do
    @data = db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")
    erb :data
  end






















  get '/v2' do
    @data = db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")

    db.query("update wikimedia_hits set hits= hits +1 where id = 1")

    erb :data
  end


















  get '/v3' do
    @data = db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10")

    periodically { db.query("update wikimedia_hits set hits= hits +50 where id = 1")}

    erb :data
  end

  def periodically(num=50)
    @@counter = (@@counter || 0) + 1
    yield if @@counter % num == 1
  end













  get '/v4' do
    @data = dalli.fetch(:top_hits, 10) do
      db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10").collect(&:to_hash)
    end

    periodically { db.query("update wikimedia_hits set hits= hits +1 where id = 1")}

    erb :data
  end

  def dalli
    @memcache ||= Dalli::Client.new
  end














  get '/v5' do
    @data = fetch_safe(:top_hits_safe, 10) do
      db.query("select code, count(*) as ct from wikimedia_hits group by 1 order by 2 desc limit 10").collect(&:to_hash)
    end
    periodically { db.query("update wikimedia_hits set hits= hits +1 where id = 1")}

    erb :data
  end















  def fetch_safe(key, ttl)
    result = dalli.get(key)
    @data, expire = result if result.is_a? Array
    if result.nil? or Time.now > expire
      if dalli.add("__lock_#{key}", 1, 30)
        @data = yield
        dalli.set(key, [@data, Time.now + ttl], ttl+60)
        dalli.delete("__lock_#{key}")
      else
        while true do
          result = dalli.get(key)
          if !result.nil?
            @data = result.first
            break
          end
          sleep 0.5
        end
      end
    end

    @data
  end












  @@counter = 0

  def db
    @client ||= Mysql2::Client.new(:username => "test", :password => "testpass", :database => "test")
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
