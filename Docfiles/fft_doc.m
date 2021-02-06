%% fft
% performs the fourier transformation of a signal without the lot of the usual hassle that is involved
%% Syntax
% fft(y) 
%% Description
% fft(y) Returns the fourier transformed of the vector _y_. The frist entry of this vector corresponds to the frequency content for $\omega =0$.
% The System class manages a frequency vector that corresponds to the generated data. Using the setdf(df) method 
% the resolution of the fouriertransform can be adjusted. Trailing zeros are automatically attached to _y_ to match this frequency vector. 
%% Example
clear; close all;
s = System;
s.addEntity(Nlevel(1),'qbit');
s.addEntity(Qoscillator(3,1),'cavity');
s.addCoupling('qbit','cavity',0.05);
s.addDissipation('qbit',40);
s.addDissipation('cavity',40);
s.addExternalField(Gausspulse(0.04,50,15,1),'qbit'); 
s.setTimestep(0.1);
s.simulate();

s.setdf(0.0001);
plot(2*pi*s.f,abs(s.fft(s.getPolarisation('qbit')))); % fft is used here
axis([0.8 1.2 -inf inf]);
xlabel('Frequency');
ylabel('abs(fft(Polarisation))');
title('Qbit Coupled to a cavity');
