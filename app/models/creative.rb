class Creative < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :chapters, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :title, :description, presence: true
  after_save :increase_user_amount
  before_destroy :decrease_user_amount

  private 
    def increase_user_amount
      user.creatives_num += 1
      user.save
    end

    def decrease_user_amount
      user.creatives_num -= 1
      user.save
    end
end
