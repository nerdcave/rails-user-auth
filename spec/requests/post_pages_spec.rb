require 'spec_helper'

describe "PostPages" do
	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	it { should have_content("your posts") }

	context "when not signed in" do

		it "should redirect to sign_in_path" do
			click_link "Sign out"
			visit posts_path
			current_path.should eq(sign_in_path)
		end

	end

	describe "delete a post" do
		before do
			user.posts.create(title: "title", body: "body")
			visit posts_path
		end

		context "as a valid user" do
			it "should delete post" do
				expect { click_link "delete" }.to change(user.posts, :count).by(-1)
			end
		end

		context "as an invalid user" do
			let(:other_user) { FactoryGirl.create(:user) }
			let(:other_user_post) { FactoryGirl.create(:post, user: other_user) }

			it "should not delete post" do
				expect { delete post_path(other_user_post) }.to raise_error(ActiveRecord::RecordInvalid)
			end
		end
	end

	describe "create a post" do
		before { visit new_post_path(user) }

		context "with valid fields" do
			before do
				fill_in "Title", with: "Post title"
				fill_in "Body", with: "Post body"
			end

			it "should create a new post" do
				expect { click_button "Create" }.to change(Post, :count).by(1)
				current_path.should eq(posts_path)
			end
		end

		context "with invalid fields" do
			it "shouldn't create a post" do
				expect { click_button "Create" }.not_to change(Post, :count)
				should have_selector("div.errors")
				#current_path.should eq(new_post_path)
			end
		end

	end
end
