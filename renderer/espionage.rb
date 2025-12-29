# Hack to work around something weird with autoloading these classes in the roo gem
module Roo; class OpenOffice; end; class Excelx; end; class CSV; end; end

require 'squib'
require_relative 'card'

class Espionage < Card
  def initialize(data_file)
    @data_file = data_file
  end

  def data
    Squib.csv file: @data_file
  rescue => e
    puts "Could not load espionage file #{@data_file}"
    puts e
    {}
  end

  def name
    "espionage"
  end

  def layout
    ["layouts/espionage.yml"]
  end

  def render(api, data, index = :all)
    title api, data['name'], [], index
    costs api, data['intel'], index

    trigger api, data['trigger'], index
    effects api, data['effects'], index
  end

  private

  def costs(api, intel, index)
    api.text layout: 'costs', range: index, str: intel.map { |x| ":intel: #{x}" } do |embed|
      embed.svg layout: 'cost-icon', key: ':intel:', file: 'icons/intel.svg'
    end
  end

  def trigger(api, trigger_data, index)
    api.text layout: 'trigger', range: index, str: trigger_data
  end

  def effects(api, effect, index)
    api.text layout: 'effect', range: index, str: effect
  end
end
