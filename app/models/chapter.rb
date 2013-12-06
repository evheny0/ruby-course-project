class Chapter < ActiveRecord::Base
  belongs_to :creative, :touch => true
end
