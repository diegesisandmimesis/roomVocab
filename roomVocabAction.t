#charset "us-ascii"
//
// roomVocabAction.t
//
#include <adv3.h>
#include <en_us.h>

#include "roomVocab.h"

modify objVisible
	verifyPreCondition(obj) {
		if((obj != nil) && !gActor.canSee(obj))
			visibilityComplaints(obj);
	}

	visibilityComplaints(obj) {
		if(!gActor.isLocationLit()) {
			inaccessible(&tooDarkMsg);
		} else if(obj.ofKind(Room)) {
			inaccessible('If {you/he} want{s} to do anything with <<obj.theName>>, {you/he} should go there first.');
		} else if(obj.soundPresence && gActor.canHear(obj)) {
			inaccessible(&heardButNotSeenMsg, obj);
		} else if(obj.smellPresence && canSmell(obj)) {
			inaccessible(&smelledButNotSeenMsg, obj);
		} else {
			inaccessible(&mustBeVisibleMsg, obj);
		}
	}
		
;
