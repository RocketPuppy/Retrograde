# Hack to work around something weird with autoloading these classes in the roo gem
module Roo
  class OpenOffice
  end

  class Excelx
  end

  class CSV
  end
end
require 'squib'

class Deck
  def initialize(name, path, assets, upgrades, spacecraft, treaties, espionage)
    @name = name
    @path = path
    @assets = assets
    @upgrades = upgrades
    @spacecraft = spacecraft
    @treaties = treaties
    @espionage = espionage
  end

  def name
    @name
  end

  def data
    card_names = csv
    big_data = card_names['name'].map do |name|
      d = asset_index(@assets.data, name)
      if d != nil then
        d['internal_card_type'] = [:asset]
        d
      else
        d = spacecraft_index(@spacecraft.data, name)
        if d != nil then
          d['internal_card_type'] = [:spacecraft]
          d
        else
          d = upgrade_index(@upgrades.data, name)
          if d != nil then
            d['internal_card_type'] = [:upgrade]
            d
          else
            d = treaty_index(@treaties.data, name)
            if d != nil then
              d['internal_card_type'] = [:treaty]
              d
            else
              d = espionage_index(@espionage.data, name)
              if d != nil then
                d['internal_card_type'] = [:espionage]
                d
              else
                throw "Couldn't find card name \"#{name}\" in assets, upgrades, spacecraft, treaties, or espionage."
              end
            end
          end
        end
      end
    end
    starter = ["internal_card_type"].concat(@assets.data.to_h.keys).concat(@upgrades.data.to_h.keys).concat(@spacecraft.data.to_h.keys).concat(@treaties.data.to_h.keys).concat(@espionage.data.to_h.keys).uniq.each_with_object({}) { |k, o| o[k] = [] }
    big_data = big_data.each_with_object(starter) do |data, memo|
      memo.keys.each do |k|
        memo[k] = memo[k].concat(data[k] || [nil])
      end
    end
    Squib::DataFrame.new(big_data)
  end

  def layout
    []
  end

  def render(api, data, base_layouts)
    data["internal_card_type"].each_with_index do |card_type, i|
      if card_type == :asset then
        api.instance_variable_set(:@layout, Squib::LayoutParser.new(api.dpi).load_layout(base_layouts.concat(@assets.layout)))
        @assets.render(api, data, i)
      end

      if card_type == :spacecraft then
        api.instance_variable_set(:@layout, Squib::LayoutParser.new(api.dpi).load_layout(base_layouts.concat(@spacecraft.layout)))
        @spacecraft.render(api, data, i)
      end

      if card_type == :upgrade then
        api.instance_variable_set(:@layout, Squib::LayoutParser.new(api.dpi).load_layout(base_layouts.concat(@upgrades.layout)))
        @upgrades.render(api, data, i)
      end

      if card_type == :treaty then
        api.instance_variable_set(:@layout, Squib::LayoutParser.new(api.dpi).load_layout(base_layouts.concat(@treaties.layout)))
        @treaties.render(api, data, i)
      end

      if card_type == :espionage then
        api.instance_variable_set(:@layout, Squib::LayoutParser.new(api.dpi).load_layout(base_layouts.concat(@espionage.layout)))
        @espionage.render(api, data, i)
      end
    end
  end

  private

  def csv
    Squib.csv file: @path
  end

  def asset_index(asset_data, card_name)
    if asset_data['name'].nil? then
      return nil
    end

    @asset_index ||= asset_data['name'].each_with_index.each_with_object({}) { |names, o| o[names[0]] = names[1] }
    i = @asset_index[card_name]
    if i != nil then
      asset_data.entries.each_with_object({}) { |entry, o| o[entry[0]] = [entry[1][i]] }
    else
      nil
    end
  end

  def spacecraft_index(spacecraft_data, card_name)
    if spacecraft_data['name'].nil? then
      return nil
    end

    @spacecraft_index ||= spacecraft_data['name'].each_with_index.each_with_object({}) { |names, o| o[names[0]] = names[1] }
    i = @spacecraft_index[card_name]
    if i != nil then
      spacecraft_data.entries.each_with_object({}) { |entry, o| o[entry[0]] = [entry[1][i]] }
    else
      nil
    end
  end

  def upgrade_index(upgrade_data, card_name)
    if upgrade_data['name'].nil? then
      return nil
    end

    @upgrade_index ||= upgrade_data['name'].each_with_index.each_with_object({}) { |names, o| o[names[0]] = names[1] }
    i = @upgrade_index[card_name]
    if i != nil then
      upgrade_data.entries.each_with_object({}) { |entry, o| o[entry[0]] = [entry[1][i]] }
    else
      nil
    end
  end

  def treaty_index(treaty_data, card_name)
    if treaty_data['name'].nil? then
      return nil
    end

    @treaty_index ||= treaty_data['name'].each_with_index.each_with_object({}) { |names, o| o[names[0]] = names[1] }
    i = @treaty_index[card_name]
    if i != nil then
      treaty_data.entries.each_with_object({}) { |entry, o| o[entry[0]] = [entry[1][i]] }
    else
      nil
    end
  end

  def espionage_index(espionage_data, card_name)
    if espionage_data['name'].nil? then
      return nil
    end

    @espionage_index ||= espionage_data['name'].each_with_index.each_with_object({}) { |names, o| o[names[0]] = names[1] }
    i = @espionage_index[card_name]
    if i != nil then
      espionage_data.entries.each_with_object({}) { |entry, o| o[entry[0]] = [entry[1][i]] }
    else
      nil
    end
  end
end
