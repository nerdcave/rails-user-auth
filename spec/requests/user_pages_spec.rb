require 'spec_helper'

describe "UserPages" do
	subject { page }

	describe "GET sign_up" do
		before { visit register_path }
		it { should have_content('Register') }
	end

	describe "POST users#create" do
		context "with invalid fields" do
			before do
				visit register_path
				click_button "Create"
			end
			it { should have_selector('div.errors') }
		end

		context "with valid fields" do
			before do
				visit register_path
				fill_in "E-mail", with: "test@whatever.com"
				fill_in "Password", with: "secret"
				fill_in "confirmation", with: "secret"
			end

			it "should create user" do
				expect { click_button "Create" }.to change(User, :count).by(1)
			end

			it "should redirect to posts#index" do
				click_button "Create"
				current_path.should eq(posts_path)
				should have_content("your posts")
			end

			it "should have sign out link" do
				click_button "Create"
				should have_link("Sign out")
			end
		end
	end
end
