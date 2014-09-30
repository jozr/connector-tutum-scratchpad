# encoding: UTF-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'factor-connector-timer'
  s.version       = '0.0.1'
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Maciej Skierkowski']
  s.email         = ['maciej@factor.io']
  s.homepage      = 'https://factor.io'
  s.summary       = 'Timer Factor.io Connector'
  s.files         = ['lib/factor/connector/timer.rb']
  
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rufus-scheduler', '~> 3.0.9'
  s.add_runtime_dependency 'factor-connector-api', '~> 0.0.1'
end