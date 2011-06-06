# encoding: ASCII-8BIT

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

	it "replace value of ActionScript's variable with specified value" do
		subject.replace(:_itemname => 'fugafuga').swf.should ==
			(prefix + 'samples/replaced_as_var.swf').binread
	end

	context "when detecting JPEG images" do
		let(:sample_jpg) {
			(prefix + 'samples' + 'fig.jpg').open('rb:ASCII-8BIT') {|f| f.read }
		}

		it "detect a image by ID" do
			#subject.find_jpeg(1).should == sample_jpg
			pending
		end
	end
end

