# json.restaurants do
#   json.array! @restaurants do |restaurant|
#     json.id restaurant.id
#     json.name restaurant.name
#     json.address restaurant.address
#   end
# end

json.array! @restaurants do |restaurant|
  json.extract! restaurant, :id, :name, :address
end
