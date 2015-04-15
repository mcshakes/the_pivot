class Seed
  def call
    generate_store_admins
    generate_users
    generate_vendors
    generate_categories
    generate_items
    generate_orders
    create_sold_items
  end

  def generate_store_admins
    user1 = User.create(first_name: 'Rachel', last_name: 'Warbelow', email: 'demo+rachel@jumpstartlab.com', password: 'password', role: 'store_admin')
    user2 = User.create(first_name: 'Jeff', last_name: "Casimir", email: 'demo+jeff@jumpstartlab.com', password: 'password', role: 'store_admin')
    user3 = User.create(first_name: 'Jorge', last_name: "Tellez", email: 'demo+jorge@jumpstartlab.com', password: 'password', role: 'store_admin')
    user4 = User.create(first_name: 'Sam', last_name: "Smith", email: 'sam@example.com', password: 'password', role: 'store_admin')
    user5 = User.create(first_name: 'Virginia', last_name: "Smith", email: 'virginia@example.com', password: 'password', role: 'store_admin')
    user6 = User.create(first_name: 'Juan', last_name: "Rodriguez", email: 'juan@example.com', password: 'password', role: 'store_admin')
    user7 = User.create(first_name: 'Amy', last_name: "Smith", email: 'amy@example.com', password: 'password', role: 'store_admin')
    user8 = User.create(first_name: 'Rene', last_name: "Rodriguez", email: 'Rene@example.com', password: 'password', role: 'store_admin')
    user9 = User.create(first_name: 'Jeannie', last_name: "Rodriguez", email: 'jeannie@example.com', password: 'password', role: 'store_admin')
    user10 = User.create(first_name: 'Oscar', last_name: "The Grouch", email: 'oscar@example.com', password: 'password', role: 'store_admin')
    p 'Admins Created'
  end

  # user11 = User.create(first_name: 'Turner', last_name: "Smalls", email: 'bigbird@example.com', password: 'password', role: 'store_admin')
  # user12 = User.create(first_name: 'Christoper', last_name: "Robin", email: 'christopher@example.com', password: 'password', role: 'store_admin')
  # user13 = User.create(first_name: 'Miriam', last_name: "Turing", email: 'miriam@example.com', password: 'password', role: 'store_admin')
  # user14 = User.create(first_name: 'Mac', last_name: "Turing", email: 'mac@example.com', password: 'password', role: 'store_admin')
  # user15 = User.create(first_name: 'Lori', last_name: "Turing", email: 'lori@example.com', password: 'password', role: 'store_admin')
  # user16 = User.create(first_name: 'Mickey', last_name: "Johnson", email: 'mickey@example.com', password: 'password', role: 'store_admin')
  # user17 = User.create(first_name: 'Donald', last_name: "Donaldson", email: 'donald@example.com', password: 'password', role: 'store_admin')
  # user18 = User.create(first_name: 'Brooke', last_name: "Rivers", email: 'brooke@example.com', password: 'password', role: 'store_admin')
  # user19= User.create(first_name: 'George', last_name: "Donaldson", email: 'george@example.com', password: 'password', role: 'store_admin')
  # user20 = User.create(first_name: 'Alan', last_name: "Turing", email: 'alan@example.com', password: 'password', role: 'store_admin')

  def generate_vendors
    Vendor.create(name: "Photos by Rachel", description: "Beautiful scenic images from around the world", credit_card: 4242424242424242, slug: "photos-by-rachel", user_id: 1)
    Vendor.create(name: "Incredible Images", description: "Scenic images from around the country and world", credit_card: 4242424242424243, slug: "incredible-images", user_id: 2)
    Vendor.create(name: "Big Time Photos", description: "Stunning photos from small town America", credit_card: 4242424242424244, slug: "big-time-images", user_id: 3)
    Vendor.create(name: "I Gotta Camera", description: "Freelance photographer willing to shoot any where in the world.", credit_card: 4242424242424245, slug: "i-gotta-camera", user_id: 4)
    Vendor.create(name: "Snapshots", description: "Beautiful scenic images from around the world", credit_card: 4242424242424246, slug: "snapshots", user_id: 5)
    Vendor.create(name: "Pictures by Mickey", description: "Scenic images from around the country and world", credit_card: 4242424242424247, slug: "pictures-by-mickey", user_id: 6)
    Vendor.create(name: "Click It In Pictures", description: "Stunning photos from small town America", credit_card: 4242424242424248, slug: "click-it-in-pictures", user_id: 7)
    Vendor.create(name: "Shutterspeed Photographs", description: "Beautiful scenic images from around the world", credit_card: 4242424242424249, slug: "shutterspeed-photographs", user_id: 8)
    Vendor.create(name: "Photo Emporium", description: "Freelance photographer willing to shoot any where in the world", credit_card: 4242424242424240, slug: "photo-emporium", user_id: 9)
    Vendor.create(name: "Our Amazing Images", description: "Spcialize making clients happy", credit_card: 4242424242424241, slug: "our-amazing-images", user_id: 10)
    p 'Vendors created'
  end

  def generate_users
    100.times do
      user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: 'password'
      )
    end
    p 'Users Created'
  end

  def generate_categories
    category1 = Category.create(name: "Architecture")
    category2 = Category.create(name: "Animal")
    category3 = Category.create(name: "Nature")
    category4 = Category.create(name: "People")
    category5 = Category.create(name: "Event")
    category6 = Category.create(name: "Sports")
    category7 = Category.create(name: "Travel")
    category8 = Category.create(name: "Night")
    p 'Categories Created'
  end

  def generate_items
    adjectives = ["avant garde", "groundbreaking", "chiaroscuro", "vibrant", "political", "journalistic", "impressionistic", "awe inspiring", "profound", "colorful"]
    photos     = ["mountains", "children at play", "self portrait", "boats", "kittens", "still life", "industrial wasteland", "modernist building", "suburbia"]

    adjectives.map!(&:titleize)
    photos.map!(&:titleize)
    
    pictures = %w(alaska arch-building aspen beach japan)

    20.times do |i|
      picture = pictures[i % 5]
      item = Item.new(
        name:      "#{adjectives.sample} #{photos.sample}", description: "#{adjectives.sample}",
        price:     Faker::Commerce.price.round,
        vendor_id: (1..10).to_a.sample
        )
      item.image = File.open("#{Rails.root}/app/assets/images/#{picture}.jpg")
      item.save!

      categories = Category.order("RANDOM()").limit(rand(1..3))
        item.categories << categories
      puts "Items: #{item.name}"
    end
  end

    #   20.times do
  #     item = Item.create(name: "#{adjectives.sample} #{photos.sample}", description: "#{adjectives.sample}",
  #                       price: Faker::Commerce.price.round, image: item.image.url "alaska.jpg", vendor_id: (1..10).to_a.sample)
  #     categories = Category.order("RANDOM()").limit(rand(1..3))
  #       item.categories << categories
  #     puts "Items: #{item.name}"
  #   end
  # end

    # 20.times do |i|
    #   picture = pictures[i % 5]

    #   item = Item.create(
    #     name:      "#{adjectives.sample} #{photos.sample}", description: "#{adjectives.sample}",
    #     price:     Faker::Commerce.price.round,
    #     image:     File.new("#{Rails.root}/app/assets/images/#{picture}.jpg"),
    #     vendor_id: (1..10).to_a.sample
    #     )

  def create_sold_items
    40.times do
      item = Item.all.sample
      item.status = "sold"
      item.save!
    end
    p 'Sold Items Created'
  end


  def generate_orders
    100.times do
      user  = User.order("RANDOM()").limit(1).first
      user.orders.create(status: "ordered") do |order|
        rand(1..10).times do
          order.items << Item.order("RANDOM()").limit(1).first
        end
      end
      puts "Created Orders For: #{user.first_name}"
    end
  end

  def self.call
      new.call
    end
  end

Seed.call

# def generate_items
#   @items = Items.create([
#     { name: "Alaska Glacier", description: "Breathtaking View", price: Faker::Commerce.price.round, 
#                               image_file_name: File.new("#{Rails.root}/app/assets/images/alaska.jpg", vendor_id: (1..10).to_a.sample) },
#   ])
# end

# class Seed
#   def call
#     generate_items
#     generate_users
#     generate_specific_users
#     generate_vendors
#     generate_orders
#     create_sold_items
#   end

#   def generate_items
#     generate_categories
#     @item_count = 200

#     adjectives = ["avant garde", "groundbreaking", "chiaroscuro", "vibrant", "political", "journalistic", "impressionistic", "awe inspiring", "profound", "colorful"]
#     photos     = ["mountains", "children at play", "self portrait", "boats", "kittens", "still life", "industrial wasteland", "modernist building", "suburbia"]

#     adjectives.map!(&:titleize)
#     photos.map!(&:titleize)

#     @item_count.times do
#       item = Item.create(name: "#{adjectives.sample} #{photos.sample}", description: "#{adjectives.sample}",
#                         price: Faker::Commerce.price.round, photo: Faker::Avatar.image, vendor_id: (1..10).to_a.sample)
#         categories = Category.order("RANDOM()").limit(rand(1..3))
#         item.categories << categories
#       puts "Items: #{item.name}"
#     end
#   end

#   def create_sold_items
#     40.times do
#       item = Item.all.sample
#       item.status = "sold"
#       item.save!
#     end
#   end

#   def generate_vendors
#     @vendor_count = 10

#     @vendor_count.times do
#       vendor = Vendor.create(name: Faker::Company.name,
#                              description: Faker::Lorem.sentence,
#                              credit_card: Faker::Business.credit_card_number)
#       user = User.find(rand(1..@user_count))
#       user.vendors << vendor
#       puts "Vendors: #{vendor.name}"
#     end
#   end

#   def generate_users
#     @user_count = 10
#     @user_count.times do
#       user = User.create(
#         first_name: Faker::Name.first_name,
#         last_name: Faker::Name.last_name,
#         email: Faker::Internet.email,
#         password: Faker::Internet.password,
#         role: 0
#       )
#         # shipping_address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}",
#         # billing_address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}",
#         # credit_card: Faker::Business.credit_card_number
#       puts "users: #{user.first_name} #{user.last_name}"
#     end
#   end

#   def generate_specific_users
#     User.create(first_name: "Miriam",
#                 last_name: "Moser",
#                 display_name: "mirjoy",
#                 email: "miriam@example.com",
#                 password: "password")
#     User.create(first_name: "Jorge",
#                 last_name: "Tellez",
#                 display_name: "Jorge",
#                 email: "jorge@example.com",
#                 password: "password")
#   end

#   def generate_orders
#     10.times do
#       user  = User.order("RANDOM()").limit(1).first
#       user.orders.create(status: "ordered") do |order|
#         rand(1..10).times do
#           order.items << Item.order("RANDOM()").limit(1).first
#         end
#       end
#       puts "Created Orders For: #{user.first_name}"
#     end
#   end

#   def generate_categories
#     @category_count = 10

#     @category_count.times do
#       category = Category.create(name: Faker::Commerce.department)
#     end
#   end

#   def self.call
#     new.call
#   end
# end

# Seed.call
