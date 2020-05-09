require 'squib'

# Base layout methods for a card regardless of type. These methods do the same
# thing regardless of card type
class Card
  def abilities(api, ability_data)
    api.text layout: 'abilities', range: @index, str: ability_data, markup: true do |embed|
      embed.svg layout: 'ability-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
      embed.svg layout: 'ability-icon', key: ':armor:', file: 'icons/armor.svg'
      embed.svg layout: 'ability-icon', key: ':bombardment:', file: 'icons/bombardment.svg'
      embed.svg layout: 'ability-icon', key: ':construction:', file: 'icons/construction.svg'
      embed.svg layout: 'ability-icon', key: ':accuracy:', file: 'icons/accuracy.svg'
      embed.svg layout: 'ability-icon', key: ':corvette:', file: 'icons/corvette.svg'
      embed.svg layout: 'ability-icon', key: ':cruiser:', file: 'icons/cruiser.svg'
      embed.svg layout: 'ability-icon', key: ':delta-vee:', file: 'icons/delta-vee.svg'
      embed.svg layout: 'ability-icon', key: ':factory:', file: 'icons/factory.svg'
      embed.svg layout: 'ability-icon', key: ':fighter:', file: 'icons/fighter.svg'
      embed.svg layout: 'ability-icon', key: ':frigate:', file: 'icons/frigate.svg'
      embed.svg layout: 'ability-icon', key: ':homeworld:', file: 'icons/homeworld.svg'
      embed.svg layout: 'ability-icon', key: ':orbital-down:', file: 'icons/orbital-down.svg'
      embed.svg layout: 'ability-icon', key: ':orbital-up:', file: 'icons/orbital-up.svg'
      embed.svg layout: 'ability-icon', key: ':orbits:', file: 'icons/orbits.svg'
      embed.svg layout: 'ability-icon', key: ':population:', file: 'icons/population.svg'
      embed.svg layout: 'ability-icon', key: ':range:', file: 'icons/range.svg'
    end
    api.rect layout: 'abilities', range: @index
  end

  def ship_class_to_icon(ship_class)
    if ship_class == 'Fighter'
      ':fighter:'
    elsif ship_class == 'Corvette'
      ':corvette:'
    elsif ship_class == 'Frigate'
      ':frigate:'
    elsif ship_class == 'Cruiser'
      ':cruiser:'
    else
      throw "Unknown ship class #{ship_class}"
    end
  end

  def ship_class_to_file(ship_class)
    if ship_class == 'Fighter'
      'icons/fighter.svg'
    elsif ship_class == 'Corvette'
      'icons/corvette.svg'
    elsif ship_class == 'Frigate'
      'icons/frigate.svg'
    elsif ship_class == 'Cruiser'
      'icons/cruiser.svg'
    else
      throw "Unknown ship class"
    end
  end

  def ship_class_embed(embed)
    ['Fighter', 'Corvette', 'Frigate', 'Cruiser'].each do |ship_class|
      embed.svg layout: 'ship-class-icon',
        key: ship_class_to_icon(ship_class),
        file: ship_class_to_file(ship_class)
    end
  end
end
