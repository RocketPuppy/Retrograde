require 'squib'
require_relative 'asset'
require_relative 'spacecraft'
require_relative 'import'
require_relative 'print'

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

[Asset.new, Spacecraft.new].each do |deck|
  Import.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data
  end
  Print.new pre_layouts, base_layouts, deck, dpi: 300 do
    background color: 'white'
    rect layout: 'safe'

    deck.render self, @data
  end
end
