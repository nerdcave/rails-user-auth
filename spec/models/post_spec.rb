# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  body       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Post do
	let(:user) { FactoryGirl.create(:user) }
	before { @post = user.posts.build(title: "Post title", body: "Post body " * 10) }

	subject { @post }

	it { should respond_to(:title) }
	it { should respond_to(:body) }

	it { should respond_to(:user) }

	it { should be_valid }

	describe "accessible attributes" do
		it "shouldn't allow access to user_id" do
			expect do
				@post.update_attributes(user_id: 5)
			end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
		end
	end

	context "when user_id not present" do
		before { @post.user = nil }
		it { should_not be_valid }
	end

	context "when title is blank" do
		before { @post.title = "" }
		it { should_not be_valid }
	end

	context "when body is blank" do
		before { @post.body = "" }
		it { should_not be_valid }
	end


end