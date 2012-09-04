FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "jay#{n}@nerdcave.com"}
		password "secret"
		password_confirmation { |u| u.password }
	end

	factory :post do
		title = "Title post"
		body = "Some long post body " * 10
		user
	end
end