Dir[Rails.root + 'app/presenters/**/*.rb'].each do |file|
  require file
end