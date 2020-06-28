class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy
  belongs_to :author, class_name: 'User'

  #validations 
  validates_presence_of :title, :body, :author_id
  validate :at_least_one_tag

  private
  def at_least_one_tag
    # when creating a new post: making sure at least one tag exists
    return errors.add :base, "Must have at least one Tag" unless tags.length > 0

    # when updating an existing post: Making sure that at least one tag would exist
    return errors.add :base, "Must have at least one Tag" if tags.reject{|tag| tag._destroy == true}.empty?
  end   
end
