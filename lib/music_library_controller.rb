require_relative './music_importer.rb'
require_relative './song.rb'
require 'pry'

class MusicLibraryController
  attr_reader :path, :importer
  def initialize(path = './db/mp3s')
    @path = path
    @importer = MusicImporter.new(path)
    @importer.import
    # binding.pry
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    input = gets
    until input == "exit"
      puts "What would you like to do?"
      input = gets
    end
  end

  def alphabetize_songs
    sorted_songs = Song.all.sort_by {|s| s.name}
  end

  def list_songs
    # sorted_songs = Song.all.sort_by {|s| s.name}
    # sorted_songs.each_with_index do |song, i|
    alphabetize_songs.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort_by {|a| a.name}
    sorted_artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort_by {|g| g.name}
    sorted_genres.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets
    if artist = Artist.find_by_name(artist_name)
      artist = Artist.find_by_name(artist_name)
      sorted_songs = artist.songs.sort_by {|s| s.name}
      sorted_songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets
    if genre = Genre.find_by_name(genre_name)
      genre = Genre.find_by_name(genre_name)
      sorted_songs = genre.songs.sort_by {|s| s.name}
      sorted_songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets
    if input.to_i
      song_number = input.to_i
      puts "Playing #{list_songs[song_number].name} by #{list_songs[song_number].artist.name}"
    end

  end
  # if song = self.list_songs[song_number]
  #   song = self.list_songs[song_number]
  #   puts "Playing #{song.name} by #{song.artist.name}"
  # end
end
