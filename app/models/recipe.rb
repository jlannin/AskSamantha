class Recipe < ActiveRecord::Base
  has_attached_file :image, :styles=> {:medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/empty-plate.jpg"
  validates_attachment :image, :content_type => {:content_type => ["image/jpeg", "image/png", "image/gif"]}
  has_many :ingredients

  def self.sorted_by(col)
    if self.column_names.include?(col)
      self.order(col)
    else
      self.order("name")
    end
  end

end
