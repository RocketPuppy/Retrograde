require 'squib'
require_relative 'card'

class Spacecraft < Card
  def data
    Squib.csv file: 'card_data/spacecraft.csv'
  end

  def name
    "spacecraft"
  end

  def layout
    ["layouts/spacecraft.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data)
    title api, data['name']

    spacecraft_class api, data['class']

    population api, data['population']
    bombardment api, data['bombardment']
    construction api, data['construction']
    accuracy api, data['accuracy']
    armor api, data['armor']
    delta_vee api, data['delta-vee']

    abilities api, data['abilities']
  end

  def title(api, title_data)
    api.text layout: 'title', str: data['name']
  end

  def spacecraft_class(api, class_data)
    api.svg layout: 'spacecraft-class', file: class_data.map { |x| ship_class_to_file x }
  end

  def population(api, pop_data)
    api.text layout: 'population', str: pop_data.map { |x| ":population:#{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':population:', file: 'icons/population.svg'
    end
  end

  def construction(api, construction_data)
    api.text layout: 'construction', str: construction_data.map { |x| ":construction:#{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':construction:', file: 'icons/construction.svg'
    end
  end

  def bombardment(api, bombardment_data)
    api.text layout: 'bombardment', str: bombardment_data.map { |x| ":bombardment:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
    end
  end

  def accuracy(api, accuracy_data)
    api.text layout: 'accuracy', str: accuracy_data.map { |x| ":accuracy:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
    end
  end

  def armor(api, armor_data)
    api.text layout: 'armor', str: armor_data.map { |x| ":armor:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':armor:', file: 'icons/armor.svg'
    end
  end

  def delta_vee(api, dv_data)
    api.text layout: 'delta-vee', str: dv_data.map { |x| ":delta-vee:\n\r #{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':delta-vee:', file: 'icons/delta-vee.svg'
    end
  end
end
