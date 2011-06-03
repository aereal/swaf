# encoding: utf-8

require "forwardable"
require "swf_ruby"

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
	end

	def load!(swf)
		self.dumper.dump(swf)
	end
end

