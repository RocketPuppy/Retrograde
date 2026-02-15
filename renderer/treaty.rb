# Hack to work around something weird with autoloading these classes in the roo gem
module Roo; class OpenOffice; end; class Excelx; end; class CSV; end; end

require 'squib'
require_relative 'card'

class Treaty < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  rescue => e
    puts "Could not load treaties file #{@data_file}"
    puts e
    {}
  end

  def name
    "treaties"
  end

  def layout
    ["layouts/treaty.yml"]
  end

  def render(api, data, index = :all)
    title api, data['name'], data['faction'], index
    costs api, data['influence'], index

    option api, :above, data['option1'], data['upkeep1'], index
    option api, :below, data['option2'], data['upkeep2'], index
  end

  private

  def costs(api, influence, index)
    api.text layout: 'costs', range: index, str: influence.map { |x| ":influence: #{x}" } do |embed|
      embed.svg layout: 'cost-icon', key: ':influence:', file: 'icons/influence.svg'
    end
  end

  def option(api, location, option, upkeep, index)
    text_layout = case location
             when :above
                'option-above'
             when :below
                'option-below'
             end
    upkeep_layout = case location
             when :above
                'upkeep-above'
             when :below
                'upkeep-below'
             end
    api.text layout: text_layout, range: index, str: option
    api.text layout: upkeep_layout, range: index, str: upkeep.map { |x| ":influence: #{x}" } do |embed|
      embed.svg layout: 'cost-icon', key: ':influence:', file: 'icons/influence.svg'
    end
  end
end
