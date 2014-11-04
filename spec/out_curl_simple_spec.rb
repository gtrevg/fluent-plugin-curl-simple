# encoding: UTF-8
require_relative 'spec_helper'
require 'benchmark'
Fluent::Test.setup

def create_driver(config, tag = 'foo.bar')
  Fluent::Test::OutputTestDriver.new(Fluent::CurlSimpleOutput, tag).configure(config)
end

# setup

record = {
  'msg'            => 'testing some data',
  'chars'          => 'let"s put !@#$%^&*()-= some weird :\'?><,./ characters',
  'dt'             => '2014/04/03T07:02:11.124202',
  'debug_line'     => 24,
  'debug_file'     => '/some/path/to/myFile.py',
  'statsd_key'     => 'fluent_plugin_curl_simple',
  'statsd_timing'  => 0.234,
  'statsd_type'    => 'timing',
  'tx'             => '280c3e80-bb6c-11e3-a5e2-0800200c9a66',
  'host'           => 'my01.cool.server.com'
}

time = Time.now.to_i

driver_basic = create_driver(%[
  server          http://127.0.0.1
  data_key        body
  ssl_verify_peer false
  verbose         true
])

# bench
n = 10000
Benchmark.bm(7) do |x|
  x.report("driver") { driver.run  { n.times { driver.emit( record, time) } } }
end
