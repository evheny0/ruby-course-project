class Tag < ActiveRecord::Base
  has_and_belongs_to_many :creatives

  def self.like(str)
    where("value LIKE ? ", "%#{str}%").order(:ammount).take(10)
  end

  def self.most_popular
    order(:ammount => :desc).take(10)    
  end

  def self.get_or_create(tag_value)
    tag = where(:value => tag_value).last
    if tag
      tag.ammount += 1
      tag.save
    else
      tag = new(:value => tag_value, :ammount => 1)
    end
    return tag
  end

  def decrease
    if self.ammount == 1
      self.destroy
    else
      self.ammount -= 1
      self.save
    end
  end

end
