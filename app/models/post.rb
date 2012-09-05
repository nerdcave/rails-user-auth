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

class Post < ActiveRecord::Base
	attr_accessible :body, :title

	validates :title, presence: true, length: { maximum: 255 }
	validates :body, presence: true
	validates :user_id, presence: true

	#default_scope order: 'posts.created_at DESC'

	belongs_to :user

end
