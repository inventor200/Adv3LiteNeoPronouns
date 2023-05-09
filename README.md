# NeoPronouns for TADS Adv3Lite
This extension allows for neopronoun support in Adv3Lite.  
**This is not guaranteed to work in Adv3 or other languages!**

## Defining New Pronouns
The process of defining new pronouns for characters is as follows:
```
// Li/Lin pronouns

// Main pronoun object
LiLin: Pronoun {
    name = 'li'           // As in: "Li grabs the cup."
    objName = 'lin'       // As in: "I give the cup to lin."
    possAdj = 'lir'       // As in: "That is lir cup." 
    possNoun = 'lirs'     // As in: "That cup is lirs."
    reflexive = Lirself   // Reference to the reflexive object
}

// Main pronoun grammar
grammar pronounPhrase(lin): 'lin' : PronounProduction
    pronoun = LiLin       // Reference to the main pronoun object
;

// Reflexive pronoun object
Linself: ReflexivePronoun {
    pronoun = LiLin       // Reference to the main pronoun object
    name = 'linself'      // As in: "Li accepts linself."
    objName = 'linself'
}

// Reflexive pronoun grammar
//
// Note the '|' (pipe) symbol.
// This means that both 'linself' and 'lirself' will be
// understood as the Linself relfexive pronoun.
//
grammar pronounPhrase(linself): 'linself' | 'lirself' : PronounProduction
    pronoun = Linself     // Reference to the reflexive object
;
```
**Ensure that the correct references are in the appropriate places! There are a lot of details to organize here!**

## Assigning Pronouns
### Old (Unsupported) Method
In previous Adv3Lite games, pronouns could be declared
with the following template syntax:
```
maia: Actor { 'Maia;;painter mathematician friend;her'
    "A wonderful painter and mathematician, and even better friend! "
}
```
However, the **pronoun section** (after the third semicolon of the **vocab string**)
is not supported with this extension.

### New (Supported) Method
The following examples will demonstrate how to assign pronouns, using this extension.

To begin, we can replicate the old Adv3Lite behavior with the following:
```
// Example 1
// Simple pronouns
maia: Actor { 'Maia;;painter mathematician friend'
    "A wonderful painter and mathematician, and even better friend! "

    // A single Pronoun object can be assigned here
    pronouns = SheHer
}
```
For characters with multiple accepted pronouns, a `List` or `Vector` can be used, like so:
```
// Example 2
// Complex pronouns
abiz: Actor { 'Abiz;;technician'
    "A skilled technician! "

    // A list can be used to declare He/They pronouns
    pronouns = [
        HeHim,
        TheyThem
    ]
}
```
This extension offers two variants for singular they/them pronouns.
This can be set with `TheyThem` or `TheyThemAlt`, like so:
```
// Example 3
// Correct use of "They"

// This character uses They/Them pronouns
chandra: Actor { 'Chandra;;comedian'
    "An energetic comedian! "

    // TheyThem is used for people with They/Them, and prefer
    // the term "themself" for reflexive form.
    pronouns = TheyThem

    // TheyThemAlt is used for people with They/Them, and prefer
    // the term "themselves" for reflexive form.
    // pronouns = TheyThemAlt
}
```
Noun-self identities are also supported in this extension.
```
// Example 4
// Noun-self pronouns ("bun/bunself", for example)
tara: Actor { 'Tara;;bunkin'
    "A shy bunkin! "

    // Setting a string for pronouns will use the string as
    // the root for a noun-self identity.
    pronouns = 'bun'
}
```
The `They` object can **only** be used for **inanimate objects**, while `TheyThem` and `TheyThemAlt` are used **only** for **animate persons**.
```
// Example 5
// Correct use of "They" and declaring true plurals

// The 'They' Pronoun object can only be used for inanimate objects, while
// 'TheyThem' and 'TheyThemAlt' are used only for animate persons.

// 'Them' can be assigned to declare a plural object
chickens: Actor { 'chickens'
    "A group of idle chickens! "

    // This will cause the Actor to truly be a plural object!
    pronouns = Them
}
```
Plural inanimate objects can also be set with `plural = true`, like so:
```
// Example 6
// Alternative method of declaring plural objects
rocks: Thing { 'rocks;shiny'
    "Some shiny rocks! "

    // This will automatically set pronouns to 'Them'
    plural = true
}
```
Ambiguously-plural objects (inanimate objects which match with both "they" and "it"), can be declare like so:
```
// Example 7
// Ambiguously-plural objects
rocks: Thing { 'pair[noun] of[prep] pants;;trousers bottoms'
    "A neat pair of pants! "

    // Make truly plural
    pronouns = Them
    // Also allow "it" to be used here
    ambiguouslyPlural = true
}
```

## Including NeoPronouns
To include neopronouns in your Adv3Lite game, simply add `neoPronouns.t` and `providedPronouns.t` (optional) to your project directory. Then, add the following lines to your code:
```
#include "neoPronouns.t"
#include "providedPronouns.t" // optional
```

## Avoiding Conflicts
Let's say you want to modify or exclude certain neopronouns from the game, and you're still including the others with `providedPronouns.t`. There are a set of preprocessor lines which can solve this problem for you.

```
// The #undef statements MUST go between these two include lines!
#include "neoPronouns.t"

// Excludes the provided ze/zir pronouns, in case you want to use
// define custom zi/zir pronouns instead, which could cause a
// parser conflict with ze/zir.
#undef INCLUDE_ZE_ZIR

// Excludes the provided fae/faer pronouns, in case no character in
// the game uses them, and the word "fae" comes up a lot to refer to
// other stuff in the story's setting.
#undef INCLUDE_FAE_FAER

// This must come AFTER the #undef statements!
#include "providedPronouns.t"
```

If you do not want to include any of the pronouns from `providedPronouns.t`, then you do not need to include that file.
### A List of Provided Pronouns (And Preprocessor Tags)
| Object    | Pronouns      | Exclusion Line            |
|-----------|---------------|---------------------------|
| `EEm`     | E/Em/Eir      | `#undef INCLUDE_E_EM`     |
| `XeXem`   | Xe/Xem/Xir    | `#undef INCLUDE_XE_XEM`   |
| `ZeZir`   | Ze/Zir/Zir    | `#undef INCLUDE_ZE_ZIR`   |
| `ZheZhim` | Zhe/Zhim/Zhir | `#undef INCLUDE_ZHE_ZHIM` |
| `SieSier` | Sie/Seir/Seir | `#undef INCLUDE_SIE_SIER` |
| `CeCir`   | Ce/Cir/Cir    | `#undef INCLUDE_CE_CIR`   |
| `VeVir`   | Ve/Vir/Vis    | `#undef INCLUDE_VE_VIR`   |
| `FaeFaer` | Fae/Faer/Faer | `#undef INCLUDE_FAE_FAER` |

### A List of Built-In Pronouns
| Object                | Pronouns                   | Notes                               |
|-----------------------|----------------------------|-------------------------------------|
| `HeHim`               | He/Him/His                 | Macro for `Him`                     |
| `SheHer`              | She/Her/Her                | Macro for `Her`                     |
| `ItIts`               | It/It/Its                  | Macro for `It`                      |
| `Them`                | They/Them/Their (plural)   | Intended for inanimate objects only |
| `TheyThem`            | They/Them/Their (singular) | Reflexive "themself" form           |
| `TheyThemAlt`         | They/Them/Their (singular) | Reflexive "themselves" form         |
| `TheyThemSingular`    | They/Them/Their (singular) | Macro for `TheyThem`                |
| `TheyThemSingularAlt` | They/Them/Their (singular) | Macro for `TheyThemAlt`             |
| `TheyThemAltSingular` | They/Them/Their (singular) | Macro for `TheyThemAlt`             |

## Modifying Name Properties
If you are planning to directly modify the `aName`, `theName`, etc properties, then it's best to wrap them like so:
```
reallySpecificObject: Thing { 'specific object'
    "A very specifically-defined object! "

    // The name can be set simply:
    name = 'object'

    // However, we can use simpleConj(str) to force verbs to conjugate with
    // this object, even if we assign animate 'TheyThem' pronouns.
    aName = (simpleConj('ahn object'))

    // We can also use forceConj(str, treatAsPlural) to have more deliberate
    // control over how verbs conjugate.
    theName = (forceConj('yon objects', true))

    // We can also defer to the pronoun to set the plural status.
    heName = (pronounConj().name)
}
```

This is because pronoun-carrying objects can dynamically change their own `plural` properties to force certain kinds of verb conjugations, and polling any of these **name** properties will need to either change or reset the `plural` status.

### Wrapper Methods
Detailed explanations of the conjugation wrappers are as follows:

`simpleConj(str)`  
Returns single-quoted string `str`, but **only after** setting the `plural` property to its "original" value. If an object uses `Them` pronouns, then `plural` will be set to **true**. However, if the object uses `TheyThem`, `It`, `HeHim`, or **any other pronouns**, then `plural` will be set to **nil**.

`forceConj(str)`  
`forceConj(str, treatAsPlural)`  
Returns single-quoted string `str`, but **only after** setting the `plural` property to whatever was passed for `treatAsPlural`. If no `treatAsPlural` argument was passed, then `plural` will be set to **nil**.

`pronounConj()`  
Returns the **main pronoun** used by this object *(normally the first in the list, or the only pronoun assigned)*, but **only after** setting the `plural` property to the pronoun's own `plural` property. Basically, this forces the object's `plural` status to agree with the pronoun.

### Affected Properties
The following name properties were modified in this extension:
```
aName = (simpleConj(ifPronoun(&name, aNameFrom(name))))
theName = (simpleConj(ifPronoun(&name, theNameFrom(name))))
theObjName = (simpleConj(ifPronoun(&objName, theNameFrom(name))))
objName = (simpleConj(name))
possAdj = (simpleConj(ifPronoun(&possAdj, '<<theName>><<possEnding>>')))
possNoun = (simpleConj(ifPronoun(&possNoun, '<<theName>><<possEnding>>')))
heName = (pronounConj().name)
himName = (pronounConj().objName)
herName = (pronounConj().possAdj)
hersName = (pronounConj().possNoun)
thatName = (pronounConj().thatName)
thatObjName = (pronounConj().thatObjName)
reflexiveName = (pronounConj().reflexive.name)
```

## A Note About Noun-Self Identities
Because noun-self pronouns are based so heavily on a root noun, they do not require the author to define the `Pronoun` and `grammar` objects. Instead, a new `NounSelfPronoun` is procedurally-generated from the noun string (and replaces the string). Additionally, the words generated from the identity's noun are added to the `Actor`'s noun list.

When vocab for a noun-self `Actor` is changed during runtime, these identity nouns will also be re-added.

## Main Pronouns Method
The `mainPronouns()` method is defined as the following:
```
// Evaluates the main Pronoun object to use.
mainPronouns() {
    local pronounList = valToList(pronouns);
    if (pronounList.length == 0) return It;
    return pronounList[1];
}
```
This also affects the `pronoun()` method from the original Adv3Lite library:
```
// Return a more general-case pronoun
pronoun() {
    switch (person) {
        case 1:
            return (plural ? Us : Me);
        case 2:
            return (plural ? Yall : You);   
    }
    return mainPronouns(); 
}
```
This means that while any pronouns from an `Actor`'s list can be used when referring to that `Actor`, the first `Pronoun` item in the list will be used when mentioning the `Actor` in text.

If you want to choose a different `Pronoun` for any reason, then you will want to override the `mainPronouns()` method.

```
// Example 1
// Randomness
isabel: Actor { 'Isabel'
    "A whimsical person who enjoys sports! "
    pronouns = [
        ItIts,
        SheHer
    ]

    mainPronouns() {
        // Isabel will be randomly described as "she" or "it"
        return pronouns[rand(2) + 1];
    }
}
```
```
// Example 2
// Actualization
river: Actor { 'River;;sculptor'
    "A sculptor, who is still sculpting {his dobj} own future! "

    pronouns = [
        HeHim,
        SheHer,
        TheyThemAlt
    ]

    isOutToPlayer = nil

    mainPronouns() {
        // River is AFAB, but wants to transition.
        // However, he is not out to the player, until
        // the game calls the comeOut() method.
        return pronouns[isOutToPlayer ? 1 : 2];
    }

    comeOut() {
        if (isOutToPlayer) return;

        "<.p>
        <q>Hey,</q> River says, <q>I trust you, and...
        I want to go by he/him. Thank you.</q>
        <.p>";

        // Change the listed pronouns
        isOutToPlayer = true;

        // Stop recognizing she/her
        pronouns = [
            HeHim,
            TheyThemAlt
        ];
    }
}
```