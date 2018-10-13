require 'nokogiri'
require 'open-uri'
require 'byebug'

class StaticPagesController < ApplicationController
  def home
    @university = University.new
  end

  def about
    @links = []
  end

  def contact
  end

end
