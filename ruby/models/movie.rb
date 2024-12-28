class Movie
    include Mongoid::Document

    field :name, type: String
    field :plot, type: String
    field :cast, type: Array
    field :year, type: Integer
    field :genres, type: Hash
end
  
