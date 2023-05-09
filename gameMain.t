#charset "us-ascii"
#include <tads.h>
#include "advlite.h"
#include "neoPronouns.t"
// Demonstration of excluding provided pronouns from game:
// #undef INCLUDE_ZE_ZIR
//
// This would let the author define their
// own version of Ze/Zir pronouns, and avoid conflicts.
//
// This can only be done between these two #include statements.
#include "providedPronouns.t"

gameMain: GameMainDef {
    initialPlayerChar = me
}

versionInfo: GameID {
    name = 'NeoPronouns Test'
    byline = 'by Joseph Cramsey'
    htmlByline = 'by <a href="mailto:josephcsoftware@gmail.com">Joseph Cramsey</a>'
    version = '1'
    authorEmail = ' josephcsoftware@gmail.com'
    desc = 'A test area for the NeoPronouns extension.'
    htmlDesc = 'A test area for the NeoPronouns extension.'
}

startRoom: Room { 'Test Room'
    "Simply a plain room. "
}

+me: Actor {
    person = 2
}

class TestActor: Actor {
    desc() {
        "{I} look at {him dobj}. {He dobj} {is} <<aName>>. {The subj dobj} {is} pretty neat.\n";
        local pronounList = valToList(pronouns);
        "Pronoun count: <<pronounList.length>>";
        for (local i = 1; i <= pronounList.length; i++) {
            "\n\t<<i>>: <<pronounList[i].name>>";
        }
        "\nReturned pronoun: <<pronoun().name>>";
        "\nReturned plurality: <<(plural != nil) ? 'true' : 'nil'>>";
    }
}

// Demonstration of binaries
+TestActor { 'silly man'
    pronouns = HeHim
}

+TestActor { 'silly woman'
    pronouns = SheHer
}

// Proper assignment of They/Them pronouns
// (Never use the 'Them' Pronoun object! Only use 'TheyThem'!)
+TestActor { 'silly person'
    pronouns = TheyThem
}

// Assignment of multiple pronouns
+TestActor { 'silly individual'
    pronouns = [
        VeVir,
        TheyThem
    ]
}

// Assignment of noun-self pronouns
+TestActor { 'silly bunkin'
    pronouns = 'bun'
}

// Proper declaration of plural objects
// This would be the only correct use for
//      pronouns = Them
// which would also set
//      plural = true
// automatically.
+TestActor { 'chickens'
    plural = true
}