require 'spec_helper'

describe "PasswordResets" do
	subject { page }
	before { visit reset_password_path }

	describe "GET password_rests#new" do
		it { should have_content("Reset password") }
	end

	describe "submit email to reset password" do
		context "when invalid" do
			let(:unsaved_user) { FactoryGirl.build(:user) }
			before do
				fill_in "Email", with: unsaved_user.email
				click_button "Reset"
			end

			it "doesn't send an email" do
				last_email_sent.should be_nil
			end

			it "says it sent email" do
				should have_selector('div.flash_notice')
			end
		end

		context "when valid" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email", with: user.email
				click_button "Reset"
			end

			it "should send an email to user" do
				last_email_sent.to.should include(user.email)
				current_path.should eq(root_path)
				should have_content("sent")
			end
		end
	end

	describe "set new password" do
		let(:user) { FactoryGirl.create(:user, password_reset_token: "whatever", password_reset_sent_at: Time.zone.now) }
		before do
			visit edit_password_reset_path(user.password_reset_token)
			fill_in "Password", with: "foobar"
			fill_in "confirmation", with: "foobar"
		end

		it { should have_selector('input#user_password') }
		it { should have_selector('input#user_password_confirmation') }
		
		it "reports error when token expired" do
			user.password_reset_sent_at = 5.hours.ago
			user.save(validate: false)
			click_button "Update"
			should have_content("expired")
		end

		it "updates user password when valid" do
			click_button "Update"
			should have_content("Successfully")
			user.reload
			user.authenticate("foobar").should be_true
		end

		#may be overkill...
		it "raises exception when token invalid" do
			expect { visit edit_password_reset_path("invalid") }.to raise_error(ActiveRecord::RecordNotFound)
		end

	end
end
