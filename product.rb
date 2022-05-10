class Product
	attr_accessor :name, :sell_in, :price
	def initialize(name, sell_in, price)
		validations(name, price)
		self.name = name
		self.sell_in = sell_in
		self.price = price
	end

	def validations(name, price)
		if price < 0
			raise StandardError.new "price must be greather than 0"
		end
		if name == 'Mega Coverage' && price != 80
			raise StandardError.new "Mega Coverage price must be equals to 80"
		end
		if name != 'Mega Coverage' && price > 50
			raise StandardError.new "price can not be greather than 50"
		end
	end
end
  
class CarInsurance 
	attr_accessor :products
	def initialize(products)
		@products = products
	end

	def price(price)
		if price < 0
			return 0
		elsif price > 50
			return 50
		else
			return price
		end
	end

	def normal_coverage(product, day)
		product.sell_in = product.sell_in - day
		if(product.sell_in < 0)
			product.price = product.price - day + product.sell_in
		else
			product.price -= day
		end
		product.price = price(product.price)
		return product
	end

	def full_coverage(product, day)
		product.sell_in -= day
		if (product.sell_in < 0)
			product.price = product.price + day - product.sell_in
		else
			product.price += day
		end
		product.price = price(product.price)
		return product
	end

	def mega_coverage(product)
		return product
	end

	def special_full_coverage(product, day)
		product.sell_in -= day
		if (product.sell_in >= 5 && product.sell_in < 10)
			product.price = product.price + day + (10 - product.sell_in)
		elsif(product.sell_in >= 0 && product.sell_in < 5) 
			calculation = day - product.sell_in
			if(calculation > 0)
				product.price = product.price + day + calculation
			else
				product.price = product.price + day - calculation
			end   
		elsif (product.sell_in < 0)
			product.price = 0
		else
			product.price += day
		end
		product.price = price(product.price)
		return product
	end

	def update_price(product, day)
		if (day == 0)
			return product
		end
		case product.name
			when 'Full Coverage'
				return full_coverage(product, day)
			when 'Mega Coverage'
				return mega_coverage(product);
			when 'Special Full Coverage'
				return special_full_coverage(product, day)
			when 'Super Sale'
				return normal_coverage(product, day)
			else
				return normal_coverage(product, day)
		end
	end

	def print(product)
		puts("#{product.name}, #{product.sell_in}, #{product.price}")
	end
end

products = [
	Product.new('Medium Coverage', 10, 20),
	Product.new('Full Coverage', 2, 0),
	Product.new('Low Coverage', 5, 7),
	Product.new('Mega Coverage', 0, 80),
	Product.new('Mega Coverage', -1, 80),
	Product.new('Special Full Coverage', 15, 20),
	Product.new('Special Full Coverage', 10, 49),
	Product.new('Special Full Coverage', 5, 49),
	Product.new('Super Sale', 3, 6)
]

car_insurance = CarInsurance.new(products)
31.times do |day|
	puts("----- Day #{day} ------");
	puts('name, sell_in, price');
	car_insurance.products.each do |product|
		car_insurance.print(car_insurance.update_price(product.dup, day))
	end
end
  
  