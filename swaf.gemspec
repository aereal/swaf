# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "swaf/version"

Gem::Specification.new do |s|
	s.name        = "swaf"
	s.version     = Swaf::VERSION
	s.authors     = ["aereal"]
	s.email       = ["trasty.loose@gmail.com"]
	s.homepage    = "https://github.com/aereal/swaf"
	s.summary     = %q{more user-friendly interface for swf_ruby}

	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
	s.require_paths = ["lib"]

	devel_deps = {
		'bundler' => '~> 1.0.0',
		'rspec'   => '~> 2.6.0',
		'rake'    => '~> 0.9.0'
	}

	runtime_deps = {
		'swf_ruby' => '>= 0.2.0'
	}

	if s.respond_to? :add_runtime_dependency
		devel_deps.each do |gem, prereq|
			s.add_development_dependency gem, prereq
		end

		runtime_deps.each do |gem, prereq|
			s.add_runtime_dependency gem, prereq
		end
	else
		devel_deps.merge(runtime_deps).each do |gem, prereq|
			s.add_dependency gem, prereq
		end
	end
end

