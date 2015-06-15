# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'query_bundle/version'

Gem::Specification.new do |spec|
  spec.name          = "query_bundle"
  spec.version       = QueryBundle::VERSION
  spec.authors       = ["Faraz Yashar"]
  spec.email         = ["faraz.yashar@gmail.com"]

  spec.summary       = "Batch Active Record queries: save trips to your DB"
  spec.description   = "Batch Active Record queries and save trips to your DB."
  spec.homepage      = "https://github.com/fny/query_bundle"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"

  spec.add_dependency 'pg', '~> 0.18.2'
  spec.add_dependency 'activerecord', '~> 4.2.1'
end
