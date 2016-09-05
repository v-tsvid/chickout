for i in 1..5
  Produkt.create!(title: "Product #{i}", 
                  price: i)
  User.create!(email: "user#{i}@gmail.com",
               password: "12345678")
end