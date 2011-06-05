module ProductsHelper
  def parse_price(price)
    price / 100
  end
  
  def available_sizes(sizes)
    sizes.split(";")
  end
  
  def ellipsis(text)
    text.slice(0,320)+"..."
  end
end
