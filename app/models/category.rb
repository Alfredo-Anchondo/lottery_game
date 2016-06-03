class Category < ActiveRecord::Base
  #Scopes
  default_scope -> { order(:name) }
  #scope :actives, -> { where('expiration_date > ?', Date.current) }

  #Associations
  has_attached_file :logo,
  :styles => { :medium => "x300",
  :mobile => "x240" },
  :default_url => "no-image.png"
	has_attached_file :background

  #Validations
  validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  validates :name, :uniqueness => { :case_sensitive => false }

  def select_display
    name
  end

  def self.find_by_friendly_name(name)
    select { |c| c.friendly_name == name }.first
  end

  def friendly_name
    name.downcase.gsub(/[^a-z0-9-]+/, '-')
  end
end
