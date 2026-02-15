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
    title api, data['name'], data['faction'], index

    construction api, data['construction'], index
    infrastructure api, data['infrastructure'], index

    abilities api, data['abilities'], index
  end

  private

  def infrastructure(api, bombardment_data, index)
    bombardment_data = bombardment_data.map do |bombardment|
      ":infrastructure: #{bombardment}"
    end
    api.text layout: 'infrastructure', range: index, str: bombardment_data do |embed|
      embed.svg layout: 'infrastructure-icon', key: ':infrastructure:', file: 'icons/bombardment.svg'
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
