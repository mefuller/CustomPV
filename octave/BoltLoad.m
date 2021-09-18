function [Q, FStensile, FSshear] = BoltLoad(Fbolt, Ss, Sn, D, TPI, U)%P, Aload, nbolt, preload, 
%Q: thread engagement length required
%FSt: tensile factor of safety
%FSs: shear factor of safety

%UseUnitsMetric;

%tabulate some bolt/screw data and load in
%update SS material properties

%best guesses for now
%Ss = 100*U.ksi; %allowable bolt stress
%Sn = 10*U.ksi; %allowable stress in female thread material: update with material data from SolidWorks (also in DesignCalc)

%load information
%P = 100*U.atm; %applied pressure to above area
%Aload = (0.25*pi + 4)*U.in2; %area experiencing pressure
%nbolt = 8; %number of bolts on joint
%preload = 0; %force on bolt due to tightening

%Fbolt = preload + Aload*P/nbolt; %force on each bolt

%threaded connection information
%TPI = 13/U.in; %threads per inch 
%D = 0.5*U.in; %basic major diameter of thread

%ISO and UTS thread design: verify with handbook
%use these values as input to male/female thread parameters
H = sqrt(3)*0.5/TPI; %thread height is cos(30deg)/TPI = (sqrt(3)/2)/TPI
Dmajor = D; %major diameter
Dminor = Dmajor - 2*(5/8)*H;
Dpitch = Dmajor - 2*(3/8)*H;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Machinery's Handbook, 29th pp1536-1537

%bolt data
Ds = Dmajor; %minimum major diameter external thread
Es = Dpitch; %minimum pitch diameter external thread

%female thread
Kn = Dminor; %maximum minor diameter internal thread
En = Dpitch; %maximum pitch diameter internal thread

%tensile stress area: formulae given based on screw allowable stress (27th Ed. pp1510-1511; revised to 180 ksi ultimate tensile in 29th ed.)
if Ss > 100*U.ksi
    At = pi*((0.5*Es - 0.16238/TPI)^2)
else
    At = 0.7854*((D - 0.9743/TPI)^2)
end
Atalt = 0.25*pi*Dminor*Dminor

%shear stress areas per unit length of engagement
AsL = pi*TPI*Kn*((0.5/TPI) + 0.57735*(Es - Kn)); %male thread shear area
AnL = pi*TPI*Ds*((0.5/TPI) + 0.57735*(Ds - En)); %female thread shear area

%Correction factor to default thread engagement length
J = max(1, (AsL*Ss/(AnL*Sn))); %use ratio of allowable stress instead of ratio of tensile strength

%thread engagement
Le = 2.*At/(pi*Kn*(0.5 + 0.57735*TPI*(Es - Kn))) %default value
Q = J*Le; %corrected required engagement length

%shear stress areas
As = Q*AsL;
An = Q*AnL;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tensile stress
Stensile = Fbolt./At;

%tensile factor of safety
FStensile = Ss./Stensile; %bolt

%shear stress
Sshear = Fbolt./[As, An]; %male, female thread

%shear factor of safety
FSshear = [Ss, Sn]./Sshear;
