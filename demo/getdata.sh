wget http://dumps.wikimedia.org/other/pagecounts-raw/2013/2013-01/pagecounts-20130101-000000.gz

zcat pagecounts-20130101-000000.gz > /usr/shrae/mysql/wikimedia_hits.ssv
