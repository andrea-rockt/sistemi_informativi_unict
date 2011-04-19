class User < ActiveRecord::Base
	has_many :news
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}
	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation,
				    :remember_me,:avatar,:user_name,:login,:height,
				    :country, :name,:surname,:address,:city
	#crea un campo che non viene scritto su database ma funge da intermediario per abilitare l'autenticazione sia con username che con email'
	attr_accessor :login
	
	validates_numericality_of :height, :less_than => 2.2, :greater_than =>1.4

	#questo metodo serve per permettere a devise di autenticare l'utente fornendo o username o email'
	protected
	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		login = conditions.delete(:login)
		where(conditions).where(["user_name = :value OR email = :value", { :value => login }]).first
	end
end
