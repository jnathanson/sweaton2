namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
 
    Tag.create!(name: 'sport')
    Tag.create!(name: 'martial arts')
    Tag.create!(name: 'youth club')
    Tag.create!(name: 'football')
    Tag.create!(name: 'rugby')
    Tag.create!(name: 'basketball')
    Tag.create!(name: 'cricket')
    Tag.create!(name: 'dance')
    Tag.create!(name: 'aerobics')
    Tag.create!(name: 'band')
    Tag.create!(name: 'orchestra')
    Tag.create!(name: 'choir')
    Tag.create!(name: 'cooking')
    # ...And so on...

    admin = User.create!(name: "The Flying Spaghetti Monster",
                         email: "fsm@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         home_address: "1 Kilburn High Road",
                         home_postcode: "",
                         admin: true)
    teacher = User.create!(name: "Dr Jekyll The Maths Teacher",
                         email: "teacher@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         home_address: "3 Kilburn High Road",
                         home_postcode: "",
                         mentor: true)
    organiser = User.create!(name: "Mr Hyde The Sports Coach",
                         email: "organiser@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         home_address: "5 Kilburn High Road",
                         home_postcode: "",
                         organiser: true)

    other_venues = Venue.create!(name: "Other Venue",
				 description: "Other venue not listed above", user_id: 0,
                                 postcode: 'W6 7BS', street_address: 'Brook Green', gmaps: true )
    20.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      user = User.create!(name: name, email: email, password: password,
                   password_confirmation: password,
                         home_address: "#{2*n} Kilburn High Road",
                         home_postcode: "")
      Venue.create!(name: Faker::Company.name,
		    description: "We specialise in Sport!", user_id: 21-n,
                    postcode: '', street_address: n.to_s+' Hammersmith Road', gmaps: true)
    end
    venues = Venue.all
    5.times do
      content = Faker::Lorem.sentence(5)
      start_time = 3.days.from_now.advance(days: rand(-10..10))
      day = start_time.day
      contact = Faker::Name.name+", 02012345678"
      website = "contact@sports-club.co.uk"
      gender = "Both"
      venues.each { |venue| num = rand(1..13)
                         ev = venue.events.build(name: Tag.find(num).name+" club", description: content, start_time: start_time, end_time: start_time.advance(hours: 1), contact: contact, website: website, cost: rand(1..10).to_s(:currency, unit: '£'), gender: gender)
                         ev.save
                         ev.tagify!(Tag.find(num)) }
    end

    users = User.all
    users.each { |user| wuser.diary_entries.create!(name: "Supervisor meeting", start_time: 3.days.from_now.advance(days: rand(-3..10)), repeating: false) }

  end
end
