require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure user model has a 1:m relationship with the post model
  it { should have_many(:posts).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
