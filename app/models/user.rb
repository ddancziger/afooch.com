class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  if user
		  return user
	  else
		  registered_user = User.where(:email => auth.info.email).first
		  if registered_user
			  return registered_user
		  else
			  user = User.create(first_name:auth.extra.raw_info.name,
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
