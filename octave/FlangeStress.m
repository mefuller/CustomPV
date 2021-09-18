function [sigmab, SRbc, SRid, ST, SH, C, A, n, tflange] = FlangeStress(P, Sf, Eyoung, B, g0, Sb, HG, G, q, U)

%ASME BPVC Section VIII Division I Appendix Y
%Metal-metal flush flange
%Assume symmetric half-depth o-ring groove
%Assume 90 degree flange joint, constant wall thickness (no taper)

%guesses for now
%Eyoung = 200e9*U.Pa; %elastic modulus of flange material
%A = 8*U.in; %flange OD, initial guess
%C = 6*U.in; %flange bolt circle diameter
%G = 5*U.in; %gasket/o-ring mean diameter

%HG = 0; %gasket sealing force, neglected at this time (unknown)
%Sb = 20*U.ksi; %allowable bolt stress
%Sf = S; %allowable stress in flange

%B = ID;
%g0 = twall;


%some bolt data and equations from ASME PVP2002-1087
BoltData;

%compact flange sizing
Cmin = B + 2*g0 + 2*Rmin(q) + 2*min(3*U.mm, g0/2.5); %minimum bolt circle diameter 
nmax = pi/asin(Bmin(q)/Cmin); %maximum number of bolts
Amin = Cmin + 2*Emin(q); %minimum flange OD

%apply compact flange sizing to this problem
n = 4*floor(nmax/4); %number of bolts, multiple of four as suggested by ASME PVP2002-1087
C = max(Cmin, G + 0.25*U.in + D(q)/2); %bolt circle diameter: guess to get started
A = C + 2*Emin(q); %flange OD
%%%%%%%%%%%


%Class 1 (identical flange pair), Category 1 (integral flange)
%Analysis follows Y-6.1 with input guesses for bolt area and thickness per Y-9
%See notation in Y-3
%%%Assume 90 degree flange joint (constant wall thickness)
g1 = g0;
h = 0;
f=1; %result of g1=g0 in figure 2-7.6
V = 0.550103; %result of g1=g0, figure 2-7.3
F = 0.908920; %result of g1=g0, figure 2-7.2

%%Other required values
R = (C-B)/2 - g1;
B1 = B+g1;
a = (A+C)/2/B1;
beta = (C+B1)/2/B1;
H = 0.785*G*G*P;
HD = 0.785*B*B*P;
HT = H - HD;
h0 = sqrt(B*g0);
hCmax = (A-C)/2;
hC = hCmax/2; %guess
hD = R + 0.5*g1; %table 2-6, integral flange
hG = (C-G)/2;
hT = (R + g1 + hG)/2; %table 2-6, integral flange
K = A/B;
Z = (K^2 + 1)/(K^2 - 1);
Mp = HD*hD + HT*hT + HG*hG;

%Estimation per Y-9 (eqns 39-44)
%need to write some kind of iterative loop here, e.g. set n=6 because that's enough bolts
%then loop on D and Ab to get reasonable ratio (clearance diameter D to bolt solid cross-section Ab)

ta = 2.45*sqrt(Mp/(Sf*(pi*C - n*D(q))));
Abprime = (H + 2*Mp/(A-C))/Sb;

tflange = 1.2*ta; % initial guess: Y-9 suggests multiply by 0.9, change to 1.2
Ab = 0.9*Abprime; %bolt cross-section initial guess

if (n*Ab1(q) < Ab)
    disp('Insufficient bolt cross-section: Increase number or diameter.');
end
Ab = n*Ab1(q); %update with actual bolt cross-section;

%Analysis of Y-6.1
%Table Y-6.1: eqns to follow
%Class 1 / category 1: eqns 5a, 7-13, 14a, 15a, 16a
AR = n*D(q)/C/pi;
rB = (4*atan(sqrt((1+AR)/(1-AR)))/sqrt(1-AR^2) - pi - 2*AR)/n;
Fprime = (g0^2)*(h0+F*tflange)/V;
Jp = (1/B1)*((hD/beta)+(hC/a)) + pi*rB;
Js = (1/B1)*((hD/beta)+(hC/a)) + pi*rB;

%eqn 5a: where/what is it?

%eqn 7:
Ms = Jp*Fprime*Mp/(tflange^3 + Js*Fprime);
%eqn 8:
thetaB = 5.46*(Js*Ms + Jp*Mp)/(Eyoung*pi*tflange^3);
%eqn 9:
HC = (Mp + Ms)/hC;
%eqn 10: operating bolt load
Wm1 = H + HG + HC;
%eqn 11: operating bolt stress
sigmab = Wm1/Ab;
%eqn 12: design prestress in bolts - is this as important as operating stress?

%eqn 13: radial flange stress, bolt circle
SRbc = 6*(Mp+Ms)/(tflange*tflange*(pi*C - n*D(q)));
%eqn 14a: radial flange stress, ID
SRid = -1*(2*F*tflange/(h0 + F*tflange) + 6)*Ms/(pi*B1*tflange*tflange);
%eqn 15a: tangential flange stress
ST = tflange*Eyoung*thetaB/B1 + ((2*F*tflange*Z)/(h0 + F*tflange) - 1.8)*(Ms/(pi*B1*tflange*tflange));
%eqn 16a: longitudinal hub stress
SH = (h0*Eyoung*thetaB*f*g0*g0)/(0.91*g1*g1*B1*V);
