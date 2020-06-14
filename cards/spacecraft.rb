require 'squib'
require_relative 'card'

class Spacecraft < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  end

  def name
    "spacecraft"
  end

  def layout
    ["layouts/spacecraft.yml"]
  end

  # Takes the api object defining the Squib DSL and the deck data to render
  def render(api, data, index = :all)
    title api, data['name'], index

    spacecraft_class api, data['class'], index

    population api, data['population'], index
    bombardment api, data['bombardment'], index
    construction api, data['construction'], index
    accuracy api, data['accuracy'], index
    armor api, data['armor'], index
    delta_vee api, data['delta-vee'], index

    abilities api, data['abilities'], index
  end

  private

  def title(api, title_data, index)
    api.text layout: 'title', str: title_data, range: index
  end

  def spacecraft_class(api, class_data, index)
    api.svg layout: 'spacecraft-class', range: index, file: class_data.map { |x| x == nil ? nil : ship_class_to_file(x) }
  end

  def population(api, pop_data, index)
    api.text layout: 'population', range: index, str: pop_data.map { |x| ":population:#{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':population:', file: 'icons/population.svg'
    end
  end

  def construction(api, construction_data, index)
    api.text layout: 'construction', range: index, str: construction_data.map { |x| ":construction:#{x}" } do |embed|
      embed.svg layout: 'stat-icon', key: ':construction:', file: 'icons/construction.svg'
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
