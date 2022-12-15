# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

100.times do |i|
    name = "Product#{i+1}"
    description = "This product#{i+1} is very good."
    price = (i+1)*500
    Product.create(name: name,
                   description: description,
                   price: price,
                   user_id: 1
                )
end

# ["electronics", "vegetables", "books", "clothings", "mobile", "grocery"].each do |i| 
#     Category.create(name: i);
# end