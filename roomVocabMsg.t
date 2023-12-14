#charset "us-ascii"
//
// roomVocabMsg.t
//
//	Action messages for new room behaviors.
//
#include <adv3.h>
#include <en_us.h>

#include "roomVocab.h"

modify playerActionMessages
	// Generic failure message for trying actions on an adjacent
	// room.
	roomUnseenAdjacent(obj) {
		return('If {you/he} want{s} to do anything with
			<<obj.destName>>, {you/he} should go there first. ');
	}
;
