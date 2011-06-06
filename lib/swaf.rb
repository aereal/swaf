# encoding: ASCII-8BIT

require "forwardable"
require "swf_ruby"

require "swaf/version"
require "swaf/helper"

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
		@tamperer = SwfRuby::SwfTamperer.new
	end

	def load!(swf)
		self.dumper.dump(swf)
	end

	def detect(id)
		if t = @dumper.tags.each_with_index.find {|t, i| t.character_id == id }
			@dumper.tags_addresses[t[1]]
		end
	end
	alias_method :find, :detect

	def replace(params={})
		self.class.load(@tamperer.replace(@dumper.swf, params.inject([]) {|targets, (k, v)|
			targets << make_target(k, v)
		}))
	end

	private
	def make_target(key, value)
		case key
		when Symbol
			SwfRuby::AsVarReplaceTarget.build_by_var_name(@dumper, key.to_s).each {|t|
				t.str = value
			}.first
		when Integer
			case value.first
			when :jpeg
				SwfRuby::Jpeg2ReplaceTarget.new(detect(key), value.last)
			when :gif, :png
				SwfRuby::Lossless2ReplaceTarget(detect(key), value.last)
			when :movie
				# TODO
			end
		end
	end
end

