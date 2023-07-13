# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(
  email: "user@demo.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "User has been created."


malt_name = ['Pilsen BESTMALZ ', 'Pale Ale BESTMALZ', 'Vienna BESTMALZ', 'Munich BESTMALZ', 'Chocolate BESTMALZ']
malt_description = [
  'BEST Pilsen Malt, fuerte en enzimas y rica en extractos, es la malta base, sola o combinada, para todas las variedades de cervezas especiales. Además de permitir altos porcentajes de malta especial en la maceración, esta malta ofrece la base ideal para un procesamiento óptimo en la producción, fundamento de las mejores cervezas de calidad de todo tipo. El empleo de BEST Pilsen Malt se ajusta a la Ley de Pureza alemana.',
  'BEST Pale Ale es la malta más adecuada como base para numerosas variantes de las cervezas Ale anglosajonas y otros muchos tipos de cerveza en los que se pretende alcanzar un color plenamente dorado y un sabor efervescente y delicioso. El empleo de BEST Pale Ale se ajusta a la Ley de Pureza alemana.',
  'BEST Vienna dota a la cerveza de un color completamente dorado, una espuma extraordinaria y un sabor final agradable y delicioso. Para esta malta se emplea un tipo de cebada de dos hileras, que, a diferencia de lo que ocurre en la BEST Heidelberg, forma más sustancias colorantes durante el proceso de malteado. El contenido proteico es más elevado que el que presenta la BEST Pilsen Malt, utilizando semejantes componentes de enzimas y altos valores de extractos. El empleo de BEST Vienna se  ajusta a la Ley de Pureza alemana.',
  'BEST Múnich fortalece agradablemente el delicioso sabor propio de la malta tanto en las cervezas color ámbar como en las oscuras. Incluso con bajos porcentajes en la molienda, aporta una nota típica de malta en la cerveza. Es la malta perfecta para otorgarle más cuerpo a las cervezas con un alto grado de fermentación. El creciente contenido proteico que se alcanza al incrementar su uso en la molienda mejora también los valores de la espuma. El empleo de BEST Múnich se ajusta a la Ley de Pureza alemana.',
  'BEST Chocolate es ideal para la producción de cervezas con aroma tostado. Está elaborada a partir de malta verde o malta seca carame­lizada de la mejor cebada mediante procesos especiales de cuidado del tueste. Gracias a ese esmerado tueste, que reduce los valores de pi­razina, se evita que preponderen notas distin­tivas de sabor amargo. Por ello, con esta malta pueden elaborarse también cervezas muy agradables que van desde las oscuras hasta las cervezas negras con porcentajes de mo­lienda hasta un 10 %, sin que se desarrolle una astringencia amarga. La espuma de la cerveza permanece clara. El empleo de BEST Chocola­te se ajusta a la Ley de Pureza alemana.'
]
malt_extract = [ 80.5, 80.5, 80.5, 80.5, 75]
malt_color = [ 1.9, 2.7, 3.8, 6.5, 340 ]
malt_ph = [ 5.9, 5.9, 5.9, 5.9, 5.9]

for i in 0..4
  user.malts.create!(
    name: malt_name[i],
    description: malt_description[i],
    extract: malt_extract[i],
    color: malt_color[0],
    ph: malt_ph[0]
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
    yeast_type: 1,
    attenuation: 75
  )
end

puts "Yeasts has been created."

for i in 1..5
  recipe = Recipe.create!(
    name: "#{Faker::Beer.name} #{i}",
    description: Faker::Lorem.sentence,
    style: Faker::Beer.style,
    batch: 20
  )

  recipe.ingredient_items.create!(
    quantity: 30,
    addable: Malt.last
  )
  recipe.ingredient_items.create!(
    quantity: 30,
    addable: Hop.last
  )

  recipe.ingredient_items.create!(
    quantity: 30,
    addable: Yeast.last
  )
end

puts "Recipes has been created."
