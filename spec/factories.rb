FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "jay#{n}@nerdcave.com"}
		password "secret"
		password_confirmation { |u| u.password }
	end
end