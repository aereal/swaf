# encoding: utf-8

require "pathname"
require "swaf"

describe Swaf do
	let(:prefix)     { Pathname(__FILE__).expand_path.parent }
	let(:swf_file)   { prefix + 'samples' + 'mock.swf' }
	let(:swf_dumper) { SwfRuby::SwfDumper.new }

	before do
		swf_dumper.open(swf_file)
	end

	subject do
		Swaf.load_file(swf_file)
	end

	it "has header of SWF" do
		subject.header.should == swf_dumper.header
	end
end

