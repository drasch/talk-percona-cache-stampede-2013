require 'mysql2'

client = Mysql2::Client.new(:database => "test")

client.query("drop table if exists wikimedia_hits");
client.query("create table wikimedia_hits (id integer primary key auto_increment not null, code char(7) not null, pagename varchar(255), hits integer not null, size integer not null, index by_code (code)) engine=InnoDB");

puts `mysqlimport -v --columns=code,pagename,hits,size --fields-terminated-by=" " test /usr/share/mysql/wikimedia_hits.ssv`
