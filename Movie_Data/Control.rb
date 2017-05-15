require_relative "Validate.rb"
class Control
	def initialize()
		@validate = Validate.new()
	end
	def run()
		puts Time.now
		@validate.validate
		puts Time.now
	end
end
control = Control.new()
control.run