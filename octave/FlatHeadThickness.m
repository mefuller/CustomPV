function [t] = FlatHeadThickness(C,E,P,d,S)
%values must be entered in consistent units

%ASME BPVC UG-34: Unstayed flat heads and covers
%C = coefficient from figure UG-34 or section UG-34
%E = joint efficiency
%P = design pressure
%d = relevant diameter
%S = maximum allowed stress in material
%t =  minimum head thickness

%not valid if bolting causes edge moment
t = d*sqrt(C*P/(S*E));
