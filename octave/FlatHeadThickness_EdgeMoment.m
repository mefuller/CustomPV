function [t] = FlatHeadThickness_EdgeMoment(C,E,P,d,S,W,hg)
%values must be entered in consistent units

%ASME BPVC UG-34: Unstayed flat heads and covers
%C = coefficient from figure UG-34 or section UG-34
%E = joint efficiency
%P = design pressure
%d = relevant diameter
%S = maximum allowed stress in material
%t =  minimum head thickness
%W = total bolt load for circular heads
%hg = gasket moment arm

%for case with edge moment
t = d*sqrt((C*P/(S*E)) + 1.9*W*hg/(S*E*(d^3)));
