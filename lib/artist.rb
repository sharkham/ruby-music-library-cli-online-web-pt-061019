require_relative './concerns/findable.rb'

class Artist
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
    artist = Artist.new(name)
    artist.save
    artist
  end

  def add_song(song)
    song.artist ||= self
    unless self.songs.include?(song)
      self.songs << song
    end
  end

  def genres
    genres = []
    self.songs.each do |song|
      # genres = []
      unless genres.include?(song.genre)
        genres << song.genre
      end
    end
    genres
  end
end
