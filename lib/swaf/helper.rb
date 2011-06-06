# encoding: ASCII-8BIT

# TODO: refactoring
module ::Kernel
	def jpeg(file)
		[:jpeg, File.binread(file)]
	end
	alias_method :jpg, :jpeg

	def png(file)
		[:png, File.binread(file)]
	end

	def gif(file)
		[:gif, File.binread(file)]
	end
end

