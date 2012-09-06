# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  email_verified         :boolean          default(FALSE)
#  auth_token             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

require 'spec_helper'

describe User do
	let(:user) { Factory.build(:user) }
	subject { user }

	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:email_verified) }
	it { should respond_to(:auth_token) }
	it { should respond_to(:password_reset_token) }
	it { should respond_to(:password_reset_sent_at) }

	it { should respond_to(:posts) }

	it { should be_valid }

	describe "email field" do
		context "when blank" do
			before { user.email = " " }
			it { should_not be_valid }
		end

		context "when invalid format" do
			it "should be invalid" do
				addresses = %w(user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com)
				addresses.each do |invalid_address|
					user.email = invalid_address
					should_not be_valid
				end
			end
		end

		context "when not unique" do
			before do
				other_user = user.dup
				other_user.save!
			end
			it { should_not be_valid }
		end
	end

	describe "password field" do
		context "when blank" do
			before { user.password = user.password_confirmation = " " }
			it { should_not be_valid }
		end

		context "when doesn't match confirmation" do
			before { user.password_confirmation = "nofoo4u" }
			it { should_not be_valid }
		end

		# context "when confirmation is nil" do
		# 	before { user.password_confirmation = nil }
		# 	it { should_not be_valid }
		# end
	end

	describe "password reset" do
		before { user.send_password_reset }

		it "generates unique password_reset_token each time" do
			last_token = user.password_reset_token
			user.send_password_reset
			user.password_reset_token.should_not eq(last_token)
		end

		it "saves the time the password reset was sent" do
		end

		specify { last_email_sent.to.should include(user.email) }

	end
end
