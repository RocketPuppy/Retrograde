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
  rescue => e
    puts "Could not load assets file #{@data_file}"
    puts e
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

    title api, data['name'], [], index

    orbits api, data['orbit'].map { |x| x == nil ? [nil, nil, nil, nil] : x.split(",") }.transpose, index

    orbitals api, data['orbitals'].map { |x| x == nil ? [] : x.to_s.split(",") }, index

    horizon api, index

    costs api, data['settlement'], index
    combat api, data['infrastructure'], index
    resources api, data['construction'], data['research'].zip(data['research type']), data['colonization'], data['influence'], data['intel'], data['command'], index

    abilities api, data['abilities'], index

    homeworld api, data['homeworld'], index
  end

  private

  def resources(api, constructions, researches, colonizations, influences, intels, commands, index)
    construction_str = constructions.map { |c| ":construction: #{c}" unless c.nil? }
    research_str = researches.map do |r|
      case r[1].downcase
      when "search"
        ":research-search: #{r[0]}"
      when "shuffle"
        ":research-shuffle: #{r[0]}"
      when "draw"
        ":research-draw: #{r[0]}"
      when "*"
        ":research-wild: #{r[0]}"
      else
        ":research-draw: 0"
      end
    end
    colonization_str = colonizations.map { |c| ":colonization: #{c}" unless c.nil? }
    influence_str = influences.map { |i| ":influence: #{i}" unless i.nil? }
    intel_str = intels.map { |i| ":intel: #{i}" unless i.nil? }
    command_str = commands.map { |c| ":command: #{c}" unless c.nil? }

    api.text layout: 'construction', str: construction_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':construction:', file: 'icons/construction.svg'
    end
    api.text layout: 'research', str: research_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':research-search:', file: 'icons/research-search.svg'
      embed.svg layout: 'resource-icon', key: ':research-shuffle:', file: 'icons/research-reorder.svg'
      embed.svg layout: 'resource-icon', key: ':research-draw:', file: 'icons/research-draw.svg'
      embed.svg layout: 'resource-icon', key: ':research-wild:', file: 'icons/research-wild.svg'
    end
    api.text layout: 'colonization', str: colonization_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':colonization:', file: 'icons/population.svg'
    end
    api.text layout: 'influence', str: influence_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':influence:', file: 'icons/influence.svg'
    end
    api.text layout: 'intel', str: intel_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':intel:', file: 'icons/intel.svg'
    end
    api.text layout: 'command', str: command_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':command:', file: 'icons/command.svg'
    end
  end

  def combat(api, infrastructure, index)
    combat_str = infrastructure.map do |value|
      ":infrastructure: #{value}"
    end

    api.text layout: 'combat', str: combat_str, range: index do |embed|
      embed.svg layout: 'combat-icon', key: ':infrastructure:', file: 'icons/bombardment.svg'
    end
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

  def costs(api, settlement_costs, index)
    cost_strings = settlement_costs.map do |cost|
      ":settlement: #{cost}" unless cost.nil?
    end

    api.text layout: 'costs', str: cost_strings, range: index do |embed|
      embed.svg layout: 'cost-icon', key: ':settlement:', file: 'icons/settlement.svg'
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
