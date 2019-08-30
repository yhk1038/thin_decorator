lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "thin_decorator/version"

Gem::Specification.new do |spec|
  spec.name          = "thin_decorator"
  spec.version       = ThinDecorator::VERSION
  spec.authors       = ["Yonghyun Kim (Fred)"]
  spec.email         = ["yhkks1038@gmail.com"]

  spec.summary       = 'Light, Thin Decorator based on pure ruby'
  spec.description   = 'Light, Thin Decorator based on pure ruby'
  spec.homepage      = "https://github.com/yhk1038/thin_decorator/tree/master"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yhk1038/thin_decorator/tree/master"
  spec.metadata["changelog_uri"] = "https://github.com/yhk1038/thin_decorator/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "activesupport", "~> 6.0.0"
  spec.add_development_dependency "coveralls", "~> 0.8.0"
end
