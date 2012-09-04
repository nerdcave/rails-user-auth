module Utilities
	def last_email_sent
		ActionMailer::Base.deliveries.last
	end

	def reset_email
		ActionMailer::Base.deliveries = []
	end
end