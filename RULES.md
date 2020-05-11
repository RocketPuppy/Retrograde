# Deck Construction
* 30 cards arranged in any order you like
* 1 homeworld
* Do not shuffle

# Before the game
* Determine who goes first by chance
* Place homeworlds face up on each side of the field
* Draw five cards

# Turn phases
1. Upkeep
2. Maneuvers
3. Research
4. Repair
5. Construction
6. End of turn

## Upkeep
1. If you have no homeworld, you lose the game.
2. The orbit counter increases by 1. At 4 it wraps around to 1 again.
3. Each of your spacecraft heals any damage they sustained since your last turn.
5. Each of your spacecraft regenerate their delta-vee.

## Maneuvers
Any card capable of making maneuvers does so now.

## Research
Any card capable of research does so now.

## Repair
Assets may repair any damage they've sustained now.

## Construction
Any card capable of construction does so now.

## End of turn.
Any of your cards that were tapped are untapped. Any end of turn effects trigger.

# Maneuvers
A card attempting a manuever must pay the maneuver cost and then complete the maneuver.
A card cannot attempt a maneuver without paying the cost.
If they pay the cost and cannot complete the maneuver the cost is not refunded.

## Burn
* Any spacecraft may initiate a burn to change the orbital it is located in.
* Consume an amount of delta-vee equal to the entry cost of an orbital directly above or below you: move to that orbital.
* If on the outermost orbital, consume an amount of delta-vee equal to the transfer cost of a target asset plus the entry cost of the outermost orbital on that asset: move to the outermost orbital on the asset.

## Scuttle
* Any spacecraft may initiate a scuttle maneuver.
* No cost: destroy this spaceship.

## Combat
* Any spacecraft may initiate a combat maneuver.
* Consume X delta-vee: begin combat with a target spacecraft.
    1. Calculate maximum range of the attacker
        * Maximum range is equal to X delta-vee plus 1 for each orbital between it and the target if the target is in a higher orbital plus any modifiers.
    2. Calculate accuracy of the attacker
        * Accuracy is equal to the base accuracy plus 1 for each orbital between it and the target if the target is in a lower orbital plus any modifiers.
    3. Calculate targets defensive delta-vee
        * Defensive delta-vee is equal to the delta-vee left on the spacecraft plus any modifiers.
    4. The attacker rolls a six-sided dice.
    They hit the target if they roll lower than their maximum range minux the target's defensive delta-vee.
    The attacker makes a number of rolls equal to their accuracy.
    5. For each hit the attacker deals one damage to the target.
    6. If the target has a number of damage equal to or greater than their armor, then the target is destroyed.

## Refit
* Any spacecraft may initiate a refit maneuver.
* If this spacecraft is in the lowest orbital around a friendly asset, no cost: swap this spacecraft with one from your hand of the same class and construction cost.
The new spacecraft may not make any maneuvers this turn.

## Bombardment
* Any spacecraft may initiate a bombardment maneuver.
* Consume the maximum delta-vee on this spacecraft: begin bombardment of the asset or its upgrade currently being orbited.
    1. Calculate bombardment power.
        * Bombardment power is equal to the base bombardment power on the card minus one for each orbital between the card and the asset.
    2. Do damage equal to the bombardment power to the asset.
    3. If the asset has a number of damage equal to or greater than their bombardment resistence, the asset is destroyed.

# Destroyed cards

## Assets
* Destroyed assets are rotated upside down.
* They may still be orbited but do not contribute construction, research, population, or abilities.
* Any spacecraft or upgrade under construction by the asset when it is destroyed is removed from the game.
* Any constructed upgrades on the asset are destroyed.

## Spacecraft
* Destroyed spacecraft are flipped face down and become debris.

## Upgrades
* Destroyed upgrades are removed from the game.

# Debris
* At the end of the turn, your spacecraft with zero delta-vee in an orbital that contains debris take one point of damage for each debris in the orbital.

# Research
* Each turn, any untapped asset may perform research.
* An asset that performs research becomes tapped.
* Draw one card when an asset performs research.

# Repair
* Each turn, any untapped asset may repair any damage they've sustained.
* An asset that repairs damage removes 1 damage from itself.
* An asset that repairs damage becomes tapped.

# Construction
* Each turn, any untapped asset may allocate its construction power in one of three ways.
    * An asset may contribute all of its construction power as construction points to a spacecraft under construction on it.
    * An asset may contribute all of its construction power as construction points to an upgrade under construction on it.
    * An asset may contribute all of its construction power as construction points to an asset currently under construction, if no enemy ships are in orbit around either asset.
* If an asset is allocating construction power for a turn, it becomes tapped.

## Constructing Spacecraft
* Construction points may only be applied to spacecraft if the contributing card has a matching construction facility.
* Place the spacecraft to be constructed facedown on or next to the asset.
* When the spacecraft has construction points greater than or equal to its construction cost, you may have it enter play faceup in the lowest orbital on the asset.
* A spacecraft may not complete construction if its construction would put it over the population limit.

## Constructing Upgrades
* Place the upgrade to be constructed facedown on or next to the asset.
* When the upgrade has construction points greater than or equal to its construction cost, it enters play faceup underneath the asset that constructed it.
* A newly constructed upgrade replaces any upgrade currently installed on the asset.

## Constructing Assets
* Place the asset to be constructed facedown on the asset field.
* When the asset has construction points greater than or equal to its construction cost, it enters play faceup.

# Spacecraft
* Class: fighter, corvette, frigate, capital.
    * Spacecraft can only be constructed if the card doing construction has a facility matching the class.
* Construction cost: Shows how many construction points this spacecraft requires.
* Armor: shows how much damage the spacecraft can sustain in a turn.
    * If a spacecraft has damage greater than or equal to its armor, it is destroyed.
* Bombardment power: shows how much damage this spacecraft can contribute to an orbital bombardment.
* Delta-vee: shows the maximum delta-vee a spacecraft can consume to make maneuvers each turn.
* Accuracy: shows the minimum number of attempts this spacecraft can make when attacking other spacecraft.
* Abilities: Any special abilities that the spacecraft might have.
* Population: The amount of population consumed when this spacecraft is constructed.

# Assets
* Construction cost: left side of the construction icon, shows how many construction points this asset requires.
* Construction power: right side of the construction icon, shows how many points of construction this asset contributes.
* Transfer cost: Shows how much delta-vee is required to transfer to this asset.
    * Each turn, the transfer cost proceeds to the next value on the card border in clockwise order.
* Orbitals: Representation of orbital space around the asset.
    * Each orbital has an entry cost.
    * Spacecraft around an asset are arranged vertically corresponding to the orbital they are in.
* Bombardment resistance: Shows the amount of damage the asset can sustain from bombardment.
    * If the asset has damage greater than or equal to its bombardment resistence it is destroyed.
* Factory classes: shows the classes of spacecraft that can be constructed at this asset.
* Abilities: Any special abilities the asset might have.
* Population: The amount of population this asset adds to your population total.

# Upgrades
* Construction cost: shows how many construction points this asset requires.
* Bombardment resistance: Shows the amount of damage this upgrade can sustain from bombardment.
    * If the upgrade has damage greater than or equal to its bombardment resistence it is destroyed.
* Abilities: Any special abilities the upgrade might have.
     
     
  
