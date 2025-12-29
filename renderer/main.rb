require 'optparse'
require_relative 'retrograde'

Options = Struct.new(:upgrade_data, :asset_data, :spacecraft_data, :treaty_data, :espionage_data, :decks, :print, :import, :output, :sheet_only)

class Parser
  def self.parse(options)
    args = Options.new()

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: main.rb [options] DECK1 ..."

      opts.on("-i", "--import", "Generate files for importing into Tabletop Simulator") do
        args.import = true
      end
      opts.on("-p", "--print", "Generate files for print and play") do
        args.print = true
      end
      opts.on("-u PATH", "--upgrade-data=PATH", String, "Specify the location of the upgrade card data") do |data|
        args.upgrade_data = data
      end
      opts.on("-a PATH", "--asset-data=PATH", String, "Specify the location of the asset card data") do |data|
        args.asset_data = data
      end
      opts.on("-s PATH", "--spacecraft-data=PATH", String, "Specify the location of the spacecraft card data") do |data|
        args.spacecraft_data = data
      end
      opts.on("-t PATH", "--treaty-data=PATH", String, "Specify the location of the treaty card data") do |data|
        args.treaty_data = data
      end
      opts.on("-e PATH", "--espionage-data=PATH", String, "Specify the location of the espionage card data") do |data|
        args.espionage_data = data
      end
      opts.on("-o PATH", "--output=PATH", String, "Specify the path for output to be placed") do |data|
        args.output = data
      end
      opts.on("-y", "--sheet-only", "Skip generation of individual cards") do
        args.sheet_only = true
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end

options = Parser.parse ARGV

options.decks = ARGV

retrograde = Retrograde.new(options.asset_data, options.upgrade_data, options.spacecraft_data, options.treaty_data, options.espionage_data, options.decks)
if options.print then
  retrograde.render(Retrograde.print_mode, options.output, options.sheet_only)
end
if options.import then
  retrograde.render(Retrograde.import_mode, options.output, options.sheet_only)
end
