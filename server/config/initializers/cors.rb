Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '127.0.0.1:5500', 'localhost:5500'
    resource(
      '/api/*', 
      headers: :any,
      credentials: true,
      methods: [:get, :delete, :post, :patch, :put, :option]
    )
  end
end