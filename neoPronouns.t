/*
 * NEOPRONOUNS
 * by Joseph Cramsey
 *
 * Allows an Adv3Lite author the ability to define any
 * kind of custom pronouns for a character!
 */

// To assign a pronoun, attach a Pronoun object to the
// object's pronouns property.

// Redefine a macro defined in advlite.h
#undef gActionListObj
#define gActionListObj (object: Thing { \
    plural = (gAction.reportList.length > 1 || gAction.reportList[1].plural); \
    pronouns = (gAction.reportList.length == 1 ? gAction.reportList[1].mainPronouns : Them); \
    name = gActionListStr; \
    qualified = true; \
})

// Utility functions for token alternatives
gGetLikelyActor() {
    if (gAction == nil) return dummy_;
    if (gActor == nil) return dummy_;
    return gActor;
}

gGetLikelyDobj() {
    if (gAction == nil) return dummy_;
    local likely = gDobj;
    if (likely == nil) likely = gVerifyDobj;
    if (likely == nil) return dummy_;
    return likely;
}

getLikelyIobj() {
    if (gAction == nil) return dummy_;
    local likely = gIobj;
    if (likely == nil) likely = gVerifyIobj;
    if (likely == nil) return dummy_;
    return likely;
}

// Macros for gActor
#define psubj_s gGetLikelyActor().psubj
#define Psubj_s gGetLikelyActor().Psubj
#define pmsubj_s gGetLikelyActor().pmsubj
#define Pmsubj_s gGetLikelyActor().Pmsubj
#define pobj_s gGetLikelyActor().pobj
#define Pobj_s gGetLikelyActor().Pobj
#define psadj_s gGetLikelyActor().psadj
#define Psadj_s gGetLikelyActor().Psadj
#define psnoun_s gGetLikelyActor().psnoun
#define Psnoun_s gGetLikelyActor().Psnoun
#define pself_s gGetLikelyActor().pself
#define Pself_s gGetLikelyActor().Pself
#define nsubj_s gGetLikelyActor().nsubj
#define Nsubj_s gGetLikelyActor().Nsubj
#define nmsubj_s gGetLikelyActor().nmsubj
#define Nmsubj_s gGetLikelyActor().Nmsubj
#define nobj_s gGetLikelyActor().nobj
#define Nobj_s gGetLikelyActor().Nobj
#define nsadj_s gGetLikelyActor().nsadj
#define Nsadj_s gGetLikelyActor().Nsadj
#define nsnoun_s gGetLikelyActor().nsnoun
#define Nsnoun_s gGetLikelyActor().Nsnoun
#define nself_s pself_s
#define Nself_s Pself_s

// Macros for dobj
#define psubj_d gGetLikelyDobj().psubj
#define Psubj_d gGetLikelyDobj().Psubj
#define pmsubj_d gGetLikelyDobj().pmsubj
#define Pmsubj_d gGetLikelyDobj().Pmsubj
#define pobj_d gGetLikelyDobj().pobj
#define Pobj_d gGetLikelyDobj().Pobj
#define psadj_d gGetLikelyDobj().psadj
#define Psadj_d gGetLikelyDobj().Psadj
#define psnoun_d gGetLikelyDobj().psnoun
#define Psnoun_d gGetLikelyDobj().Psnoun
#define pself_d gGetLikelyDobj().pself
#define Pself_d gGetLikelyDobj().Pself
#define nsubj_d gGetLikelyDobj().nsubj
#define Nsubj_d gGetLikelyDobj().Nsubj
#define nmsubj_d gGetLikelyDobj().nmsubj
#define Nmsubj_d gGetLikelyDobj().Nmsubj
#define nobj_d gGetLikelyDobj().nobj
#define Nobj_d gGetLikelyDobj().Nobj
#define nsadj_d gGetLikelyDobj().nsadj
#define Nsadj_d gGetLikelyDobj().Nsadj
#define nsnoun_d gGetLikelyDobj().nsnoun
#define Nsnoun_d gGetLikelyDobj().Nsnoun
#define nself_d pself_d
#define Nself_d Pself_d

// Macros for iobj
#define psubj_i gGetLikelyIobj().psubj
#define Psubj_i gGetLikelyIobj().Psubj
#define pmsubj_i gGetLikelyIobj().pmsubj
#define Pmsubj_i gGetLikelyIobj().Pmsubj
#define pobj_i gGetLikelyIobj().pobj
#define Pobj_i gGetLikelyIobj().Pobj
#define psadj_i gGetLikelyIobj().psadj
#define Psadj_i gGetLikelyIobj().Psadj
#define psnoun_i gGetLikelyIobj().psnoun
#define Psnoun_i gGetLikelyIobj().Psnoun
#define pself_i gGetLikelyIobj().pself
#define Pself_i gGetLikelyIobj().Pself
#define nsubj_i gGetLikelyIobj().nsubj
#define Nsubj_i gGetLikelyIobj().Nsubj
#define nmsubj_i gGetLikelyIobj().nmsubj
#define Nmsubj_i gGetLikelyIobj().Nmsubj
#define nobj_i gGetLikelyIobj().nobj
#define Nobj_i gGetLikelyIobj().Nobj
#define nsadj_i gGetLikelyIobj().nsadj
#define Nsadj_i gGetLikelyIobj().Nsadj
#define nsnoun_i gGetLikelyIobj().nsnoun
#define Nsnoun_i gGetLikelyIobj().Nsnoun
#define nself_i pself_i
#define Nself_i Pself_i

// Modifying some default items to respect the new system
modify bodyParts {
    ambiguouslyPlural = true
}

// Modify some stuff from thing.t
modify LMentionable {
    // This points to the pronouns of the object.
    // In cases where a character has pronouns like "she/they",
    // this could also be a list.
    // For noun-self identities, this can be a string.
    // If this is nil, then the object will default to It.
    pronouns = It

    // Ensures conjugation is correct, by using a plural hack
    originallyPlural() {
        local pronounList = valToList(pronouns);
        if (pronounList.length == 0 || pronounList.length > 1) return nil;
        // Only objects with Them pronouns were declared plural.
        // They/Them characters are declared with
        // either TheyThem or TheyThemAlt pronouns.
        return pronounList[1] == Them;
    }

    simpleConj(str) {
        plural = originallyPlural();
        return str;
    }

    pronounConj() {
        local cachePronoun = pronoun();
        plural = cachePronoun.plural;
        return cachePronoun;
    }

    aNameFrom(str) {
        plural = originallyPlural();
        return inherited(str);
    }

    forceConj(str, treatAsPlural?) {
        plural = treatAsPlural;
        return str;
    }

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

    // Evaluates the main Pronoun object to use.
    mainPronouns() {
        local pronounList = valToList(pronouns);
        if (pronounList.length == 0) return It;
        return pronounList[1];
    }

    // This returns true if Pronoun p matches any of the object's pronouns
    matchPronoun(p) {
        // Create the pronouns list.
        local pronounList = valToList(pronouns);
        if (pronounList.length == 0) pronounList = [It];

        // We can be very loosey-goosey about matching "they/them",
        // because there are so many situations where it could apply.
        if (
            p == Them ||
            p == TheyThem ||
            p == TheyThemAlt
        ) {
            local matchesPlural =
                (pronounList.indexOf(Them) != nil) ||
                (pronounList.indexOf(TheyThem) != nil) ||
                (pronounList.indexOf(TheyThemAlt) != nil);
            return
                plural ||
                ambiguouslyPlural ||
                matchesPlural;
        }

        // Matching for singulars, which could match an
        // ambiguously-plural object.
        return (!plural || ambiguouslyPlural) &&
            (pronounList.indexOf(p) != nil);
    }

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

    // Checks for a possible pre-defined noun-self vocab word
    checkNounSelfVocab(str) {
        for (local i = 1; i <= vocabWords.length; i++) {
            // Found already
            if (vocabWords[i].wordStr.toLower() == str) return nil;
        }

        // Clear for adding
        return true;
    }

    // Add noun-self vocab
    addNounSelfVocab(str, role) {
        if (checkNounSelfVocab(str)) {
            initVocabWord(str, role);
        }
    }

    // Modifying the initVocab method to recognize new pronouns
    initVocab() {
        // Absolutely trash any attempts to use this, and safely use fallbacks.
        isHim = nil;
        isHer = nil;
        isIt = true;

        if (person == 1) {
            name = plural ? 'we' : 'I';
        }
        
        if (person == 2) {
            name = 'you';
        }

        local nounSelfList = new Vector(3);

        local pronounList = valToList(pronouns);

        // Assign default pronoun, if not found.
        if (pronounList.length == 0) {
            pronouns = plural ? Them : It;
            pronounList = [pronouns];
        }
        
        for (local i = 1; i <= pronounList.length; i++) {
            local cpro = pronounList[i];
            if (!cpro.ofKind(Pronoun)) {
                local nounIdentity = toString(cpro).trim();
                pronounList[i] = new NounSelfPronoun(nounIdentity);
                cpro = pronounList[i];
                if (pronounList.length == 1) {
                    // If there was only one pronoun, then it's
                    // not really a list, innit?
                    pronouns = cpro;
                }
                else {
                    // If there was a list, then replace the
                    // element in the list.
                    pronouns[i] = cpro;
                }
            }

            // If we are resetting vocab, then this will catch
            // the already-made noun-self pronouns.
            if (cpro.ofKind(NounSelfPronoun)) {
                nounSelfList.append(cpro);
            }
        }
        
        if (vocab == nil || vocab == '') return;

        inheritVocab();

        vocabWords = new Vector(10);

        /* 
         *   get the initial string; we'll break it down as we work
         *   At the same time change any weak tokens of the form
         *   (tok) into tok[weak], so that they're effectively treated
         *   as prepositions (i.e. they won't match alone)
         */
        local str = vocab.findReplace(R'<lparen>.*?<rparen>', 
                                      {s: s.substr(2, s.length - 2) +
                                      (s == '()' ? '()' : '[weak]')});
        local parts = str.split(';').mapAll({x: x.trim()});
        
        #ifdef __DEBUG
        // Modified this warning to accommodate the new pronoun rules.
        if(parts.length > 4) {
            "<b><FONT COLOR=RED>WARNING!</b></FONT> ";
            "Too many semicolons in vocab string '<<vocab>>'; there should be a
            maximum of two, separating three different sections.\n";
        }
        #endif

        local shortName = parts[1].trim();

        /* 
         *   if the short name is all in title case, and 'proper' isn't
         *   explicitly set, mark it as a proper name 
         */
        if (propDefined(&proper, PropDefGetClass) == Mentionable
            && rexMatch(properNamePat, shortName) != nil
        ) {
            proper = true;
        }

        local tentativeName = shortName;

        // split the name into individual words
        local wlst = shortName.split(' '), wlen = wlst.length();

        // check for an article at the start of the phrase
        local i = 1;
        if (wlen > 0 && wlst[1] is in('a', 'an', 'some', 'the', '()')) {
            /* check which word we have */
            switch (wlst[1]) {
                case 'a':
                case 'an':
                    /* 
                    *   if this doesn't match what we'd synthesize by default
                    *   from the second word, add the word as a special case 
                    */
                    if (wlen > 1 && aNameFrom(wlst[2]) != '<<wlst[1]>> <<wlst[2]>>')
                        specialAOrAn[wlst[2]] = (wlst[1] == 'a' ? 1 : 2);
                    break;
                case 'some':
                    // mark this as a mass noun
                    massNoun = true;
                    break;
                case '()':            
                    // mark this as a qualified name
                    qualified = true;
                    break;
                case 'the':
                    qualified = true;
                    wlst[1] = '!!!&&&';
                    break;
            }

            // It's a special flag, not a vocabulary word - skip it
            i++;

            // Trim this word from the tentative name as well
            tentativeName = tentativeName.findReplace(
                wlst[1], '', ReplaceOnce
            ).trim();
        }

        /* 
         *   If there's no 'name' property already, assign the name from
         *   the short name string.  Remove any of the special annotations
         *   for parts of speech or plural forms. 
         */
        if (name == nil && tentativeName != '') {
            name = tentativeName.findReplace(deannotatePat, '', ReplaceAll);
        }

        /* 
         *   Process each word in the short name.  Assume each is an
         *   adjective except the last word of the first phrase, which we
         *   assume is a noun.  We treat everything in a prepositional
         *   phrase (i.e., any phrase beyond the first) as an adjective,
         *   because it effectively modifies the main phrase: a "pile of
         *   paper" is effectively a paper pile; a "key to the front door
         *   of the house" is effectively a front door house key.  
         */
        local firstPhrase = true;
        for ( ; i <= wlen; i++) {
            /* get this word and the next one */
            local w = wlst[i].trim();
            local wnxt = (i + 1 <= wlen ? wlst[i+1] : nil);

            /* 
             *   If this word is one of our prepositions, enter it without
             *   a part of speech - it doesn't count towards a match when
             *   parsing input, since it's so non-specific, but it's not
             *   rejected either.  
             *   
             *   If the *next* word is a preposition, or there's no next
             *   word, this is the last word in a sub-phrase.  If this is
             *   the first sub-phrase, enter the word as a noun.
             *   Otherwise, enter it as an adjective.  
             */
            local pos;
            if (rexMatch(prepWordPat, w) != nil) {
                // It's a preposition
                pos = MatchPrep;

                /* 
                 *   If the next word is an article, skip it.  Articles in
                 *   the name phrase don't count as vocabulary words, since
                 *   the parser strips these out when matching objects to
                 *   input.  (That doesn't mean the parser ignores
                 *   articles, though.  It parses them in input and
                 *   respects the meaning they convey, but it does that
                 *   internally, sparing the object name matcher the
                 *   trouble of dealing with them.)  
                 */
                if (wnxt is in ('a', 'an', 'the', 'some')) {
                    i++;
                }
            }
            else if (rexMatch(weakWordPat, w) != nil) {
                /* It's a weak token */
                pos = MatchWeak;
            }
            else if (
                firstPhrase &&
                (wnxt == nil || rexMatch(prepWordPat, wnxt) != nil)
            ) {
                // It's the last word in the first phrase - it's a noun
                pos = MatchNoun;
                // We've just left the first phrase
                firstPhrase = nil;
            }
            else {
                // Anything else is an adjective
                pos = MatchAdj;
            }

            // Enter the word under the part of speech we settled on
            initVocabWord(w, pos);
        }
        
        // The second section is the list of adjectives
        if (parts.length() >= 2 && parts[2] != '') {
            local frags = parts[2].split(' ');
            frags.forEach({
                x: initVocabWord(x.trim(), MatchAdj)
            });
            
            #ifdef __DEBUG
            /* 
             *   If we're compiling for debugging, issue a warning if a pronoun
             *   appears in the adjective section. We exclude 'her' from the
             *   list of pronouns we test for here since 'her' in the adjective
             *   section could be intended as the female possessive pronoun. But
             *   only carry out this check for a Thing, since a Topic might
             *   legally have pronouns in any section.
             */
            frags.forEach(function(x){
                if (ofKind(Thing)) {
                    for (local i = 1; i <= Pronoun.all.length; i++) {
                        local pro = Pronoun.all[i];
                        if (pro.objName == pro.possAdj) continue;
                        if (pro.objName != x.trim().toLower()) continue;
                        "<b><FONT COLOR=RED>WARNING!</FONT></B> ";
                        "Pronoun '<<x>>' appears in adjective section (after first
                        semicolon) of vocab string '<<vocab>>'. This may mean the
                        vocab string has too few semicolons.\n";
                        showPronounDebugWarning();
                    }
                }
            });
            #endif
        }

        // The third section is the list of nouns
        if (parts.length() >= 3 && parts[3] != '') {
            local frags = parts[3].split(' ');
            frags.forEach({
                x: initVocabWord(x.trim(), MatchNoun)
            });
            
            #ifdef __DEBUG
            frags.forEach(function(x) {
                if (ofKind(Thing)) {
                    for (local i = 1; i <= Pronoun.all.length; i++) {
                        local pro = Pronoun.all[i];
                        if (pro.objName != x.trim().toLower()) continue;
                        "<b><FONT COLOR=RED>WARNING!</FONT></B> ";
                        "Pronoun '<<x>>' appears in noun section (after second
                        semicolon) of vocab string '<<vocab>>'. This may mean the
                        vocab string has too few semicolons.\n";
                        showPronounDebugWarning();
                    }
                }
            });
            #endif
        }
        
        //Add noun-self vocab, if applicable
        for (local i = 1; i <= nounSelfList.length; i++) {
            local cpro = nounSelfList[i];
            addNounSelfVocab(cpro.possAdj, MatchAdj);
            addNounSelfVocab(cpro.name, MatchNoun);
            addNounSelfVocab(cpro.reflexive.name, MatchNoun);
        }

        #ifdef __DEBUG
        // The fourth section is the list of pronouns.
        // However, since it has been overhauled, we will show a
        // warning to anyone trying to use this.
        //
        // The bodyParts object is simply being weird about this, so
        // we ignore it here.
        if (parts.length() >= 4 && parts[4] != '' && self != bodyParts) {
            "<b><FONT COLOR=RED>WARNING!</FONT></B> ";
            "\^<<name>> is trying to use the pronoun section of the vocab
            string ('<<parts[4]>>', after the third semicolon).\n";
            showPronounDebugWarning();
        }
        #endif

        // Turn vocabWords back into a list
        vocabWords = vocabWords.toList();

        // Cache the plural flag for simple objects
        if (pronouns == It && plural) {
            pronouns = Them;
        }

        if (pronouns == Them) {
            plural = true;
        }
    }

    #ifdef __DEBUG
    showPronounDebugWarning() {
        "This use of pronouns in vocab is not supported
        by Joseph Cramsey's NeoPronouns extension.\n
        To set pronouns, you must assign values to the
        '<tt>plural</tt>', '<tt>ambiguouslyPlural</tt>',
        and '<tt>pronouns</tt>' properties of an object. Please note
        that '<tt>isIt</tt>', '<tt>isHim</tt>', and '<tt>isHer</tt>'
        are all ignored properties with this extension as well!\n";
    }
    #endif

    psubj() { return heName + '{dummy}'; }
    Psubj() { return '\^' + heName + '{dummy}'; }
    pmsubj() { return heName; }
    Pmsubj() { return '\^' + heName; }
    pobj() { return himName; }
    Pobj() { return '\^' + himName; }
    psadj() { return herName; }
    Psadj() { return '\^' + herName; }
    psnoun() { return hersName; }
    Psnoun() { return '\^' + hersName; }
    pself() { return reflexiveName; }
    Pself() { return '\^' + reflexiveName; }
    nsubj() { return theName + '{dummy}'; }
    Nsubj() { return '\^' + theName + '{dummy}'; }
    nmsubj() { return theName; }
    Nmsubj() { return '\^' + theName; }
    nobj() { return objName; }
    Nobj() { return '\^' + objName; }
    nsadj() { return possAdj; }
    Nsadj() { return '\^' + possAdj; }
    nsnoun() { return possNoun; }
    Nsnoun() { return '\^' + possNoun; }
    nself() { return pself; }
    Nself() { return Pself; }
}

modify pronounPreinit {
    // Cleaned up this method, and moved functionality to
    // the Pronoun objects themselves.
    execute() {
        // Retained from the original source
        //
        // Fills in the "that" forms, if we haven't already
        foreach (local pro in Pronoun.all) {
            if (pro.thatName == nil) {
                pro.thatName = pro.name;
            }
            if (pro.thatObjName == nil) {
                pro.thatObjName = pro.objName;
            }
        }

        // Create the pronoun map for LMentionable
        LMentionable.pronounMap = new LookupTable(16, 32);
        forEachInstance(Pronoun, function(p) {
            LMentionable.pronounMap[p.name] = p;
            if (p.objName != nil) {
                LMentionable.pronounMap[p.objName] = p;
            }
        });

        // Ensure the prepositions are still being initialized
        In.prep = 'in';
        Outside.prep = 'on';
        On.prep = 'on';
        Under.prep = 'under';
        Behind.prep = 'behind';
        Held.prep = 'held by';
        Worn.prep = 'worn by';
        Attached.prep = 'attached to';
        PartOf.prep = 'part of';
    }
}

/*
 *   Get the pronoun for a resolved (or partially resolved) NounPhrase list
 *   from a command. 
 */
replace npListPronoun(pro, nplst, prep) {
    /* 
     *   The prep starts with '(', it means that we should omit this role
     *   from queries about other roles 
     */
    if (prep.startsWith('(')) return '';

    // If there's no noun phrase, return nothing
    if (nplst.length() == 0) return '';

    // If we have more than one noun phrase, it's obviously 'them'
    if (nplst.length() > 1) return '<<prep>> them';

    // We have a single noun phrase - retrieve it */
    local np = nplst[1];

    // If it explicitly refers to multiple objects, use 'them'
    if (np.matches.length() > 1 && np.isMultiple()) {
        return '<<prep>> them';
    }

    // Run through the matches and check for genders
    local matchedPronouns = new Vector(Pronoun.all.length);
    for (local i = 1; i <= Pronoun.all.length; i++) {
        matchedPronouns.append(Pronoun.all[i]);
    }

    foreach (local m in np.matches) {
        for (local i = 1; i <= matchedPronouns.length; i++) {
            local cpro = matchedPronouns[i];
            if (!m.obj.matchPronoun(cpro)) {
                matchedPronouns.removeElementAt[i];
            }
        }
    }

    // If all matches agree on a pronoun, use it, otherwise use 'it'
    if (matchedPronouns.length >= 1) {
        local cpro = matchedPronouns[1];
        return '<<prep>> <<cpro.objName>>';
    }

    return '<<prep>> <<pro>>';
}

modify SubComponent {
    nameAs(parent) {
        name = parent.name;
        proper = parent.proper;
        qualified = parent.qualified;
        person = parent.person;
        plural = parent.plural;
        massNoun = parent.massNoun;
        pronouns = parent.pronouns;
    }
}

// Modifying some stuff from action.t
modify TopicTAction {
    /* 
     *   This is a bit of a kludge to deal with the fact that the Parser doesn't
     *   seem able to resolve pronouns within ResolvedTopics. We do it here
     *   instead.
     */    
    resolvePronouns() {
        if (curIobj == nil) return;
        
        for (local cur in curIobj.topicList, local i = 1;; i++) {
            if (curDobj.matchPronoun(cur)) {
                curIobj.topicList[i] = curDobj;
            }
        }
    }
}

class PronounAnteList: object {
    construct(cpro) {
        pronoun = cpro;
        list = [];
    }

    pronoun = nil
    list = nil
}

// Note the objects in objlist as potential pronoun antecedents
replace notePronounAntecedent([objlist]) {
    local listVec = new Vector(Pronoun.all.length);
    for (local i = 1; i <= Pronoun.all.length; i++) {
        listVec.append(new PronounAnteList(Pronoun.all[i]));
    }
    
    /* 
     *   Go through each object in objlist and add it to the appropriate pronoun
     *   list
     */
    foreach (local cur in objlist) {
        /* 
         *   If we refer to a SubComponent, we're really referring to its
         *   location
         */        
        while (cur.ofKind(SubComponent) && cur.location != nil) {
            cur = cur.location;
        }
        
        /* 
         *   Add the object and any of its facets to the himList, herList and
         *   itList according to whether it's isHim, isHer or isIt property is
         *   true.
         */
        local lst = valToList(cur.getFacets) + cur;

        for (local i = 1; i <= listVec.length; i++) {
            local proList = listVec[i];
            if (cur.matchPronoun(proList.pronoun)) {
                for (local obj in lst) proList.list += obj;
            }
        }
    }
    
    /* 
     *   If any of the lists have anything in them, use them to set the
     *   antecedent list on the corresponding pronoun.
     */
    for (local i = 1; i <= listVec.length; i++) {
        local proList = listVec[i];
        if (proList.list.length > 0) {
            proList.pronoun.setAntecedents(proList.list);
        }
    }
}

// Modifying some stuff from actions.t
modify ImplicitConversationAction {
    /* 
     *   This is a bit of a kludge to deal with the fact that the Parser doesn't
     *   seem able to resolve pronouns within ResolvedTopics. We do it here
     *   instead.
     */
    resolvePronouns() {
        local actor = gPlayerChar.currentInterlocutor;
        for (local cur in topics, local i = 1;; i++) {
            if (actor.matchPronoun(cur)) {
                topics[i] = actor;
            }
        }
    }
}

// Non-third-person pronouns
modify You {
    name = 'you'
    objName = 'you'
    possAdj = 'your'
    possNoun = 'yours'
    reflexive = Yourself
}

modify Yourself {
    name = 'yourself'
    objName = 'yourself'
}

modify Yall {
    name = 'you'
    objName = 'you'
    possAdj = 'your'
    possNoun = 'yours'
    reflexive = Yourselves
    plural = true
}

modify Yourselves {
    name = 'yourselves'
    objName = 'yourselves'
}

modify Me {
    name = 'I'
    objName = 'me'
    possAdj = 'my'
    possNoun = 'mine'
    reflexive = Myself
}

modify Myself {
    name = 'myself'
    objName = 'myself'
}

modify Us {
    name = 'we'
    objName = 'us'
    possAdj = 'our'
    possNoun = 'ours'
    reflexive = Ourselves
    plural = true
}

modify Ourselves {
    name = 'ourselves'
    objName = 'ourselves'
}

// Third-person pronouns
#define ItIts It
modify It {
    name = 'it'
    objName = 'it'
    possAdj = 'its'
    possNoun = 'its'
    thatName = 'that'
    thatObjName = 'that'
    reflexive = Itself
}

modify Itself {
    name = 'itself'
    objName = 'itself'
}

#define SheHer Her
modify Her {
    name = 'she'
    objName = 'her'
    possAdj = 'her'
    possNoun = 'hers'
    reflexive = Herself
}

modify Herself {
    name = 'herself'
    objName = 'herself'
}

#define HeHim Him
modify Him {
    name = 'he'
    objName = 'him'
    possAdj = 'his'
    possNoun = 'his'
    reflexive = Himself
}

modify Himself {
    name = 'himself'
    objName = 'himself'
}

modify Them {
    name = 'they'
    objName = 'them'
    possAdj = 'their'
    possNoun = 'theirs'
    thatName = 'those'
    thatObjName = 'those'
    reflexive = Themselves
    plural = true
}

modify Themselves {
    name = 'themselves'
    objName = 'themselves'
}

// DO NOT USE "Them" FOR A CHARACTER!
// USE EITHER "TheyThem" or "TheyThemAlt" INSTEAD!
// BY USING "Them", THE CHARACTER WILL BE PERMANENTLY PLURAL!

// Singular they/them with "themself" for reflexive
#define TheyThemSingular TheyThem
TheyThem: Pronoun {
    name = 'they'
    objName = 'them'
    possAdj = 'their'
    possNoun = 'theirs'
    reflexive = TheyThemReflexive
    plural = true
}

TheyThemReflexive: ReflexivePronoun {
    pronoun = TheyThem
    name = 'themself'
    objName = 'themself'
}

// Singular they/them with "themselves" for reflexive
#define TheyThemSingularAlt TheyThemAlt
#define TheyThemAltSingular TheyThemAlt
TheyThemAlt: Pronoun {
    name = 'they'
    objName = 'them'
    possAdj = 'their'
    possNoun = 'theirs'
    reflexive = TheyThemAltReflexive
    plural = true
}

TheyThemAltReflexive: ReflexivePronoun {
    pronoun = TheyThemAlt
    name = 'themselves'
    objName = 'themselves'
}

// This is a procedural class for creating
// noun-self identities, such a bun/bunself, etc.
// Assigning this to the pronouns property will invoke
// a noun-self identity, like so:
//
//      nounSelfPerson: Actor { 'Bunny' 
//          pronouns = 'bun'
//      }
//
class NounSelfPronoun: Pronoun {
    // Noun-self identities do not need to be recognized as
    // pronouns by the parser, as it can be handled with nouns
    // instead. For this reason, we are overriding the part of
    // the original constructor which adds the pronoun to the
    // "all" list.
    construct(nounIdentity) {
        name = nounIdentity;
        objName = nounIdentity;
        possAdj = nounIdentity + 's';
        possNoun = nounIdentity + 's';
        thatName = nounIdentity;
        thatObjName = nounIdentity;
        reflexive = new NounSelfReflexivePronoun();
        reflexive.reflexive = reflexive;
        reflexive.pronoun = self;
        reflexive.name = nounIdentity + 'self';
        reflexive.objName = reflexive.name;
    }
}

class NounSelfReflexivePronoun: NounSelfPronoun {
    construct() { }
    resolve() { return pronoun; }
    pronoun = nil
    person = (pronoun.person)
}

// Definition switches
// Use #undef (switchname) to prevent the pronoun from being included.
// This is in case the author wants to prevent custom pronouns
// from conflicting with provided ones.
#define INCLUDE_E_EM true
#define INCLUDE_XE_XEM true
#define INCLUDE_ZE_ZIR true
#define INCLUDE_ZHE_ZHIM true
#define INCLUDE_SIE_SIER true
#define INCLUDE_CE_CIR true
#define INCLUDE_VE_VIR true
#define INCLUDE_FAE_FAER true
