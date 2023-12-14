#charset "us-ascii"
//
// roomVocabPreinit.t
//
//	Preinit object for setting up vocabulary on Room instances.
//
#include <adv3.h>
#include <en_us.h>

#include "roomVocab.h"

// Preinit object that sets up vocabulary for rooms (if they don't already
// have vocabulary defined)
roomVocabPreinit: PreinitObject
	execute() {
		forEachInstance(Room, function(o) {
			// Check to see if we're supposed to initialize
			// the vocabulary for this room.
			if(o.initializeVocab != true)
				return;

			// Make sure the room doesn't already have vocabulary
			// defined.
			if(o.vocabWords.length > 1)
				return;

			// Default to the roomName and the literal "room".
			o.initializeVocabWith(o.roomName + '/room');
		});
	}
;
