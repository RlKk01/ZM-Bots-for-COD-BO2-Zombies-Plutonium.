#include common_scripts\utility;
#include maps\_utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zombies\_zm_ai_basic;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_score;
#include maps\mp\zombies\_zm_turned;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zombies\_zm_weap_claymore;
#include maps\mp\zombies\_zm_powerups;
#include maps\mp\zombies\_zm_laststand;

// Player connection callback
on_player_connect()
{
	level endon("end_game");

	for(;;)
	{
		level waittill("connected", player);
	}
}

// Auto-start the connection monitoring when script loads
init()
{
	level thread on_player_connect();
}

// Custom implementation of NodeVisible function
// Checks if two points are visible to each other
NodeVisible(origin1, origin2)
{
	// Add small vertical offset to account for ground level
	origin1 = origin1 + (0, 0, 10);
	origin2 = origin2 + (0, 0, 10);

	// Check line of sight between points
	return SightTracePassed(origin1, origin2, false, undefined);
}

get_random_walkable_location(origin, range, player)
{
	tries = 0;
	for(;;)
	{
		x = origin[0] + randomintrange(range * -1,range);
		y = origin[1] + randomintrange(range * -1,range);
		z = origin[2] + randomintrange(range * -1,range);
		if(check_point_in_playable_area( (x,y,z) ))
		{
			return (x,y,z);
		}
		if(tries == 1000)
		{
			if(isDefined(player))
			{
				get_players()[0] iprintln(player.name + " failed the check 1000 times!");
			}
			return false;
		}
		tries += 1;
		wait 0.01;
	}
}