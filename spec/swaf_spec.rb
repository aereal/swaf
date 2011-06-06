# encoding: ASCII-8BIT

require "pathname"
require "swaf"

describe Swaf do
	let(:prefix)     { Pathname(__FILE__).expand_path.parent }
	let(:swf_file)   { prefix + 'samples' + 'mock.swf' }

	subject do
		Swaf.load_file(swf_file)
	end

	context "when detecting tags" do
		let(:jpg_offset) { 1370 }

		it "detect a offset of a JPEG image by ID" do
			subject.detect(1).should == jpg_offset
		end
	end

	context "when replacing objects" do
		let(:jpeg_replaced_swf) {
			(prefix + 'samples' + 'jpeg_replaced.swf').binread
		}
		let(:new_image) {
			prefix + 'samples' + 'another_fig.jpg'
		}
		let(:as_var_replaced_swf) {
			(prefix + 'samples' + 'replaced_as_var.swf').binread
		}

		it "replace JPEG images with specified JPEG image" do
			subject.replace(1 => jpeg(new_image))
		end

		it "replace value of ActionScript's variable with specified value" do
			subject.replace(:_itemname => 'fugafuga').swf.should == as_var_replaced_swf
		end

		it "replace movie-clips with specified ones" do
			pending
		end
	end
end

