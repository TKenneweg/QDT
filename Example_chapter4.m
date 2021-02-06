clear; close all;
s = System; %create a System
s.addEntity(Nlevel(1),'qbit1'); %add the created qbit and call it qbit1
s.addEntity(Qoscillator(3,1),'cavity'); %add a quantum harmonic oscillator with 5 levels and energydiffernce of 1 a.u.
s.addCoupling('qbit1','cavity',0.05); %add a coupling between the first qbit and the cavity
s.addDissipation('qbit1',50); %Set the lifetime of qbit1 to 50 a.u.
s.addDissipation('cavity',50); %Set the lifetime of the cavity to 50 a.u.
s.addExternalField(Gausspulse(0.04,50,30,1),'qbit1'); %set an external electric field that interacts only with qbit1
%done
 
s.setTmax(400); %set the maximum time
s.setTimestep(0.1);
s.simulate; % start the simulation
 
h = plot(s.time,s.getPolarisation('qbit1'));
h.LineWidth =3;
xlabel('Time in a.u.');
ylabel('Polarization Exectation Value in a.u.');
title('Polarization Expectation Value over Time');
legend('Qbit1');

figure;
plot(2*pi*s.f, abs(s.fft(s.getPolarisation('qbit1'))),'o');
axis([0 2 -inf inf]);
xlabel('Angular Frequency in a.u.');
ylabel('Abs of FFT of P(t) in a.u.');
title('Fourier Transform of Polarization');
legend('Qbit1');

figure; 
s.setdf(0.0001);
h =plot(2*pi*s.f, abs(s.fft(s.getPolarisation('qbit1'))),'o');
axis([0 2 -inf inf])
xlabel('Angular Frequency in a.u.');
ylabel('Abs of FFT of P(t) in a.u.');
title('Fourier Transform of Polarization');
legend('Qbit1');