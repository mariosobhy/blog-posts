require 'rails_helper'

RSpec.describe Post, type: :model do

   # Association test
  # ensure an post record belongs to a single user record
  it { should belong_to(:author) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author_id) }
  
end
