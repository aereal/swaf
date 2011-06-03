# encoding: ASCII-8BIT

require "forwardable"
require "swf_ruby"

[:DoActionDumper, :ReplaceTarget, :Jpeg2ReplaceTarget, :SpriteReplaceTarget,
:Lossless2ReplaceTarget, :AsVarReplaceTarget, :SpriteDumper, :SwfTamperer].each do |k|
	SwfRuby.const_set(k.to_s.gsub(/[a-z]+/, ''), SwfRuby.const_get(k))
end

require "swaf/version"

class Swaf
	extend Forwardable

	def self.load(doc)
		(swaf = self.new).load!(doc)
		swaf
	end

	def self.load_file(filename)
		(swaf = self.new).load!(
			File.binread(filename)
		)
		swaf
	end

	attr_reader :dumper
	def_delegators :@dumper, *[
		:header, :swf, :tags, :tags_addresses, :character_ids
	]

	def initialize
		@dumper = SwfRuby::SwfDumper.new
		@tamperer = SwfRuby::ST.new
	end

	def load!(swf)
		self.dumper.dump(swf)
	end

	def replace(params={})
		self.class.load(@tamperer.replace(
			@dumper.swf,
			params.map {|name, value| [name.to_s, value] }.
			inject([]) {|targets, (name, value)|
				SwfRuby::AVRT.build_by_var_name(@dumper, name).each {|t|
					t.str = value
				}
			}
		))
	end
end

