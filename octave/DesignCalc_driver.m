%Design equations and notes for Shock Tube
%
%Notes: Updated 7 Nov 2014
%   (I) Estimate E=1 for joint efficiency
%   (I) Estimate 10 ksi max allowed stress (should be low/conservative)
%   (II) Need to verify if non-round interior has special design equations
%   (III) Update gasket/o-ring diameter
%   (IV) Dummy value for o-ring groove depth

clear all;

%import units
UseUnitsMetric;
%UseUnitsEnglish;

%flag for design failure
OKall = 1;

%assuming Parker 1/4" nominal o-rings
ORdepth = 0.206*U.in; %o-ring full groove depth
ORwidth = 0.312*U.in; %o-ring groove width
ORcross = 0.275*U.in; %o-ring cross-section diameter

%I: Wall thickness of cylindrical sections %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASME BPVC Section VIII Division I UG-27: thickness of cylindrical sections
Ejoint = 1; %joint efficiency
P = 20*U.atm; %design pressure
ID = 15.5*U.in; %internal diameter
S = 10*U.ksi; %maximum allowed stress in material: very conservative

[twall,OK] = WallThickness(Ejoint,P,ID/2,S);
OKall = min(OKall, OK);

%N.B. As of March 2015, going with round mixing section - no squares!
%II: Wall thickness for squared mixing section %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%same design equations as for round section by using maximum radius (check this)
%SqSide = 5*U.in;

%[tsq, OKsq] = WallThickness(Ejoint,P,sqrt(2)*SqSide/2,S);
%OKall = min(OKall, OKsq);


%III: Flange and bolt circle design %%%%%
%ASME BPVC Section VIII Division I Appendix Y
%Assume metal-metal flush flange with symmetric half-depth o-ring groove

%Class 1, Category 1 flange
%Analysis follows Y-6.1 with input guesses for bolt area and thickness per Y-9

%See notation in Y-3
%some initial guesses
Eyoung = 200e9*U.Pa; %elastic modulus of flange material

%gasket mean diameter is ID plus twice wall thickness plus groove width plus something? (necessary standoff)
G = ID + 2*twall + ORwidth; %gasket/o-ring mean diameter
OD_oring = G + ORcross; %O-ring OD
ID_oring = G - ORcross; %o-ring ID
HG = pi*OD_oring*80*U.N/U.cm; %gasket sealing force, estimated

Sb = 80*U.ksi; %allowable bolt stress: 100 ksi is approx. grade 8, 80 ksi is approx grade 5
Sf = S; %allowable stress in flange

%bolt choice: index q
q = 1;
FlangeOK = 0;

while (FlangeOK == 0)
    [sigmab, SRbc, SRid, ST, SH, d, FlangeOD, nbolt, tflange] = FlangeStress(P, Sf, Eyoung, ID, twall, Sb, HG, G, q, U);
    %return bolthole circle diameter, d, above for use in head design

    if (sigmab > Sb)
        disp('Bolt stress too high, factor:');
        sigmab/Sb
    end
    if (max([SRbc, SRid, ST, SH]) > Sf)
        disp('Flange stress too high, factor:');
        max([SRbc, SRid, ST, SH])/Sf
    end
    if (sigmab < Sb) && (max([SRbc, SRid, ST, SH]) < Sf)
        FlangeOK=1;
    else
        q = q+1;
    end
end

%Do a quick load analysis on bolts in joint: nut and bolt same material
BoltData;
Fbolt = (HG + (0.25*pi*ID*ID)*P)/nbolt

[Q, FSt, FSs] = BoltLoad(Fbolt, Sb, Sb, BoltSize(q), TPI(q), U);

%IV: Flat head for far end %%%%%%
%ASME BPVC Section VIII Division I UG-34: Unstayed flat heads and covers
%Assume no edge moment for o-ring flange (metal-metal, flush)
%Figure UG-34 (p) provides design coefficient C
%Assume that UG-34(p) appropriate if thickness increased by depth of o-ring groove:
%Then:
C = 0.3; %design parameter from figure UG-34: full-face gasket

%see lab notebook for first guess
hgroove = 0; %o-ring groove depth on each face (assume full depth)
d = 21.25*U.in;
hg = 2*U.in;

%o-ring seal results in edge moment
[theadmin] = FlatHeadThickness_EdgeMoment(C,Ejoint,P,d,S,Fbolt*nbolt,hg)
theadtotal = theadmin + hgroove;

%V: Report Results
'Wall thickness (inch)'
twall/U.in
'Flange OD (inch)'
FlangeOD/U.in
'O-ring outside diameter (inch)'
OD_oring/U.in
'O-ring inside diameter (inch)'
ID_oring/U.in
'Gasket sealing force (lbf)'
HG/U.lbf
'Bolt Circle (inch)'
d/U.in
'Flange thickness'
tflange/U.in
'Number of bolts'
nbolt
'Bolt diameter (inch)'
BoltSize(q)/U.in
'Flat head thickness (inch)'
theadtotal/U.in
'Minimum Nut Height (inch)'
Q./U.in
'Minimum bolt FS'
min(min(FSt, FSs))
