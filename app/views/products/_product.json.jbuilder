json.extract! product, :id, :nombre, :precio, :nombre_cientifico, :luz, :riego, :necesidades, :descripccion, :tamano, :created_at, :updated_at
json.url product_url(product, format: :json)
