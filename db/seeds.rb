# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Group.destroy_all
Subscription.destroy_all
users = User.create([
    {username: "saraht", email:"sarah_testerwoman@gmail.com", password: "sarahtesterwoman", first_name: "Sarah", last_name: "Testerwoman"},
    {username: "mannyt", email:"manny_testerman@gmail.com", password: "supersecure", first_name: "Manny", last_name: "Testerman"},
    {username: "boywholived", email:"hp@gmail.com", password: "dumbledore", first_name: "Harry", last_name: "Potter"},
    {username: "hogwartsahistory", email:"hg@gmail.com", password: "timeturner", first_name: "Hermione", last_name: "Granger"},
    {username: "fakeguy", email:"guy@test.com", password: "blueshirtguy", first_name: "Guy", last_name: "Reynolds"},
    {username: "mintmobile", email:"mintmobile@gmail.com", password: "supersecure", first_name: "Ryan", last_name: "Reynolds"},
    {username: "spidey", email:"petertingle@gmail.com", password: "supersecure", first_name: "Tom", last_name: "Holland"},
    {username: "bigboss", email:"tony@stark.co", password: "supersecure", first_name: "Tony", last_name: "Stark"}
])

sarah = User.where(username: "saraht").first
sarah.subscriptions.create([
    {subscription_name: "Hulu", username: "sarahhulu", password: "spotifyfree", url: "hulu.com", cost_per_month: 5.99},
    {subscription_name: "Netflix", username: "sarahNetflix", password: "daddysmoney", url: "netflix.com", cost_per_month: 9.99},
    {subscription_name: "Amazon", username: "sarahAmazon", password: "primetime", url: "amazon.com", cost_per_month: 25.00},
    {subscription_name: "Disney+", username: "sarahDisney", password: "password", url: "disneyplus.com", cost_per_month: 14.95},
    {subscription_name: "Google", username: "sarahGoogle", password: "google123", url: "google.com", cost_per_month: 0.00}
])

manny = User.where(username: "mannyt").first
manny.subscriptions.create([
    {subscription_name: "Hulu", username: "mannyhulu", password: "supersecure", url: "hulu.com", cost_per_month: 5.99},
    {subscription_name: "Netflix", username: "mannyNetflix", password: "supersecure", url: "netflix.com", cost_per_month: 9.99},
    {subscription_name: "Disney+", username: "mannyDisney", password: "supersecure", url: "disneyplus.com", cost_per_month: 14.95},
    {subscription_name: "Apple", username: "mannyApple", password: "supersecure", url: "apple.com", cost_per_month: 100.00}
])

harry = User.where(username: "boywholived").first
harry.subscriptions.create([
    {subscription_name: "Verizon", username: "harryVerizon", password: "primetime", url: "verizon.com", cost_per_month: 49.00},
    {subscription_name: "Disney+", username: "harryDisney", password: "password", url: "disneyplus.com", cost_per_month: 14.95},
    {subscription_name: "Google", username: "harryGoogle", password: "google123", url: "google.com", cost_per_month: 0.00}
])

hermione = User.where(username: "hogwartsahistory").first
hermione.subscriptions.create([
    {subscription_name: "Flourish and Blotts", username: "hermione", password: "wingardiumleviOsa", url: "flourish.com", cost_per_month: 4.99},
    {subscription_name: "Hogwarts Tuition Portal", username: "granger", password: "password", url: "hogwarts.com", cost_per_month: 105.95}
])

gryff = harry.owned_groups.create(group_name: "Gryffindor")
gryff.users << hermione
gryff.subscriptions << harry.subscriptions.first
gryff.subscriptions << harry.subscriptions.second
gryff.subscriptions << hermione.subscriptions.first

roomies = sarah.owned_groups.create(group_name: "Ucentre Roomies")
roomies.users << manny
roomies.users << User.where(username: "mintmobile").first
roomies.users << User.where(username: "bigboss").first
roomies.subscriptions << sarah.subscriptions.first
roomies.subscriptions << sarah.subscriptions.third
roomies.subscriptions << sarah.subscriptions.last
roomies.subscriptions << manny.subscriptions.last
roomies.subscriptions << manny.subscriptions.second