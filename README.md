# Percona University 2013

## dependencies
<pre>
$ gem install bundler
$ bundle install
</pre>

## see slides
<pre>
$ showoff serve
</pre>


## try demo
<pre>
$ cd demo
$ vagrant up #only need to do this once
$ vagrant ssh #this gets you an ssh session to your vm
</pre>

### run the app
monitoring the processlist
<pre>
vagrant:$ watch 'mysql -u root -A -e "show processlist"  | cut -f 6,7,8 | grep -v NULL' 
</pre>



### running the tests and generating load
<pre>
vagrant:$ httping -g http://0:4567/v1
# in a separate window
vagrant:$ ab -c 5 -n 1000 http://0:4567/v1
</pre>

watch the timings, try again with v1 through v5


## destroying the vm
<pre>
$ vagrant destroy
</pre>`
