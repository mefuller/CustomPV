%identifier
global units = 'Metric ';
global U;

%read in common base values
UnitsDef;

%MetricBaseUnits
U.kg         = U.DefinedUnit;
U.m          = U.DefinedUnit;
U.degK       = U.DefinedUnit;
U.kgmole     = U.DefinedUnit;

%U.AvNo       = 6.0248600e026/U.kgmole;
%U.Rbar       = 8316.96*U.kg*U.m*U.m/(U.sec*U.sec*U.degK*U.kgmole);
%U.G          = 9.80665*U.m/(U.sec*U.sec);
U.Gc         = 1.0;

%U.RhoH2O     = 999.9973*U.kg/(U.m*U.m*U.m);

U.lbm        = 0.45359305*U.kg;
U.lbf        = 4.4482216*U.kg*U.m/(U.sec*U.sec);
U.ft         = 3.0480000e-001*U.m;
U.degR       = U.degK/1.8;
U.lbmole     = U.lbm*U.kgmole/U.kg;

%calculate units for base
UnitsCommon;
