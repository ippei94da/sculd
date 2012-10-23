#! /usr/bin/env ruby
# coding: utf-8

require "sculd.rb"

#
#
#
class Sculd::Event
  attr_reader :datetime, :description

  #
  def initialize(datetime, description)
    @datetime = datetime
    @description   = description
  end

  def date
    @datetime.to_date
  end

end

