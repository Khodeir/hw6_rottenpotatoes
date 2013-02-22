class Movie < ActiveRecord::Base
  has_many :reviews  
  has_many :moviegoers, :through => :reviews  

def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def similar_movies
    Movie.find_all_by_director(self.director)
  end
def self.find_in_tmdb(terms)
  Tmdb.api_key = "54a1b5841888fa09ef227e9c00ce552a"
  Tmdb.default_language = "en"
  movies = TmdbMovie.find(:title => terms, :limit => 10)
  results = movies.map do |m|
    director = m.cast.find {|p| p.job == 'Director'}
    self.new(:title => m.name, :rating => m.certification, :description => m.overview, 
            :release_date => m.released, :director => director.nil? ? "" : director.name)
  end
end
end
