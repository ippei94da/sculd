#! /usr/bin/env ruby
# coding: utf-8

require "sculd.rb"

#
#
#
class Sculd::Task
  attr_reader :priority, :string

  #
  def initialize(priority, string)
    @priority = priority
    @string   = string
  end
end

