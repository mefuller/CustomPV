clear all
UseUnitsMetric;

%Gas: He
He.MW = 4.0.*U.kg/U.kgmole;
He.R = U.Rbar/He.MW;
He.k = 5.0/3.0;
He.PCr = (2.0/(He.k +1.0))^(-1.0*He.k/(He.k -1.0));

%Gas: N2
N2.MW = 28.0.*U.kg/U.kgmole;
N2.R = U.Rbar/N2.MW;
N2.k = 7.0/5.0;
N2.PCr = (2.0/(N2.k +1.0))^(-1.0*N2.k/(N2.k -1.0));

%Volume 1: Can
Pt1(1) = 220.0.*U.psi;
Tt1 = 293.0.*U.degK;
V1 = 67.0.*U.in3;
m1(1) = Pt1(1)*V1/Tt1/He.R;

%Volume2: Dump Tank
Pt2(1) = 1.0.*U.psi; %arbitrary, low vacuum
Tt2 = Tt1;
V2 = 231.0.*U.in3; %one gallon sample cylinder
m2(1) = Pt2(1)*V2/Tt2/He.R;

%orifice and discharge
CdA_max = 0.8*0.25*pi*U.in2; %1" diameter initial guess
tau_open = 0.4*U.sec; %opening time

%fwd Euler simple stepper
t(1)=0.0;
dt = 1.0e-6*U.sec; %step size
q=1; %counter

%convert names / gas selection
PCr = N2.PCr;
k = N2.k;
R = N2.R;
Tt = Tt1;

while (Pt1(q)./Pt2(q))>1.0
    if (Pt1(q)./Pt2(q))>PCr %exceed critical pressure ratio, choked
        M(q) = 1.0;
    else
        M(q) = sqrt((2.0/(k -1.0))*(((Pt2(q)/Pt1(q))^((1.0-k)/k))-1.0));
    end
    
    CdA(q) = CdA_max*min((t(q)/tau_open),1.0); %linear ramp open for valve
    
    dmdt(q) = m1(q)*(CdA(q)/V1)*sqrt(k*R*Tt)*M(q)*((1.0 + M(q)*M(q)*(k -1.0)/2.0)^(-1.0*(k +1.0)/(2.0*(k -1.0))));
    m1(q+1) = m1(q) - dmdt(q)*dt;
    m2(q+1) = m2(q) + dmdt(q)*dt;
    Pt1(q+1) = m1(q+1)*R*Tt/V1;
    Pt2(q+1) = m2(q+1)*R*Tt/V2;
    t(q+1) = t(q) + dt;
    q = q+1;
end

%fill out end of vectors so they can be plotted/manipulated
dmdt(q) = 0.0;
M(q) = 0.0;
CdA(q) = CdA_max*min((t(q)/tau_open),1.0); 

plot(t./U.sec, Pt1./U.psi, t./U.sec, Pt2./U.psi);
grid('on');
xlabel('Time (s)');
ylabel('Pressure (psia)');

