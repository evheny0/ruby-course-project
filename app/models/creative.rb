class Creative < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :chapters
end
