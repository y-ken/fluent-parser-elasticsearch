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
end

