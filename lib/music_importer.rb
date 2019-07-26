require 'pry'
require_relative './song.rb'

class MusicImporter
  attr_reader :path
  def initialize(path)
    @path = path
  end

  def files
    @files = Dir.children(self.path).collect{|f| f.gsub("#{path}/", "")}
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end 
  end

end
