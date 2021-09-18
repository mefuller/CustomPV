%identical values, regardless of system of units
U.DefinedUnit = 1.0;

%SI Prefixes
U.Tera  = 1.0e012;
U.Giga  = 1.0e009;
U.Mega  = 1.0e006;
U.Kilo  = 1.0e003;
U.Hecto = 1.0e002;
U.Deka  = 1.0e001;
U.Deci  = 1.0e-001;
U.Centi = 1.0e-002;
U.Milli = 1.0e-003;
U.Micro = 1.0e-006;
U.Nano  = 1.0e-009;
U.Pico  = 1.0e-012;
U.Femto = 1.0e-015;

%Tera  = U.Tera;
%Giga  = U.Giga;
%Mega  = U.Mega;
%Kilo  = U.Kilo;
%Hecto = U.Hecto;
%Deca  = U.Deca;
%Deci  = U.Deci;
%Centi = U.Centi;
%Milli = U.Milli;
%Micro = U.Micro;
%Nano  = U.Nano;
%Pico  = U.Pico;

%English Prefixes
%M     = U.Kilo;
%MM    = U.Mega;

%Common Values
U.pi         = 3.141592653589793238;

U.sec        = U.DefinedUnit;
U.rad        = U.DefinedUnit;
U.coulomb    = U.DefinedUnit;

U.min        = 60.0*U.sec;
U.hour       = 60.0*U.min;
U.day        = 24.0*U.hour;
U.week       =  7.0*U.day;

U.sec2       = U.sec*U.sec;
U.sec3       = U.sec2*U.sec;

U.degree     = U.pi*U.rad/180.0;
U.rev        = 2.0*U.pi*U.rad;

U.RPS        = U.rev/U.sec;
U.RPM        = U.rev/U.min;
U.Hz         = 1.0/U.sec;
U.cHz        = U.RPS;
