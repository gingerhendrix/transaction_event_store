# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transaction_event_store/version'

Gem::Specification.new do |spec|
  spec.name          = "transaction_event_store"
  spec.version       = TransactionEventStore::VERSION
  spec.authors       = ["Gareth Andrew"]
  spec.email         = ["gingerhendrix@gmail.com"]

  spec.summary       = %q{Event Store for ruby with support for concurrent writers and snapshots}
  spec.description   = %q{Event Store for ruby with support for concurrent writers and snapshots}
  spec.homepage      = "https://github.com/gingerhendrix/transaction_event_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "ruby_event_store", "~> 0.13.0"
end
