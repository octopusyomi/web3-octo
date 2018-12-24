lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'web3/octo/version'

Gem::Specification.new do |spec|
  spec.name          = 'web3-octo'
  spec.version       = Web3::Octo::VERSION
  spec.authors       = ['Octopus Yomi']
  spec.email         = ['octopusbrat@gmail.com']

  spec.summary       = 'Test gem for parsing ethereum node'
  spec.description   = 'Test gem for parsing ethereum node'
  spec.homepage      = 'https://github.com/octopusyomi/eth-octo'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_dependency('digest-sha3', '~> 1.1.0')
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency('rlp', '~> 0.7.3')

end
