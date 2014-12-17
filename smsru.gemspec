# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smsru/version'

Gem::Specification.new do |spec|
  spec.name          = "smsru"
  spec.version       = Smsru::VERSION
  spec.authors       = ["Sergey Alekseenko"]
  spec.email         = ["alekseenkoss@gmail.com"]
  spec.description   = %q{Gem for sms.ru service}
  spec.summary       = %q{Generators}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency 'vcr', '~> 2.9.2'
  spec.add_development_dependency 'webmock', '~> 1.18.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency "rails", '~> 4.1'
  spec.add_development_dependency "rspec-rails", "~> 3.1.0"
end
