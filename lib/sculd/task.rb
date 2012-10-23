#! /usr/bin/env ruby
# coding: utf-8

require "sculd.rb"

#
#
#
class Sculd::Task
  attr_reader :priority, :description

  #
  def initialize(priority, description)
    @priority = priority
    @description   = description
  end
end

