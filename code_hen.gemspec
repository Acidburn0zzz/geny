lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "code_hen/version"

Gem::Specification.new do |spec|
  spec.name          = "code_hen"
  spec.version       = CodeHen::VERSION
  spec.authors       = ["Ray Zane"]
  spec.email         = ["raymondzane@gmail.com"]

  spec.summary       = %q{The only tool you need to build a code generator.}
  spec.homepage      = "https://github.com/rzane/code_hen"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "slop", "~> 4.7.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
