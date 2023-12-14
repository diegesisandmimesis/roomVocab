#charset "us-ascii"
//
// roomVocab.t
//
//	A simple TADS3/adv3 that makes it easier to refer to rooms in
//	actions.
//
//	The main points:
//
//		-Rooms without declared vocabulary automagically get
//		 their name and the literal "room" added to their
//		 vocabulary during preinit.
//
//		 This means for a room called "The Apothocary Shop",
//
//			>X SHOP
//			>X APOTHOCARY SHOP
//			>X ROOM
//
//		 ...will all examine the room (assuming that's where the
//		 player is).
//
//		-Actions on rooms adjacent to the player's current location
//		 will fail with playerActionMessages.roomUnseenAdjacent
//		 instead of playerActionMessages.mustBeVisibleMsg.  By
//		 default this will be
//
//			If you want to do anything with [room name],
//			you should go there first.
//
//		 ...instead of...
//
//			You cannot see that.
//
//
// UTILITY METHODS
//
//	The Room class definition is extended to have a couple of
//	utility methods:
//
//		isAdjacent(actor, rm)
//			Returns boolean true if there's an exit leading
//			from the actor's current location to the given room
//
//		exitList(actor?, cb?)
//			Returns a list of all the exits currently apparent
//			to the given actor (defaulting to gActor if none is
//			specified).
//
//			The second argument is an optional test fuction taking
//			two arguments:  the direction and destination of
//			a candidate exit.  A return value of true indicates
//			the exit should be added to the exitList() return
//			value.
//
//			Each entry in the return value is an instance
//			of DestInfo.
//
//		destinationList(actor?, cb?)
//			Like exitList() (above), but returns a list of
//			destinations (probably Rooms) instead of DestInfo
//			instances.
//			
//
#include <adv3.h>
#include <en_us.h>

#include "roomVocab.h"

// Module ID for the library
roomVocabModuleID: ModuleID {
        name = 'Room Vocab Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}
