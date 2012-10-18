#! /usr/bin/env ruby
# coding: utf-8

require "sculd.rb"

#
#
#
class Sculd::Event
  attr_reader :datetime, :string

  #
  def initialize(datetime, string)
    @datetime = datetime
    @string   = string
  end
end

