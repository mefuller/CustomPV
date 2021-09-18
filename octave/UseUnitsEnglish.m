%identifier
global units = 'English';
global U;

%read in common base values
UnitsDef;

%EnglishBaseUnits
U.lbm        = U.DefinedUnit;
U.lbf        = U.DefinedUnit;
U.ft         = U.DefinedUnit;
U.degR       = U.DefinedUnit;
U.lbmole     = U.DefinedUnit;

%U.AvNo       = 2.7319868e026/U.lbmole;
%U.Rbar       = 1.5453000e003*U.ft*U.lbf/(U.degR*U.lbmole);
%U.G          = 32.174000e000*U.ft/(U.sec*U.sec);
%U.Gc         = U.G*U.lbm/U.lbf;
U.Gc          = 32.174000e000;

%U.RhoH2O     = 62.400000e000*U.lbm/(U.ft*U.ft*U.ft);

U.kg         = 2.204623e000*U.lbm;
U.m          = 3.280840e000*U.ft;
U.degK       = 1.800000e000*U.degR;
U.kgmole     = U.kg*U.lbmole/U.lbm;

%calculate units for base
UnitsCommon;
