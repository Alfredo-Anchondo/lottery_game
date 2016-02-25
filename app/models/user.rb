class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :rememberable, :trackable, :validatable
    
    
  
      #Associations
     belongs_to :role
    has_many :user_lotteries
    has_attached_file :photo,
    :styles => { :medium => "x300",
    :mobile => "x240" },
    :default_url => "no-image.png"
    
    #Validations
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  

      def select_display
      name
    end
    
      def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end
    
end
