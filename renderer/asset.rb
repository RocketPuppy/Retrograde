# Hack to work around something weird with autoloading these classes in the roo gem
module Roo; class OpenOffice; end; class Excelx; end; class CSV; end; end

require 'squib'
require_relative 'card'

# Layout methods and deck data for Asset card types
class Asset < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  rescue
    puts "Could not load assets file #{@data_file}"
    {}
  end

  def name
    "assets"
  end

  def layout
    ["layouts/asset.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data, index = :all)
    api.rect layout: 'main', range: index

    title api, data['name'], index

    orbits api, data['orbit'].map { |x| x == nil ? [nil, nil, nil, nil] : x.split(",") }.transpose, index

    orbitals api, data['orbitals'].map { |x| x == nil ? [] : x.to_s.split(",") }, index

    horizon api, index

    population api, data['population'], index
    construction api, data['construction'].zip(data['factory']).map { |x| "#{x[0] || 0}/#{x[1] || 0}" }, index
    bombardment api, data['bombardment'], index

    homeworld api, data['homeworld'], index

    ship_classes api, data['classes'].map { |x| (x || "").split(",") }, index

    abilities api, data['abilities'], index
  end

  private

  def title(api, title_data, index)
    api.text layout: 'title', str: title_data, range: index
  end

  def homeworld(api, homeworld_data, index)
    homeworld_data = homeworld_data.map do |h|
      if h == "Y" then
        ":homeworld:"
      else
        nil
      end
    end

    api.text layout: 'homeworld', str: homeworld_data, range: index do |embed|
      embed.svg layout: 'homeworld-icon', key: ':homeworld:', file: 'icons/homeworld.svg'
    end
  end

  def bombardment(api, bombardment_data, index)
    bombardment_data = bombardment_data.map do |bombardment|
      ":bombardment: #{bombardment}"
    end
    api.text layout: 'bombardment', str: bombardment_data, range: index do |embed|
      embed.svg layout: 'bombardment-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def population(api, population_data, index)
    population_data = population_data.map do |population|
      ":population: #{population}"
    end
    api.text layout: 'population', str: population_data, range: index do |embed|
      embed.svg layout: 'population-icon', key: ':population:', file: 'icons/population.svg'
    end
  end

  def construction(api, construction_data, index)
    construction_data = construction_data.map do |construction|
      ":construction: #{construction}"
    end
    api.text layout: 'construction', str: construction_data, range: index do |embed|
      embed.svg layout: 'construction-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end

  def ship_classes(api, ship_class_data, index)
    ship_class_data = ship_class_data.map do |ship_classes|
      ship_classes = ship_classes.map do |ship_class|
        ship_class_to_icon ship_class unless ship_class.empty?
      end
      ship_classes.join("\n")
    end

    api.text layout: 'ship-classes', str: ship_class_data, range: index do |embed|
      ship_class_embed embed
    end
  end

  def horizon(api, index)
    api.ellipse layout: 'horizon', range: index
  end

  def orbits(api, orbits_data, index)
    orbit api, 'orbit-top', :with_icon, orbits_data[0], index
    orbit api, 'orbit-right', orbits_data[1], index
    orbit api, 'orbit-bottom', orbits_data[2], index
    orbit api, 'orbit-left', orbits_data[3], index
  end

  def orbit(api, layout, with_icon = :without_icon, orbit_data, index)
    if with_icon == :with_icon then
      orbit_data = orbit_data.map { |x| ":orbit: #{x}" }
    end

    api.text layout: layout, str: orbit_data, range: index do |embed|
      if with_icon == :with_icon then
        embed.svg layout: 'orbit-icon', key: ':orbit:', file: 'icons/orbits.svg'
      end
    end
  end

  def orbitals(api, orbital_data, index)
    orbital_string = orbital_data.map do |orbitals|
      [":orbital-down:\n"].concat(orbitals.reverse.map { |orbital|
        "#{orbital}"
      }).join("\n")
    end
    api.text layout: 'orbitals', str: orbital_string, markup: true, range: index do |embed|
      embed.svg layout: 'orbital-icon', key: ':orbital-down:', file: 'icons/orbital-down.svg'
    end
  end
end
