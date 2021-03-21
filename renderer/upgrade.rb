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

# Layout methods and deck data for Asset card types
class Upgrade < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  rescue => e
    puts "Could not load upgrade file #{@data_file}"
    puts e
    {}
  end

  def name
    "upgrades"
  end

  def layout
    ["layouts/upgrade.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data, index = :all)
    title api, data['name'], data['unique'], index

    construction api, data['construction'], index
    bombardment api, data['bombardment'], index

    abilities api, data['abilities'], index

    faction api, data['faction'], index
  end

  private

  def faction(api, faction_data, index)
    api.text layout: 'faction', str: faction_data, range: index
  end

  def bombardment(api, bombardment_data, index)
    bombardment_data = bombardment_data.map do |bombardment|
      ":bombardment: #{bombardment}"
    end
    api.text layout: 'bombardment', range: index, str: bombardment_data do |embed|
      embed.svg layout: 'bombardment-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def construction(api, construction_data, index)
    construction_data = construction_data.map do |construction|
      ":construction: #{construction}"
    end
    api.text layout: 'construction', range: index, str: construction_data do |embed|
      embed.svg layout: 'construction-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end
end
