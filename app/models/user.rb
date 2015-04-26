class User < ActiveRecord::Base
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable
  #Generating User Roles
  enum role: [:user, :seller, :buyer , :admin]
  after_initialize :set_default_role, :if => :new_record?

  #Rating User
  ratyrate_rater
  has_one :feedback
  ratyrate_rateable 'matching', 'shipping_time'
	has_attached_file :avatar,
	                  :path => ":rails_root/public/images/users/:style/:filename",
	                  :url  => "/images/users/:style/:filename",
	                  styles: {
			                  thumb: '60x60!',
			                  square: '200x200#',
			                  medium: '300x300>'
	                  }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def set_default_role
	  self.role ||= :user
  end

  #Authenticate Users with facebook and save them
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  if user
		  return user
	  else
		  registered_user = User.where(:email => auth.info.email).first
		  if registered_user
			  return registered_user
		  else
			  user = User.create(first_name:auth.extra.raw_info.first_name,
			                     last_name: auth.extra.raw_info.last_name,
			                     provider:auth.provider,
			                     uid:auth.uid,
			                     email:auth.info.email,
			                     photo: auth.info.image,
			                     last_name: auth.info.last_name,
			                     gender: auth.extra.raw_info.gender,
			                     oauth_token: auth.credentials.token,
			                     oauth_expires_at: Time.at(auth.credentials.expires_at),
			                     password:Devise.friendly_token[0,20]
			  )
		  end
	  end
  end
end
