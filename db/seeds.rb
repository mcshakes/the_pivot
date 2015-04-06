class Seed
  def call
    generate_items
    generate_users
    generate_specific_users
    generate_vendors
    generate_orders
    create_sold_items
  end

  def generate_items
    generate_categories
    @item_count = 200

    adjectives = ["avant garde", "groundbreaking", "chiaroscuro", "vibrant", "political", "journalistic", "impressionistic", "awe inspiring", "profound", "colorful"]
    photos     = ["mountains", "children at play", "self portrait", "boats", "kittens", "still life", "industrial wasteland", "modernist building", "suburbia"]

    adjectives.map!(&:titleize)
    photos.map!(&:titleize)

    @item_count.times do
      item = Item.create(name: "#{adjectives.sample} #{photos.sample}", description: "#{adjectives.sample}",
                        price: Faker::Commerce.price.round, photo: Faker::Avatar.image)
        categories = Category.order("RANDOM()").limit(rand(1..3))
        item.categories << categories
      puts "Items: #{item.name}"
    end
  end

  def create_sold_items
    40.times do
      item = Item.all.sample
      item.status = "sold"
      item.save!
    end
  end

  def generate_vendors
    @vendor_count = 10

    @vendor_count.times do
      vendor = Vendor.create(name: Faker::Company.name,
                             description: Faker::Lorem.sentence)
      user = User.find(rand(1..@user_count))
      user.vendors << vendor
      vendor.items << Item.order("RANDOM()").limit(rand(6..10))
      puts "Vendors: #{vendor.name}"
    end
  end

  def generate_users
    @user_count = 10
    @user_count.times do
      user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
      password: Faker::Internet.password, role: 0)
      # street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip,
      # credit_cards: Faker::Business.credit_card_number)
      puts "users: #{user.first_name} #{user.last_name}"
    end
  end

  def generate_specific_users
    User.create(first_name: "Miriam",
                last_name: "Moser",
                display_name: "mirjoy",
                email: "miriam@example.com",
                password: "password")
  end

  def generate_orders
    10.times do
      user  = User.order("RANDOM()").limit(1).first
      user.orders.create(status: "ordered") do |order|
        rand(1..10).times do
          order.items << Item.order("RANDOM()").limit(1).first
        end
      end
      puts "Created Orders For: #{user.first_name}"
    end
  end

  def generate_categories
    @category_count = 10

    @category_count.times do
      category = Category.create(name: Faker::Commerce.department)
    end
  end

  def self.call
    new.call
  end
end

Seed.call
