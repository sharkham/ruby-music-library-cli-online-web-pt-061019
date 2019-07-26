require_relative './concerns/findable.rb'

class Genre
  attr_accessor :name
  attr_reader :songs
  @@all = []

  extend Concerns::Findable 

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def add_song(song)
    song.genre ||= self
    unless self.songs.include?(song)
      self.songs << song
    end
  end

  def artists
    artists = []
    self.songs.each do |song|
      # artists = []
      unless artists.include?(song.artist)
        artists << song.artist
      end
    end
    artists
  end
end
