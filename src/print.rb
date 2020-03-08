require 'squib'

class Print < Squib::Deck
  def initialize(pre_layouts, base_layouts, deck, **args, &block)
    @data = deck.data
    @name = deck.name

    args[:height] = "3.75in"
    args[:width] = "2.75in"
    args[:layout] = pre_layouts.concat(['layouts/constants-print.yml']).concat(base_layouts).concat(deck.layout)
    args[:cards] = @data['name'].size
    super(**args) do
      rect layout: 'cut'
      rect layout: 'border'

      instance_eval(&block)
    end
  end

  def output
    save_png prefix: @name, dir: "output/print/cards"
    save_sheet prefix: "retrograde_#{@name}", dir: "output/print/sheets", columns: 4, sprue: "sprues/print-sprue.yml"
  end
end
