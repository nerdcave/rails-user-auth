require 'spec_helper'

describe "SessionPages" do
	subject { page }

	describe "GET sign_in" do
		before { visit sign_in_path }
		it { should have_content('Sign in') }
	end

	describe "signing in" do

		context "as valid user" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				visit sign_in_path
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
			end

			context "then signing out" do
				before do
					click_button "Sign in"
					click_link("Sign out")
				end
				it { should have_link("Sign in") }
			end

			context "with remember me" do
				before do
					find(:css, "input#remember_me").set(true)
					click_button "Sign in"
					#check cookie?
				end

				it { should have_link("Sign out") }
			end

		end


		context "as invalid user" do
			before do
				visit sign_in_path
				click_button "Sign in"
			end

			it { should have_selector("div.flash_alert") }

		end
	end


	describe "visiting secure page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			visit new_post_path
			fill_in "Email", with: user.email
			fill_in "Password", with: user.password
		end

		it "should redirect to previous url upon signing in" do
			click_button "Sign in"
			#should have_content("Successfully")
			current_path.should eq(new_post_path)
		end
	end

end
