Gem::Specification.new do |spec|
  spec.name          = 'faraday-logstasher'
  spec.version       = '0.1.0'
  spec.authors       = ['Lucas Mazza', 'Martin Troels Eberhardt']
  spec.email         = ['opensource@plataformatec.com.br', 'mte@unity3d.com']

  spec.summary       = 'A Log Subscriber for Faraday clients'
  spec.description   = 'A Log Subscriber for Faraday clients'
  spec.homepage      = 'https://github.com/UnityTech/faraday-logstasher'

  spec.files         = Dir['LICENSE', 'README.md', 'lib/**/*']
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']
  spec.executables   = []

  spec.add_dependency 'faraday', '~> 0.8'
  spec.add_dependency 'faraday_middleware', '~> 0.9'
  spec.add_dependency 'actionpack', '>= 4.0.0'
  spec.add_dependency 'logstasher'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-utils'
end
