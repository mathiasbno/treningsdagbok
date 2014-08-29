root = 'public'

use Rack::Static,
  urls:  Dir.glob("#{root}/*").map { |fn| fn.gsub(/#{root}/, '')},
  root:  root,
  index: 'index.html',
  header_rules: [[:all, {'Cache-Control' => 'public, max-age=3600'}]]

run lambda { |env|
  [
    404,
    {'Content-Type' => 'text/html', 'Content-Length' => '9'},
    ['Not Found']
  ]
}
