class Comment < ApplicationRecord
  belongs_to :commenter, class_name: 'User'
  belongs_to :post

    #validations 
    validates_presence_of :text, :commenter_id, :post_id
end
