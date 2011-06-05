require "yaml"
def load_products_from_filesystem()
  fixtures_path=File.join(::Rails.root,"db/fixtures/products/")
  
  
  paths=[]
  prodotti={}
 
  Dir["#{fixtures_path}*"].each  do |dir|
    if File.directory?(dir) && dir != "." && dir != ".."
        prodotti.store(dir.gsub(fixtures_path,""),{})
    end
  end
    
  Dir["#{fixtures_path}*/*/*"].each  do |dir|
          paths=paths << dir 
  end
  
  paths.each do |path|
    
      tipo,marca,modello=path.gsub(fixtures_path,"").split("/")
  
      descrizione=""
      image=Dir["#{path}/*.{jpg,png,jpeg}"][0]
  
      File.open(Dir["#{path}/*.txt"][0], "r") do |infile|
        while (line = infile.gets)
            descrizione = descrizione + line
        end
      end
            
      prodotti[tipo][marca]={} if prodotti[tipo][marca].nil?
      
      if tipo=="tavole"
          prezzo = (200 + rand(500))*100
          size = (1..5).collect{
              (150 + rand(15)).to_s
          }
          size=size.uniq.compact
          quantity = (1..size.length).collect do
              (1 + rand(10)).to_s
          end 
      elsif tipo=="scarponi"
          prezzo = (50 + rand(300))*100
  
          taglie =["s","m","l","xl"]
          size=taglie.sample(1+rand(3))
          quantity = (1..size.length).collect do
              (1 + rand(10)).to_s
          end 
      elsif tipo=="attacchi"
          prezzo = (50 + rand(200))*100
          taglie =["s","m","l","xl"]
          size=taglie.sample(1+rand(3))
          quantity = (1..size.length).collect do
              (1 + rand(10)).to_s
          end 
      end

  
      prodotti[tipo][marca][modello]={
          :description=>descrizione,
          :image=>image,
          :price=>prezzo,
          :size=>size,
          :quantity=>quantity,
          :year=>2011,
          :image=>image
      }
  end
  
  return prodotti
  
end

def load_brands_from_filesystem()
  fixtures_path=File.join(::Rails.root,"db/fixtures/brands/")
  
  brands={}
  
  Dir["#{fixtures_path}*"].each  do |dir|
    if File.directory?(dir) && dir != "." && dir != ".."
        brands.store(dir.gsub(fixtures_path,""),nil)
    end
  end
  
  brands.each_key do |brand|
    brands[brand]=YAML::load(File.open(File.join(fixtures_path,brand,"info.yaml")))
    brands[brand]["image"]=Dir[File.join(fixtures_path,brand,"*.{jpg,png,jpeg,gif}")][0]
  end
  
  return brands
  
end 

def format_address(obj)
    "#{obj.address},#{obj.city},#{obj.country}"
end

namespace :db do
    desc "Load products from filesystem structure in filesystem"
    task :load_products => [:load_config, :environment, :load_brands] do
      products = load_products_from_filesystem()
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      products.each do |categoria,marche|
        new_category=Category.new(:name=>categoria.capitalize)
        new_category.save
        
        marche.each do |marca,prodotti|
          prodotti.each do |prodotto,specifiche|
            
            print ":: Loading product: #{prodotto} \n"
            new_product=Product.new(:model=>prodotto.gsub("_"," ").capitalize,:price => specifiche[:price],
                        :quantity=>specifiche[:quantity].join(","),:size=> specifiche[:size].join(","),:year=>specifiche[:year],
                        :description=> specifiche[:description])
            new_product.save
            
            new_product.category=new_category
            new_product.save
            
            new_product.brand=Brand.find_by_name(marca.to_s)
            new_product.save
            
            imageless_product=Product.find_by_model(prodotto.gsub("_"," ").capitalize)
            imageless_product.image = File.new(specifiche[:image])
            imageless_product.image.reprocess!
            imageless_product.save
            
          end
        end
      end
    end
    
    desc "Drop Current products table"
    task :delete_products => [:load_config, :environment] do
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      print "Dropping products table"
      Product.delete_all
      Category.delete_all
    end
    
    desc "Drop Current Brands table"
    task :delete_brands => [:load_config, :environment] do
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      print "Dropping Brands table\n"
      Brand.delete_all
    end
    
    desc "Load Brands from filesystem"
    task :load_brands => [:load_config, :environment] do
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      brands = load_brands_from_filesystem
      
      brands.each do |brand,info|
        print ":: Loading brand: #{brand} \n"
        
        new_brand = Brand.new(:name => brand, :website => info["website"], :nationality => info["nationality"])
        new_brand.save
        
        logoless_brand = Brand.find_by_name brand
        logoless_brand.logo = File.new(info["image"])
        logoless_brand.logo.reprocess!
        logoless_brand.save
      end 
    end
    
    desc "Loads stores"
    task :load_stores => [:load_config, :environment] do
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      stores_yaml_path=File.join(::Rails.root,"db/fixtures/stores/","stores.yaml")
      
      stores = YAML::load(File.open(stores_yaml_path))
      
      stores.each do |store|
        print ":: Loading Store: #{store['name']} \n"
        db_store = Store.new(:name => store["name"],:address => store["address"], :city => store["city"], :country => store["country"])
        db_store.save
        geocoding_info=Gmaps4rails.geocode(format_address(db_store))
        lat=geocoding_info[0][:lat]
        lng=geocoding_info[0][:lng]        
        db_store.lat=lat
        db_store.lng=lng
        db_store.save
      end
      
    end
    
    desc "Deletes stores"
    task :delete_stores => [:load_config, :environment] do
      ActiveRecord::Base.establish_connection(::Rails.env.to_sym)
      Store.delete_all
    end
end