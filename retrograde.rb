require 'squib'

# Base layout methods for a card regardless of type. These methods do the same
# thing regardless of card type
class Card
  def abilities(api, ability_data)
    api.text layout: 'abilities', str: ability_data, markup: true do |embed|
      embed.svg layout: 'ability-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
      embed.svg layout: 'ability-icon', key: ':armor:', file: 'icons/armor.svg'
      embed.svg layout: 'ability-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
      embed.svg layout: 'ability-icon', key: ':construction:', file: 'icons/construction.svg'
      embed.svg layout: 'ability-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
      embed.svg layout: 'ability-icon', key: ':corvette:', file: 'icons/corvette.svg'
      embed.svg layout: 'ability-icon', key: ':cruiser:', file: 'icons/cruiser.svg'
      embed.svg layout: 'ability-icon', key: ':delta-vee:', file: 'icons/delta-vee.svg'
      embed.svg layout: 'ability-icon', key: ':factory:', file: 'icons/factory.svg'
      embed.svg layout: 'ability-icon', key: ':fighter:', file: 'icons/fighter.svg'
      embed.svg layout: 'ability-icon', key: ':frigate:', file: 'icons/frigate.svg'
      embed.svg layout: 'ability-icon', key: ':homeworld:', file: 'icons/homeworld.svg'
      embed.svg layout: 'ability-icon', key: ':orbital-down:', file: 'icons/orbital-down.svg'
      embed.svg layout: 'ability-icon', key: ':orbital-up:', file: 'icons/orbital-up.svg'
      embed.svg layout: 'ability-icon', key: ':orbits:', file: 'icons/orbits.svg'
      embed.svg layout: 'ability-icon', key: ':population:', file: 'icons/population.svg'
      embed.svg layout: 'ability-icon', key: ':range:', file: 'icons/range.svg'
    end
    api.rect layout: 'abilities'
  end

  def ship_class_to_icon(ship_class)
    if ship_class == 'Fighter'
      ':fighter:'
    elsif ship_class == 'Corvette'
      ':corvette:'
    elsif ship_class == 'Frigate'
      ':frigate:'
    elsif ship_class == 'Cruiser'
      ':cruiser:'
    else
      throw "Unknown ship class"
    end
  end

  def ship_class_embed(embed)
    embed.svg layout: 'ship-class-icon', key: ':fighter:', file: 'icons/fighter.svg'
    embed.svg layout: 'ship-class-icon', key: ':corvette:', file: 'icons/corvette.svg'
    embed.svg layout: 'ship-class-icon', key: ':frigate:', file: 'icons/frigate.svg'
    embed.svg layout: 'ship-class-icon', key: ':cruiser:', file: 'icons/cruiser.svg'
  end
end

# Layout methods and deck data for Asset card types
class Assets < Card
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

    orbitals api, data['orbitals'].map { |x| x.split("/").map { |y| y.split(",") } }

    horizon api

    factory api, data['factory']
    population api, data['population']
    construction api, data['construction']

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

  def factory(api, factory_data)
    factory_data = factory_data.map do |factory|
      ":factory: #{factory}"
    end
    api.text layout: 'factory', str: factory_data do |embed|
      embed.svg layout: 'factory-icon', key: ':factory:', file: 'icons/factory.svg'
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
      [":orbital-up: --- :orbital-down:"].concat(orbitals.reverse.map { |orbital|
        "#{orbital[0]} --- #{orbital[1]}"
      }).join("\n")
    end
    api.text layout: 'orbitals', str: orbital_string, markup: true do |embed|
        embed.svg layout: 'orbital-icon', key: ':orbital-up:', file: 'icons/orbital-up.svg'
        embed.svg layout: 'orbital-icon', key: ':orbital-down:', file: 'icons/orbital-down.svg'
    end
  end
end

class Spacecraft
  def data
    Squib.csv file: 'card_data/spacecraft.csv'
  end

  def name
    "spacecraft"
  end

  def layout
    []
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data)
  end
end

# Layouts that are required before any other layout can be loaded. This is
# because other layouts reference these. They cannot extend any layout that
# isn't defined in itself.
def pre_layouts
  ['layouts/borders.yml', 'layouts/debug.yml']
end

# Layouts added after print and import specific layouts are included.
def base_layouts
  ['layouts/constants.yml']
end

class Import < Squib::Deck
  def initialize(deck, **args, &block)
    @data = deck.data
    @name = deck.name
    args[:layout] = pre_layouts.concat(["layouts/constants-import.yml"]).concat(base_layouts).concat(deck.layout)
    args[:cards] = @data['name'].size
    args[:height] = "3.375in"
    args[:width] = "2.375in"
    super(**args) do
      instance_eval(&block)

      output
    end
  end

  def output
    save_png prefix: @name, dir: "output/import/cards"
    save_sheet prefix: "retrograde_#{@name}", dir: "output/import/sheets", columns: 4
  end
end

class Print < Squib::Deck
  def initialize(deck, **args, &block)
    @data = deck.data
    @name = deck.name

    args[:height] = "3.75in"
    args[:width] = "2.75in"
    args[:layout] = pre_layouts.concat(['layouts/constants-print.yml']).concat(base_layouts).concat(deck.layout)
    args[:cards] = @data['name'].size
    super(**args) do
      rect layout: 'cut'
      rect layout: 'border'

      instance_eval(&block)

      output
    end
  end

  def output
    save_png prefix: @name, dir: "output/print/cards"
    save_sheet prefix: "retrograde_#{@name}", dir: "output/print/sheets", columns: 4
  end
end

[Assets.new, Spacecraft.new].each do |deck|
  Import.new deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data
  end
  Print.new deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data
  end
end
