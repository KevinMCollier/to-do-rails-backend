Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://starlit-raindrop-ab99bd.netlify.app'

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
