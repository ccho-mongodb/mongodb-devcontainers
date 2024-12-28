require 'mongoid'
require_relative 'models/movie'

Mongoid.load!('config/mongoid.yml', :development)

begin
    result = Movie.where(title: "Back to the Future").first
    puts result.inspect
end
