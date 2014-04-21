# Fluentd Parser for elasticsearch

[Fluentd](http://fluentd.org/) Parser Plugin to add choice for `format` option for elasticsearch logs with `in_tail` plugin.

## Installation

install with `gem` or `fluent-gem` command as:

```bash
# for fluentd
$ gem install fluent-parser-elasticsearch

# for td-agent
$ sudo /usr/lib64/fluent/ruby/bin/fluent-gem install fluent-parser-elasticsearch
```

## Usage

After installing this plugin, it has got ready to use this 3rd party format like below.

```xml
<source>
  type     tail
  tag      elasticsearch.general_log
  format   elasticsearch
  path     /var/log/elasticsearch/elasticsearch.log
  pos_file /var/log/td-agent/elasticsearch.log.pos
</source>

<match elasticsearch.*>
  type     stdout
</match>
```

## TODO

Pull requests are very welcome!!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright (c) 2014- Kentaro Yoshida (@yoshi_ken)

## License

Apache License, Version 2.0
