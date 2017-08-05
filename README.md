# 実行手順
- 該当のディレクトリに移動して以下を実行
~~~
$ git clone https://github.com/peke2/chef_sample.git
$ cd chef_sample
$ sudo chef-solo -c solo.rb -j localhost.json
~~~

`solo.rb`の内容は、Vagrant上での実行を想定しているので、他の環境で実行する場合は編集が必要。
