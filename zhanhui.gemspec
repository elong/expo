lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |spec|
  spec.name = "zhanhui"
  spec.version = "0.0.0.1"
  spec.authors = ["ChienliMa"]
  spec.email = ["maqianlie@gmail.com"]
  spec.summary = %q{Crawler for: www.haozhanhui.com }
  spec.homepage = "http://github.com/ChienliMa/zhanhui"
  spec.license = "GUN"

  spec.require_paths = [ 'lib' ]

  spec.add_runtime_dependency("nokogiri", [">= 1.3.3"])
end