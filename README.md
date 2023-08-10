# Garry's Mod Supply Depot Script Addon
This is just the LUA side of a Supply Depot for my second Garry's Mod LUA addon. It is a supply depot system that allows players to supply and repair a depot that can be attacked by players or take damage from NPCs. Since this is my second addon, it still is fairly primitive, but I have introduced the use of classes and objects, class-based functions, meta-tables, and many more complex concepts. I even introduced an interactive menu and while it is slightly unintuitive, it is functional (just spam it several times). You can press E on the Supply Depot and view the contents of it. It does require the repair kit from my Gravity Generator addon to work completely, so I recommend adding that to your server if you intend on using this addon.

# Known "Issues"

While the addon seems simple in concept, it took a lot of time to implement. Especially the combination of crates. They are not just respawned entities with just a single model, they are through LUA, welded to one another and move together in unison. The proper fix for this would be 
to simply make my own models and just swap the model of the entity, but I figured it would be a nice challenge to try and get these crates to stick together. 

# Gameplay Tips

When combining crates of the same type (you cannot combine whatever crates you want), the first crate can just make contact with the same one practically from any way you can imagine. The third crate should be placed directly on-top of the right crate when you have a double. The fourth is the trickiest, but I have found it pretty consistently connects if you aim to collide the fourth one just under the center of where the three connected crates connect. If you consider it like a graph plane, where (0,0) would be. Also, disable FPP if being used on a server that uses Dark RP as the gamemode.

# Features

- Pressing 'E' on singular crates gives you the ammo or equipment (for the bacta crate, it full heals you).
- Over time, equipment gets "used" and your inventory shrinks, giving players something to do every so-often.
- Players can press "E" on the Supply Depot to see the Supply Depot inventory levels.
- Players can use the repair kit on the supply depot if it has been damaged to repair it. Only takes damage when it is attacked, not degrades over time like my gravity generator script.
- Crates can be stacked into doubles, triples, and quads. If they are not singular, you cannot open them up to use their supplies.
- Colored indicator towards the bottom to show what percent of the supply depot's total inventory has been filled (changes color every 30-40%).
