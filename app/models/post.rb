class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: 'User'

  #validations 
  validates_presence_of :title, :body, :author_id
end
