# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

for i in 1..20
  Malt.create!(
    name: "#{Faker::Beer.malts} #{i.to_s}",
    description: Faker::Lorem.sentence,
    extract: 82,
    color: 7,
    ph: 5.7
  )
end

puts "Malts has been created."

for i in 1..20
  Hop.create!(
    name: "#{Faker::Tea.variety} #{i.to_s}",
    description: Faker::Lorem.sentence,
    aroma_profile: Faker::Tea.type,
    flavor_profile: Faker::Food.allergen,
    alpha_acids: 5.1
  )
end

puts "Hops has been created."

for i in 1..20
  Yeast.create!(
    name: "#{Faker::Tea.variety} #{i.to_s}",
    description: Faker::Lorem.sentence,
    dosage: 125,
    yeast_type: 1
  )
end
