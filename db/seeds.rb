# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Dose.destroy_all if Rails.env.development?
Ingredient.destroy_all if Rails.env.development?
Cocktail.destroy_all if Rails.env.development?

require 'open-uri'

5.times do
  response = open('https://www.thecocktaildb.com/api/json/v1/1/random.php')
  json = JSON.parse(response.read)['drinks']
  c = Cocktail.find_or_create_by!(name: json[0]['strDrink'], image: json[0]["strDrinkThumb"])
  i = Ingredient.find_or_create_by!(name: json[0]['strIngredient1'])
  Dose.create(description: json[0]['strMeasure1'], ingredient: i, cocktail: c)

  p "#{c.image}"
end
