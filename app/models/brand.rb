class Brand < ActiveRecord::Base
  has_many :products
  has_attached_file :logo, :styles => { :logo => "120>x120"},:default_url => '/system/logo/missing-:style.png'

  validates_uniqueness_of :name

end
