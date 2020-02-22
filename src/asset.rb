require 'squib'
require_relative 'card'

# Layout methods and deck data for Asset card types
class Asset < Card
  def data
    Squib.csv file: 'card_data/assets.csv'
  end

  def name
    "assets"
  end

  def layout
    ["layouts/asset.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data)
    api.rect layout: 'main'

    title api, data['name']

    orbits api, data['orbit'].map { |x| x.split(",") }.transpose

    orbitals api, data['orbitals'].map { |x| x.to_s.split(",") }

    horizon api

    population api, data['population']
    construction api, data['construction'].zip(data['factory']).map { |x| "#{x[0] || 0}/#{x[1] || 0}" }
    bombardment api, data['bombardment']

    homeworld api, data['homeworld']

    ship_classes api, data['classes'].map { |x| x.split(",") }

    abilities api, data['abilities']
  end

  def title(api, title_data)
    api.text layout: 'title', str: data['name']
  end

  def homeworld(api, homeworld_data)
    homeworld_data = homeworld_data.map do |h|
      if h == "Y" then
        ":homeworld:"
      else
        nil
      end
    end

    api.text layout: 'homeworld', str: homeworld_data do |embed|
      embed.svg layout: 'homeworld-icon', key: ':homeworld:', file: 'icons/homeworld.svg'
    end
  end

  def bombardment(api, bombardment_data)
    bombardment_data = bombardment_data.map do |bombardment|
      ":bombardment: #{bombardment}"
    end
    api.text layout: 'bombardment', str: bombardment_data do |embed|
      embed.svg layout: 'bombardment-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def population(api, population_data)
    population_data = population_data.map do |population|
      ":population: #{population}"
    end
    api.text layout: 'population', str: population_data do |embed|
      embed.svg layout: 'population-icon', key: ':population:', file: 'icons/population.svg'
    end
  end

  def construction(api, construction_data)
    construction_data = construction_data.map do |construction|
      ":construction: #{construction}"
    end
    api.text layout: 'construction', str: construction_data do |embed|
      embed.svg layout: 'construction-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end

  def ship_classes(api, ship_class_data)
    ship_class_data = ship_class_data.map do |ship_classes|
      ship_classes = ship_classes.map do |ship_class|
        ship_class_to_icon ship_class
      end
      ship_classes.join("\n")
    end

    api.text layout: 'ship-classes', str: ship_class_data do |embed|
      ship_class_embed embed
    end
  end

  def horizon(api)
    api.ellipse layout: 'horizon'
  end

  def orbits(api, orbits_data)
    orbit api, 'orbit-top', :with_icon, orbits_data[0]
    orbit api, 'orbit-left', orbits_data[1]
    orbit api, 'orbit-bottom', orbits_data[2]
    orbit api, 'orbit-right', orbits_data[3]
  end

  def orbit(api, layout, with_icon = :without_icon, orbit_data)
    if with_icon == :with_icon then
      orbit_data = orbit_data.map { |x| ":orbit: #{x}" }
    end
    api.text layout: layout, str: orbit_data do |embed|
      if with_icon == :with_icon then
        embed.svg layout: 'orbit-icon', key: ':orbit:', file: 'icons/orbits.svg'
      end
    end
  end

  def orbitals(api, orbital_data)
    orbital_string = orbital_data.map do |orbitals|
      [":orbital-down:\n"].concat(orbitals.reverse.map { |orbital|
        "#{orbital}"
      }).join("\n")
    end
    api.text layout: 'orbitals', str: orbital_string, markup: true do |embed|
      embed.svg layout: 'orbital-icon', key: ':orbital-down:', file: 'icons/orbital-down.svg'
    end
  end
end
