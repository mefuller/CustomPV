clear all;
UseUnitsMetric;

%Common allowable stresses
%Aluminum (6061): 40 ksi yield
%Grade 5 screw: 80 ksi yield
%304 stainless steel: 30 ksi yield 

%best guesses for now
Ss = 80*U.ksi; %allowable bolt stress
Sn = 30*U.ksi; %allowable stress in female thread material

%load information
%P = 100*U.atm; %applied pressure to above area
%Aload = (0.25*pi*0.156*0.156)*U.in2; %area experiencing pressure
%nbolt = 1; %number of bolts on joint
%preload = 0; %force on bolt due to tightening

Fbolt = 3000*U.lbf;%preload + Aload*P/nbolt; %force on each bolt

%threaded connection information
TPI = 24/U.in; %threads per inch 
D = 0.3125*U.in; %basic major diameter of thread #8 D = 0.164", #10 = 0.19"

[Q, FStensile, FSshear] = BoltLoad(Fbolt, Ss, Sn, D, TPI, U)
%Q: thread engagement length required
%FSt: tensile factor of safety
%FSs: shear factor of safety
'Minimum Nut Height (inch)'
Q./U.in
'Minimum bolt FS'
min(min(FStensile, FSshear))
