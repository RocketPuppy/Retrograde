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

class Print < Squib::Deck
  def initialize(pre_layouts, base_layouts, deck, **args, &block)
    @data = deck.data
    @name = deck.name
    @layouts = pre_layouts.concat(['layouts/constants-print.yml']).concat(base_layouts)

    args[:height] = "3.75in"
    args[:width] = "2.75in"
    args[:layout] = @layouts.concat(deck.layout)
    args[:cards] = @data['name'].size
    super(**args) do
      rect layout: 'cut'
      rect layout: 'border'

      instance_eval(&block)
    end
  end

  def output(output_path = "output/print", save_png: true, save_sheet: true)
    save_png prefix: @name, dir: "#{output_path}/#{@name}" if save_png
    save_sheet prefix: "retrograde_#{@name}", dir: "#{output_path}/sheets", columns: 4, sprue: "sprues/print-sprue.yml" if save_sheet
  end
end
