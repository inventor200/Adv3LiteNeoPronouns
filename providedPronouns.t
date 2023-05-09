/////////////////////////////////////////////////////////////
//                 INCLUDED NEOPRONOUNS                    //
/////////////////////////////////////////////////////////////

#ifdef INCLUDE_E_EM
// E/Em
EEm: Pronoun {
    name = 'e'
    objName = 'em'
    possAdj = 'eir'
    possNoun = 'eirs'
    reflexive = Emself
}

grammar pronounPhrase(eir):  'eir' : PronounProduction
    pronoun = EEm
;

Emself: ReflexivePronoun {
    pronoun = EEm
    name = 'emself'
    objName = 'emself'
}

grammar pronounPhrase(emself): 'emself' : PronounProduction
    pronoun = Emself
;
#endif

#ifdef INCLUDE_XE_XEM
// Xe/Xem
XeXem: Pronoun {
    name = 'xe'
    objName = 'xem'
    possAdj = 'xir'
    possNoun = 'xirs'
    reflexive = Xemself
}

grammar pronounPhrase(xem):  'xem' : PronounProduction
    pronoun = XeXem
;

Xemself: ReflexivePronoun {
    pronoun = XeXem
    name = 'xemself'
    objName = 'xemself'
}

grammar pronounPhrase(xemself): 'xemself' : PronounProduction
    pronoun = Xemself
;
#endif

#ifdef INCLUDE_ZE_ZIR
// Ze/Zir
ZeZir: Pronoun {
    name = 'ze'
    objName = 'zir'
    possAdj = 'zir'
    possNoun = 'zirs'
    reflexive = Zirself
}

grammar pronounPhrase(zir):  'zir' : PronounProduction
    pronoun = ZeZir
;

Zirself: ReflexivePronoun {
    pronoun = ZeZir
    name = 'zirself'
    objName = 'zirself'
}

grammar pronounPhrase(zirself): 'zirself' : PronounProduction
    pronoun = Zirself
;
#endif

#ifdef INCLUDE_ZHE_ZHIM
// Zhe/Zhim
ZheZhim: Pronoun {
    name = 'zhe'
    objName = 'zhim'
    possAdj = 'zhir'
    possNoun = 'zhirs'
    reflexive = Zhimself
}

grammar pronounPhrase(zhim):  'zhim' : PronounProduction
    pronoun = ZheZhim
;

Zhimself: ReflexivePronoun {
    pronoun = ZheZhim
    name = 'zhimself'
    objName = 'zhimself'
}

grammar pronounPhrase(zhimself): 'zhimself' | 'zhirself' : PronounProduction
    pronoun = Zhimself
;
#endif

#ifdef INCLUDE_SIE_SIER
// Sie/Sier
SieSier: Pronoun {
    name = 'sie'
    objName = 'sier'
    possAdj = 'sier'
    possNoun = 'siers'
    reflexive = Sierself
}

grammar pronounPhrase(sier):  'sier' : PronounProduction
    pronoun = SieSier
;

Sierself: ReflexivePronoun {
    pronoun = SieSier
    name = 'sierself'
    objName = 'sierself'
}

grammar pronounPhrase(sierself): 'sierself' : PronounProduction
    pronoun = Sierself
;
#endif

#ifdef INCLUDE_CE_CIR
// Ce/Cir
CeCir: Pronoun {
    name = 'ce'
    objName = 'cir'
    possAdj = 'cir'
    possNoun = 'cirs'
    reflexive = Cirself
}

grammar pronounPhrase(cir):  'cir' : PronounProduction
    pronoun = CeCir
;

Cirself: ReflexivePronoun {
    pronoun = CeCir
    name = 'cirself'
    objName = 'cirself'
}

grammar pronounPhrase(cirself): 'cirself' : PronounProduction
    pronoun = Cirself
;
#endif

#ifdef INCLUDE_VE_VIR
// Ve/Vir
VeVir: Pronoun {
    name = 've'
    objName = 'vir'
    possAdj = 'vis'
    possNoun = 'vis'
    reflexive = Virself
}

grammar pronounPhrase(vir):  'vir' : PronounProduction
    pronoun = VeVir
;

Virself: ReflexivePronoun {
    pronoun = VeVir
    name = 'virself'
    objName = 'virself'
}

grammar pronounPhrase(virself): 'virself' : PronounProduction
    pronoun = Virself
;
#endif

#ifdef INCLUDE_FAE_FAER
// Fae/Faer
FaeFaer: Pronoun {
    name = 'fae'
    objName = 'faer'
    possAdj = 'faer'
    possNoun = 'faers'
    reflexive = Faerself
}

grammar pronounPhrase(faer):  'faer' : PronounProduction
    pronoun = FaeFaer
;

Faerself: ReflexivePronoun {
    pronoun = FaeFaer
    name = 'faerself'
    objName = 'faerself'
}

grammar pronounPhrase(faerself): 'faerself' : PronounProduction
    pronoun = Faerself
;
#endif