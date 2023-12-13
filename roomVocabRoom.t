#charset "us-ascii"
//
// roomVocabRoom.t
//
#include <adv3.h>
#include <en_us.h>

#include "roomVocab.h"

modify Room
	// If this is true on an instance, we'll set up vocabulary for it
	// doing preinit.
	initializeVocab = true

	// By default, we use the room's destination name as its disambig
	// name.
	disambigName = destName

	// A room's vocabularly likelihood is normal if the player is
	// adjacent to the room, low otherwise.
	vocabLikelihood = (isAdjacent(gActor, self) ? 0 : -30)

	// Make sure we have an actor.
	_canonicalizeActor(actor) { return(actor ? actor : gActor); }

	// Check to see if the given object's location is adjacent to
	// the given room.
	isAdjacent(obj, rm) {
		local src;

		if(_canonicalizeActor(obj) == nil)
			return(nil);

		if(((src = obj.getOutermostRoom()) == nil) || !src.ofKind(Room))
			return(nil);

		return(src.exitList(obj).indexOf(rm) != nil);
	}

	// Get all of the exits available to the given actor from this room.
	// Second arg is an optional callback.  See allDirectionsExitList() for
	// details.
	exitList(actor?, cb?) {
		return(allDirectionsExitList(actor, cb));
	}

	// Returns a list of all the exits from this room that are apparent to
	// the given actor, that correspond to the canonical directions.
	// Second arg is an optional arg to be used as a test function.  If
	// given, the callback will be called with the direction and
	// destination of each candidate exit, and exits will only be added to
	// the return vector if the callback returns true.
	allDirectionsExitList(actor?, cb?) {
		local c, dst, r;

		r = new Vector(Direction.allDirections.length());

		if(_canonicalizeActor(actor) == nil)
			return(r);

		// Iterate through all directions.
		Direction.allDirections.forEach(function(d) {
			// Get the connector for the given actor, in the
			// given direction.
			if((c = getTravelConnector(d, actor)) == nil)
				return;

			// If the connector isn't apparent to the actor,
			// skip it.
			if(!c.isConnectorApparent(self, actor))
				return;

			// Get the connector's destination.
			if((dst = c.getDestination(self, actor)) == nil)
				return;

			// If we have a callback, call it with the direction
			// and destination and bail if the return value is
			// not boolean true.
			if((cb != nil) && ((cb)(d, dst) != true))
				return;

			// Add the destination to the return vector.
			r.append(new DestInfo(d, dst, nil, nil));
		});

		return(r);
	}

	getExtraScopeItems(actor) {
		local v;

		v = new Vector();
		exitList(actor).forEach(function(o) {
			v.append(o.dest_);
		});

		return(v.toList());
	}
;
