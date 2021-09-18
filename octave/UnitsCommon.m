U.AvNo       = 6.022140857e026/U.kgmole;
U.Rbar       = 8314.4621*U.kg*U.m*U.m/(U.sec*U.sec*U.degK*U.kgmole);
U.G          = 9.80665*U.m/(U.sec*U.sec);
U.RhoH2O     = 999.9973*U.kg/(U.m*U.m*U.m);

%U.AvNo       = 2.7319868e026/U.lbmole;
%U.Rbar       = 1.5453000e003*U.ft*U.lbf/(U.degR*U.lbmole);
%U.G          = 32.174000e000*U.ft/(U.sec*U.sec);
%U.RhoH2O     = 62.400000e000*U.lbm/(U.ft*U.ft*U.ft);


%EnglishUnits
U.slug       = 32.174*U.lbm;
U.oz         = U.lbm/16.0;
U.ton        = 2000.0*U.lbm; %short ton
U.LongTon    = 2240.0*U.lbm;
U.grain      = U.oz/437.5; %standard for both Troy and Avoirdupois Weight: 1 grain is exactly 0.06479891 gram
U.TroyOz     = 480.0*U.grain;
U.TroyLb     = 12.0*U.TroyOz;

U.in         = U.ft/12.0;
U.yard       = 3.0*U.ft;
U.StMile     = 5280.0*U.ft;
U.NaMile     = 6076.1155*U.ft;
U.rod        = 16.5*U.ft;
U.chain      = 4.0*U.rod;
U.furlong    = U.StMile/8.0;

U.ft2        = U.ft*U.ft;
U.in2        = U.in*U.in;
U.CirU_cmil  = 7.854e-007*U.in2;
U.acre       = U.chain*U.furlong;

U.ft3        = U.ft2*U.ft;
U.in3        = U.in2*U.in;
U.gal        = 231.0*U.in3;
U.bbl        = 42.0*U.gal; %barrel of oil, US and Canada
U.floz       = U.gal/128.0;
U.dram       = U.floz/16.0;

U.psf        = U.lbf/U.ft2;
U.psi        = U.lbf/U.in2;
U.ksi        = U.Kilo*U.psi;
U.inH2O      = 3.613e-002*U.psi;

U.mph        = U.StMile/U.hour;
U.knot       = U.NaMile/U.hour;

U.BTU        = 777.9*U.lbf*U.ft;

U.Hp         = 550.0*U.lbf*U.ft/U.sec;

U.GPM        = U.gal/U.min;

%MetricUnits
U.gram       = U.Milli*U.kg;
U.amu        = 1.6605e-27*U.kg;
U.gmmole     = U.Milli*U.kgmole;
U.tonne      = 1000.0*U.kg;

U.cm         = U.Centi*U.m;
U.mm         = U.Milli*U.m;
U.km         = U.Kilo*U.m;
U.angstrom   = 1.0e-10*U.m;

U.m2         = U.m*U.m;
U.cm2        = U.cm*U.cm;
U.mm2        = U.mm*U.mm;
U.hectare    = U.m2*10000.0;

U.m3         = U.m2*U.m;
U.cm3        = U.cm2*U.cm;
U.cc         = U.cm3;
U.liter      = U.Milli*U.m3;

U.N          = U.kg*U.m/(U.sec2*U.Gc);
U.dyne       = 1.0e-005*U.N;

U.Pa         = U.N/U.m2;
U.KPa        = U.Kilo*U.Pa;
U.MPa        = U.Mega*U.Pa;
U.atm        = 101325.0*U.Pa;
U.bar        = U.Mega*U.dyne/U.cm2;
U.millibar   = U.Kilo*U.dyne/U.cm2;
U.Torr       = U.atm/760.0;

U.kph        = U.km/U.hour;

U.J          = U.N*U.m;
U.KJ         = U.Kilo*U.J;
U.calorie    = 4.184*U.J; %updated by MEF to reflect chemistry norm
U.cal        = U.calorie;
U.Kcalorie   = U.Kilo*U.calorie;
U.Kcal       = U.Kcalorie;
U.erg        = 1.0e-007*U.J;

U.watt       = U.J/U.sec;
U.W          = U.watt;
U.KW         = U.Kilo*U.watt;

U.poise      = U.Deci*U.kg/(U.m*U.sec);
U.cp         = U.Centi*U.poise;

U.Stoke      = 1.0e-004*U.m2/U.sec;
U.CS         = U.Centi*U.Stoke;

U.amp        = U.coulomb/U.sec;
U.volt       = U.N*U.m/U.coulomb;

U.ohm        = U.volt/U.amp;
U.weber      = U.volt*U.sec;
U.farad      = U.coulomb/U.volt;
U.henry      = U.weber/U.amp;
U.faraday    = 96485.3415*U.coulomb/U.gmmole;

U.lightspeed = 2.99792458e8*U.m/U.sec;
U.Gconst     = 6.673e-011*U.N*U.m2/(U.kg*U.kg);

%one more value
U.Sg         = 1.0000000e000*U.RhoH2O;

%Particle Physics
U.kB         = U.Rbar/U.AvNo; %Boltzmann Constant
U.h          = 6.62606957e-34*U.J*U.sec; %Planck Constant
U.hbar       = U.h/(2*U.pi); %reduced Planck Constant
U.eV         = 1.602176565e-19*U.J; %electron-volt (energy, actually electron charge * 1V)
U.eVp        = U.eV/U.lightspeed; %eV for momentum(p); equal to 1 eV / c = c* electron mass
U.eVm        = U.eVp/U.lightspeed; %eV for mass(m); equal to 1 eV / c^2 = electron mass
U.eVT        = U.eV/U.kB; %eV for Temperature
U.hartree    = 2627.25677*U.KJ/U.gmmole;

%Radiation:
%activity 
U.Bq         = 1.0/U.sec; %Becquerel
U.Ci         = 3.7e10./U.sec; %Curie
U.Rd         = 1.0e6./U.sec; %Rutherford
%exposure
U.roentgen   = 2.58e-4*U.coulomb/U.kg; %Röntgen
%absorbed dose
U.Gy         = U.J/U.kg; %Gray
U.rad        = 0.01*U.Gy; %rad
%dose equivalent
U.Sv         = U.J/U.kg; %Sievert; weighted by radiation type
U.rem        = 0.01*U.Sv; %Röntgen equivalent man
