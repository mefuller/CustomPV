clear all;
UseUnitsMetric;

%tabulate some bolt/screw data and load in
%update SS material properties

%Nut material is stainless: Sn = 10 ksi
%windows on bosses: screw is steel, Ss = 80 ksi (grade 5)
%thread in window: "screw" is stainless, Ss = 10 ksi; need to correct area for tensile stress
%Windows:
%Schlieren: qty 20 x 8-32 screws, area = (6 + 0.25*pi)in2
%absorption w/boss: qty 4 x 8-32 screws, area = (0.25*pi)in2
%absorption thread-in: qty 1 x 1-8 screw, area = (0.25*pi)in2 (first guess: need to design o-ring seal)
%gas inlet: 6" CF flange connection: area = (0.25*pi*4*4)*in2, 16 x 5/16-24
%driver-driven interface: 4" diameter, 16 x 1/2-{13, 20} screws
%PT Thread in: 0.156" diam hole, 3/8-24 thread x 0.32" thread engagement
%flange on top hat: nut and bolt 80 ksi, 4" circle, 16 bolts, 1/2-13 bolt

%best guesses for now
Ss = 10*U.ksi; %allowable bolt stress
Sn = 10*U.ksi; %allowable stress in female thread material

%load information
P = 100*U.atm; %applied pressure to above area
Aload = (0.25*pi*0.156*0.156)*U.in2; %area experiencing pressure
nbolt = 1; %number of bolts on joint
preload = 0; %force on bolt due to tightening

Fbolt = preload + Aload*P/nbolt; %force on each bolt

%threaded connection information
TPI = 24/U.in; %threads per inch 
D = 0.375*U.in; %basic major diameter of thread #8 D = 0.164", #10 = 0.19"

[Q, FStensile, FSshear] = BoltLoad(Fbolt, Ss, Sn, D, TPI, U)
%Q: thread engagement length required
%FSt: tensile factor of safety
%FSs: shear factor of safety
'Minimum Nut Height (inch)'
Q./U.in
'Minimum bolt FS'
min(min(FStensile, FSshear))
