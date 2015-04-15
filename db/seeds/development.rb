class Seed
  ADJECTIVES = ["avant garde", "groundbreaking", "chiaroscuro", "vibrant", "political", "journalistic", "impressionistic",
                "awe inspiring", "profound", "colorful", "whimsical", "minimalistic", "striking", "boisterous", "simple",
                "ebullient"]
  PHOTOS     = ["mountains", "children at play", "self portrait", "boats", "kittens", "still life", "industrial",
                "modernist building", "suburbia", "hill country", "bluebonnets", "sculpture", "automobiles",
                "satire","bacon"]

  ADJECTIVES.map!(&:titleize)
  PHOTOS.map!(&:titleize)

  PICTURES = %w(alaska arch-building aspen beach japan architecture-bridge-california-3367
                castle-clouds-palace-763 Dusk_landscape_high_resolution glacier greens-beach-196826_640
                heron iceberg-404966_640 images ireland land3 Landscape_summer_lake Loxodonta_africana
                maldives-361244_640 mount_cooroora mountain_flowers-1546069 mtn-sunset Porch_of_Maidens
                Road_to_mount_cook_new_zealand travel)

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

  def generate_item_name
    begin
      item_name = "#{ADJECTIVES.sample} #{PHOTOS.sample}"
    end while Item.exists?(name: item_name)

    item_name
  end

  def generate_items
    100.times do |i|
      picture = PICTURES[i % 24]
      item = Item.new(
        name:      generate_item_name, description: "#{ADJECTIVES.sample}",
        price:     Faker::Commerce.price.round + 1,
        vendor_id: (1..10).to_a.sample
        )
      item.image = File.open("#{Rails.root}/app/assets/images/#{picture}.jpg")
      item.save!

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
