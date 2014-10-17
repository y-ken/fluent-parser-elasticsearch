require 'helper'

module ParserTest
  include Fluent

  def str2time(str_time, format = nil)
    if format
      Time.strptime(str_time, format).to_i
    else
      Time.parse(str_time).to_i
    end
  end
end

class ElasticsearchParserTest < Test::Unit::TestCase
  include ParserTest
  
  def setup
    TextParser.new
    @parser = TextParser::TEMPLATE_REGISTRY.lookup('elasticsearch').call
  end

  def test_call
    time, record = @parser.call('[2014-03-18 18:27:34,897][INFO ][http                     ] [es01] bound_address {inet[/0:0:0:0:0:0:0:0:9200]}, publish_address {inet[/10.0.0.185:9200]}')

    assert_equal(str2time('2014-03-18 18:27:34,897', '%Y-%m-%d %H:%M:%S,%L'), time)
    assert_equal({
      'log_level' => 'INFO',
      'log_type' => 'http',
      'node_name' => 'es01',
      'message' => 'bound_address {inet[/0:0:0:0:0:0:0:0:9200]}, publish_address {inet[/10.0.0.185:9200]}'
    }, record)
  end

  def test_call2

    time, record = @parser.call('[2014-10-17 15:24:37,229][WARN ][monitor.jvm              ] [James Proudstar] [gc][old][481][8] duration [15s], collections [1]/[15.4s], total [15s]/[23s], memory [7.3gb]->[4.6gb]/[7.9gb], all_pools {[young] [3.8mb]->[5.8mb]/[532.5mb]}{[survivor] [66.5mb]->[0b]/[66.5mb]}{[old] [7.2gb]->[4.6gb]/[7.3gb]}')

    assert_equal(str2time('2014-10-17 15:24:37,229', '%Y-%m-%d %H:%M:%S,%L'), time)
    assert_equal({
      'log_level' => 'WARN',
      'log_type' => 'monitor.jvm',
      'node_name' => 'James Proudstar',
      'message' => '[gc][old][481][8] duration [15s], collections [1]/[15.4s], total [15s]/[23s], memory [7.3gb]->[4.6gb]/[7.9gb], all_pools {[young] [3.8mb]->[5.8mb]/[532.5mb]}{[survivor] [66.5mb]->[0b]/[66.5mb]}{[old] [7.2gb]->[4.6gb]/[7.3gb]}'
    }, record)
  end

end

