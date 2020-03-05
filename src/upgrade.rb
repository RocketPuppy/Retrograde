require 'squib'
require_relative 'card'

# Layout methods and deck data for Asset card types
class Upgrade < Card
  def data
    Squib.csv file: 'card_data/upgrades.csv'
  end

  def name
    "upgrades"
  end

  def layout
    ["layouts/upgrade.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data)
    api.rect layout: 'main'

    title api, data['name']

    construction api, data['construction']
    bombardment api, data['bombardment']

    abilities api, data['abilities']
  end

  def title(api, title_data)
    api.text layout: 'title', str: data['name']
  end

  def bombardment(api, bombardment_data)
    bombardment_data = bombardment_data.map do |bombardment|
      ":bombardment: #{bombardment}"
    end
    api.text layout: 'bombardment', str: bombardment_data do |embed|
      embed.svg layout: 'bombardment-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
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
end

