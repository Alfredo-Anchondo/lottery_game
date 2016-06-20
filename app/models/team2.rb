class Team2 < ActiveRecord::Base
  self.table_name = "teams"

  #Associations
  belongs_to :sport_category
  has_attached_file :logo,
  :styles => { :medium => "x300",
  :mobile => "x240" },
  :default_url => "no-image.png"

  #Validations
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
  validates :name, :uniqueness => { :case_sensitive => false }

  def select_display
    name
  end

  def logo_url
    logo.url
  end
end
