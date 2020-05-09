require 'squib'

class Import < Squib::Deck
  def initialize(pre_layouts, base_layouts, deck, **args, &block)
    @data = deck.data
    @name = deck.name
    @layouts = pre_layouts.concat(["layouts/constants-import.yml"]).concat(base_layouts)
    args[:layout] = @layouts.concat(deck.layout)
    args[:cards] = @data['name'].size
    args[:height] = "3.375in"
    args[:width] = "2.375in"
    super(**args) do
      instance_eval(&block)
    end
  end

  def output(save_png: true, save_sheet: true)
    save_png prefix: @name, dir: "output/import/#{@name}" if save_png
    save_sheet prefix: "retrograde_#{@name}", dir: "output/import/sheets", columns: 10 if save_sheet
  end
end
