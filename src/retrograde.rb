require 'squib'
require_relative 'asset'
require_relative 'spacecraft'
require_relative 'upgrade'
require_relative 'import'
require_relative 'print'
require_relative 'deck'

# Layouts that are required before any other layout can be loaded. This is
# because other layouts reference these. They cannot extend any layout that
# isn't defined in itself.
def pre_layouts
  ['layouts/borders.yml', 'layouts/debug.yml']
end

# Layouts added after print and import specific layouts are included.
def base_layouts
  ['layouts/constants.yml']
end

[Asset.new, Spacecraft.new, Upgrade.new].each do |deck|
  Import.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data

    output
  end
  Print.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data

    output
  end
end

decks = Dir["decks/*"]
decks.map do |deck_file|
  deck = Deck.new(File.basename(deck_file, ".csv"), deck_file, Asset.new, Upgrade.new, Spacecraft.new)

  Import.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data, @layouts

    output
  end
  Print.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data, @layouts

    output
  end
end
