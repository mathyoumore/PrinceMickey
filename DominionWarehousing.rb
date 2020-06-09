# frozen_string_literal: true

require 'pry'
Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }

require 'pp'
require 'csv'


def notFinished?(playerBoss, samples)
  result = false
  playerBoss.each do |p|
    result = result || p.notFinished?(samples)
  end
  result
end

def playAll(playerBoss, samples)
  playerBoss.each do |p|
    p.playHand if p.notFinished?(samples)
  end
end

def update(playerBoss, samples)
  # puts `clear`
  # puts "\n"
  # playerBoss.each do |p|
  #   puts  "#{p.name}: #{p.progress}/#{samples}\n"
  # end
end

def finish(playerBoss)
  playerBoss.each do |p|
    CSV.open("data/#{p.name}.csv", 'wb') { |csv| p.story.to_a.each { |elem| csv << elem } }
  end
end

samples = 1000
counter = 0

playerBoss = [
  # DumbPlayer.new,
  DumbFilterPlayer.new,
  SmartFilterPlayer.new(1),
  # SmartFilterPlayer.new(3),
  # SmartFilterPlayer.new(5),
  # SmartFilterPlayer.new
]

while notFinished?(playerBoss, samples)
  playAll(playerBoss, samples)
  counter += 1
  if counter % 100 == 0
    update(playerBoss, samples)
  end
  finish(playerBoss)
end
