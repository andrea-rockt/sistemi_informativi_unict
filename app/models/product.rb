class Product < ActiveRecord::Base
    belongs_to :category
    belongs_to :brand
    attr_accessible :model, :price, :quantity, :size, :year,:image,:description
    has_attached_file :image, :styles => { :large => "800x800>",:medium => "300>x300", :thumb => "100x100>"},:default_url => '/system/products/missing-:style.png'
    
    validates_uniqueness_of :model
    
    serialize :size, Array
    serialize :quantity, Array

    #Le misure disponibili sono memorizzate come un array serializzato su database
    def size=(size)
      self[:size]=size.split(",")
    end
    
    def quantity=(quantity)
      self[:quantity]=quantity.split(",")
    end

end
