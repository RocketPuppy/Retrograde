# Hack to work around something weird with autoloading these classes in the roo gem
module Roo
  class OpenOffice
  end

  class Excelx
  end

  class CSV
  end
end
require 'squib'
require_relative 'card'

class Spacecraft < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  rescue => e
    puts "Could not load spacecraft file #{@data_file}"
    puts e
    {}
  end

  def name
    "spacecraft"
  end

  def layout
    ["layouts/spacecraft.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data, index = :all)
    title api, data['name'], data['unique'], index

    command api, data['command'], index
    bombardment api, data['bombardment'], index
    construction api, data['construction'], index
    accuracy api, data['accuracy'], index
    armor api, data['armor'], index
    delta_vee api, data['delta-vee'], index

    abilities api, data['abilities'], index

    faction api, data['faction'], index
  end

  private

  def faction(api, faction_data, index)
    api.text layout: 'faction', str: faction_data, range: index
  end

  def command(api, commands, index)
    api.text layout: 'command', range: index, str: commands.map { |x| ":command: #{x}" } do |embed|
      embed.svg layout: 'cost-icon', key: ':command:', file: 'icons/population.svg'
    end
  end

  def construction(api, construction_data, index)
    api.text layout: 'construction', range: index, str: construction_data.map { |x| ":construction:#{x}" } do |embed|
      embed.svg layout: 'cost-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end

  def bombardment(api, bombardment_data, index)
    api.text layout: 'bombardment', range: index, str: bombardment_data.map { |x| ":bombardment:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def accuracy(api, accuracy_data, index)
    api.text layout: 'accuracy', range: index, str: accuracy_data.map { |x| ":accuracy:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
    end
  end

  def armor(api, armor_data, index)
    api.text layout: 'armor', range: index, str: armor_data.map { |x| ":armor:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':armor:', file: 'icons/armor.svg'
    end
  end

  def delta_vee(api, dv_data, index)
    api.text layout: 'delta-vee', range: index, str: dv_data.map { |x| ":delta-vee:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':delta-vee:', file: 'icons/delta-vee.svg'
    end
  end
end
