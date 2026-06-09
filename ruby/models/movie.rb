class Movie
    include Mongoid::Document

    field :title, type: String
    field :plot, type: String
    field :cast, type: Array
    field :year, type: Integer
    field :genres, type: Array
end
  
