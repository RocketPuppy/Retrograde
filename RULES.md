# Retrograde

Retrograde is designed to simulate the strategic and tactical decisions
necessary to successfully wage war in extra-terrestrial space.

## Simulation Considerations

The simulation makes a number of affordances to remain computationally
tractable. To start with, it is played with cards on a tabletop. It is not
played in real time, but in turns taken by each player. Additionally, each turn
happens as a sequence of distinct phases corresponding to the priorities of
battlefield decision-making. It is impractical to simulate the infinite variety
of spacecraft, strategic assets, and upgrades available so simulation operators
must select a set of simplified versions to work with for each simulation. As
the simulation proceeds new options become available to the operators to
simulate the variability of real combat.

### Deck

Each player in a game of Retrograde constructs a deck of cards that they draw
from over the course of the game. The deck contains 30 cards, arranged in an
order of the player's choosing. It is not shuffled before the game starts.
There are no other deck construction limits.

### Turns

Retrograde begins with each player drawing a hand of five cards from the top of
their decks. The players decide who goes first by chance. Each player than
alternates taking turns. Turns proceed with phases in the following order:

#### Upkeep

Turns start with an upkeep phase. It has the following steps:

1. If you have no homeworld, you lose the game.
2. Each of your assets orbit. Move the orbit token on your homeworld one space
   around the track.
3. Each spacecraft heals any damage to its armor.
4. Each asset heals any damage it sustained due to bombardment.

#### Maneuvers

After the upkeep phase you make any maneuvers you wish to make during this turn.

#### Construction/Research

After you are finished making maneuvers any assets, upgrades, or spacecraft
capable of research or construction may contribute research or construction
capacity.

#### End of Turn

At the end of the turn all cards that are tapped are untapped. All spacecraft
regenerate their delta-vee. Any end of turn effects trigger here.

## Strategic Options

Every operator begins the simulation with a strategy they are attempting to
execute. Of course no plan survives contact with the enemy, so expect to
improvise. The primary strategic options available to operators during the
simulation are construction and research. Additionally operators must plan to
wage war with a proper mix of assets, upgrades, and spacecraft.

### Construction

Assets are innately capable of constructing upgrades, spacecraft, and other
assets. They can only construct one thing at a time, however, so it is vitally
important to always be constructing the right things at the right time.

Any card under construction finishes construction and enters play when it has
a number of construction points on it equal to its construction attribute.
Spacecraft enter play in the closest orbital to the card that constructed them.
Upgrades enter play on top of the card that constructed them. Assets enter play
tapped, where they are being constructed.

To construct a spacecraft or upgrade on a card capable of construction, place it
tapped next to the card.

To construct an asset, place it upside down on your field of assets.

Each turn, the card doing construction may contribute a construction amount
equal to its factory attribute to a card being constructed on it. An asset may
contribute its construction amount to another asset instead of itself if neither
asset has enemy ships in orbit around it.

A card in the progress of constructing another card may have the card currently
under construction scrapped and replaced with a new card. This forfeits any
construction points on the old card.

Multiple assets may be under construction at the same time.

### Research

Assets are innately capable of research. A card may perform research during
a turn instead of contributing construction. When you research with a card it
becomes tapped, and you draw a card from your deck.

### Spacecraft

Your spacecraft are the primary mechanism of exerting your will on the
battlefield. Each spacecraft fills a specific strategic role based on its
performance in different areas. Spacecraft are divided into multiple ship
classes based on their size and general capabilities. Fighter craft are
generally cheap, lightly armed and armored, and highly maneuverable. Corvettes
are beefier cousins to fighter craft, generally more heavily armed with lower
maneuverability. Frigates are the workhorse of your fleet; heavily armed and
consistently maneuverable. Finally you have your capital ships, which are the
biggest, baddest ships in your fleet but vulnerable to sustained fire from
smaller craft.

- Construction: shows how many construction points this spacecraft requires
- Population: the amount of population this spacecraft consumes
- Armor: shows how much damage this spacecraft can take in a turn.
- Bombardment power: shows how much damage this spacecraft can contribute to an
  orbital bombardment
- Delta-vee: determines how many maneuvers this spacecraft can make in a turn,
  each maneuver costs a certain amount of delta-vee
- Accuracy: determines how many attempts this spacecraft can make when attacking
  another spacecraft
- Abilities: some spacecraft have special abilities that give them more tactical
  options

### Assets

Your assets are the beating heart of your military. They expand your reach and
forces by researching and constructing new cards. Each asset has a number of
characteristics that differentiate them both strategically and tactically. One
asset is your homeworld, signified by a star, and you start with it on the
field. You lose the game if your homeworld is destroyed.

Each asset requires a certain amount of construction until it is usable, shown
on the left side of the construction icon. The construction it contributes to
other cards is shown on the right side of the construction icon.

Each asset follows an orbital path around the sun. This is represented as
a delta-vee amount that changes each turn. Around the border of the assets is
printed four delta-vee values. The value on the top of the card is active first.
Each turn the next value printed clockwise becomes active. The active value is
referred to as the **current transfer cost**.

Each asset defines a set of orbitals that spacecraft can occupy. Each orbital
has an entry cost that specifies the amount of delta-vee required to enter it,
either entering from above or below. To enter an orbital a spacecraft pays the
orbital entry cost for the direction it is moving and moves to that orbital.

- Population: the asset adds this amount of population to your population total,
  allowing you to build more spacecraft
- Bombardment: the asset can withstand this much bombardment power
- Spacecraft classes: the asset can only construct spacecraft of these classes
- Abilities: some assets have special abilities that give them more strategic
  significance

### Upgrades

Upgrades can be constructed to give cards special abilities or modifiers they
wouldn't otherwise have. Upgrades have a bombardment resistance and may be
targeted for bombardment.

## Tactical Options

There are a wealth of tactical options available in the simulation to win the
war. These are collectively referred to as maneuvers, whether undertaken by an
asset, upgrade, or spacecraft.

### Burn

Any spacecraft may initiate a **Burn** maneuver to change its location. It may
move to another orbital on the same asset it is currently orbiting, or if it is
in the outermost orbital of the asset it may move to another asset. Changing
orbitals requires paying the entry cost for that orbital in the direction it is
moving. Changing to a new asset requires paying the current transfer cost of the
target asset.

### Scuttle

Any spacecraft may initiate a **Scuttle** maneuver. This costs no delta-vee. The
spacecraft is immediately destroyed and becomes debris in the same orbital it
was occupying before it was scuttled.

### Combat

Any spacecraft may initiate a **Combat** maneuver. The spacecraft commits an
amount of delta-vee it is willing to spend on combat. The operator chooses
a target that is in orbit around the same asset as the attacker. Combat proceeds
in the following steps.

1. The attacker calculates its maximum range in delta-vee. This is equal to the
   delta-vee it used on the maneuver, plus 1 for each orbital between it and the
   target if the attacker is in a higher orbital, plus any other modifiers.
2. The attacker calculates its accuracy. This is equal to the base accuracy
   stat, plus 1 for each orbital between it and the target if the attacker is in
   a lower orbital, plus any other modifiers.
3. The target calculates its maximum delta-vee. This is equal to the delta-vee
   listed on the card plus any modifiers.
4. The attacker makes their combat roll using a six-sided dice. It is successful
   if they roll lower than their range minus the target's maximum delta-vee. The
   attacker may attempt this roll a number of times equal to their accuracy.
5. If the attacker is successful they deal 1 damage, which is subtracted from
   the target's armor value. The target is destroyed if their armor value is
   0 or lower.

### Refit

Any spacecraft may initiate a **Refit** maneuver. This costs no delta-vee, and
may only be done with spacecraft that are in the lowest orbital around
a friendly asset. The operator may swap the spacecraft with one from their hand
of the same class and with the same construction cost. The new spacecraft may
not make any maneuvers this turn.

### Bombardment

A spacecraft may initiate a **Bombardment** maneuver. This costs all the
delta-vee for the spacecraft. The spacecraft does damage to the asset it is
currently orbiting equal to its bombardment power minus 1 for each orbital
between it and the asset. The asset is destroyed and flipped over if it sustains
damage equal to its bombardment resistance.

## Hazards

The primary hazard in space is running into something you weren't expecting.
A single paint chip travelling fast enough can destroy the largest capital ship.

### Debris

Every time a spacecraft is destroyed it is turned over and becomes debris in the
same orbital the spacecraft was in before it was destroyed. Spacecraft in an
orbital with debris have one fewer maximum delta-vee for each debris card in the
orbital with them. If a spacecraft has 0 or fewer maximum delta-vee in an
orbital with debris it is destroyed.
