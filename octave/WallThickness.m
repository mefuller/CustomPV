function [t,OK] = WallThickness(E,P,R,S)
%values must be entered in consistent units

%ASME BPVC UG-27: thickness of cylindrical sections
%E = joint efficiency
%P = design pressure
%R = internal radius
%S = maximum allowed stress in material
%t =  minimum shell thickness

%UG-27 Eqn. 1:
t1 = P*R/(S*E - 0.6*P);

%UG-27 Eqn. 2
t2 = P*R/(2*S*E + 0.4*P);

%determine minimum thickness
t = max(t1,t2);

%default return
OK = 1;

%check all restrictions met:
if t > 0.5*R
    disp('Thickness exceeds half of inner radius. Design Invalid.');
    OK = 0;
end
if P > 0.385*S*E
    disp('Pressure exceeds 0.385*SE. Design Invalid.');
    OK = 0;
end
