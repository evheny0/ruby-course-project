class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :creative, :touch => true
end
