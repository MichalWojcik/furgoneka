json.array!(@packages) do |package|
  json.extract! package, :id, :pickup_date, :delivery_date, :status, :receiver_street, :receiver_city
  json.url package_url(package, format: :json)
end
