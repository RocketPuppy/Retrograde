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

    horizon api, index

    costs api, data['command_cost'], index
    combat api, data['infrastructure'], index
    resources api, data['construction'], data['research'].zip(data['research type']), data['influence'], data['command'], index

    mass_factor api, data['mass_factor'], index

    abilities api, data['abilities'], index
  end

  private

  def resources(api, constructions, researches, influences, commands, index)
    construction_str = constructions.map { |c| ":construction: #{c}" unless c.nil? }
    research_str = researches.map do |r|
      case (r[1] or "").downcase
      when "search"
        ":research-search: #{r[0]}"
      when "scry"
        ":research-shuffle: #{r[0]}"
      when "draw"
        ":research-draw: #{r[0]}"
      when "*"
        ":research-wild: #{r[0]}"
      else
        nil
      end
    end

    influence_str = influences.map { |i| ":influence: #{i}" unless i.nil? }
    command_str = commands.map { |i| i.nil? ? nil : "#{i}"}

    api.text layout: 'construction', str: construction_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':construction:', file: 'icons/construction.svg'
    end
    api.text layout: 'research', str: research_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':research-search:', file: 'icons/research-search.svg'
      embed.svg layout: 'resource-icon', key: ':research-shuffle:', file: 'icons/research-reorder.svg'
      embed.svg layout: 'resource-icon', key: ':research-draw:', file: 'icons/research-draw.svg'
      embed.svg layout: 'resource-icon', key: ':research-wild:', file: 'icons/research-wild.svg'
    end
    api.text layout: 'influence', str: influence_str, range: index do |embed|
      embed.svg layout: 'resource-icon', key: ':influence:', file: 'icons/influence.svg'
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

  def costs(api, command_costs, index)
    cost_strings = command_costs.map do |cost|
      ":command: #{cost}" unless cost.nil?
    end

    api.text layout: 'costs', str: cost_strings, range: index do |embed|
      embed.svg layout: 'cost-icon', key: ':command:', file: 'icons/command.svg'
    end
  end

  def horizon(api, index)
    api.ellipse layout: 'horizon', range: index
  end

  def mass_factor(api, mass_factor, index)
    api.text layout: 'mass-factor', str: mass_factor.map { |m| ":gravity: #{m}" }, range: index do |embed|
      embed.svg layout: 'gravity-icon', key: ':gravity:', file: 'icons/gravity.svg'
    end
  end
end
