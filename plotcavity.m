close all;


%instant plot commands
%if an a is given only the a-th population plot wwill be generated
% s.plotoccupation();
% s.plotEfields;
%box determines which part of rho is ploted box = [x1 y1 x2 y2]
% the box will range from (x1,y1) to (x2,y2). If no box is given the whole matrix is plotted
% s.plotRoh([1 2 3 3]);
% s.plotRoh

% %plots the probability that qbit 1 is in state |1>
% plot(s.time,s.getPpopulated('qbit1',1));


% %plots the polarisation of qbit1
% plot(s.time,s.getPolarisation('qbit1'));

%gets the reducedmatrix for one specified iteration, can be used in a loop
% tmp = s.getReducedMatrix('qbit1',1000);

% %traces out a subsystem for all timesteps. The result is stored in s.reduced_rho_hist
% s.traceOut('cavity');
% plot(s.time,s.getEntanglement);
% figure;
% %plots arbitrary 3d matrix with 
% s.plotmatrix(s.reduced_rho_hist);

% % %plot value of arbitrary operator by calculating trace(rho*op) for each timestep
% % plot(s.time, s.getOpValue(s.H));
% % 
% plot the susceptibility of qbit1. s.f contains the frequency vector
% % % setdf() sets the spacing. Trailing zeros are used for the fft if this is set.
% s.setdf(1e-3);
% % % % 1e-5 is the threhold the external field might take, for which the greensfunction is not 
% % % % set to zero, since otherwise there will be numerical issues. If this parameter is left
% % % % out it will be 1e-5 by default
% h =plot(2*pi*s.f,abs(s.getSusceptibility('qbit1',1e-5)));
% h.LineWidth= 4;
% % hold on;
% % plot(2*pi*s.f,angle(s.getSusceptibility('qbit2',1e-8)));
% % plot(s.f,0.5e4*abs(s.fft(s.Efields{1}.values)));
% % only show part of the axis, in most parts of the frequency spectrum nothing happens
% axis([0.055 0.065 -inf inf]);
% xlabel('Frequency in au','FontSize',18);
% ylabel('abs(Susceptibility)','FontSize',18);
% % title('Susceptibility');
% set(gca,'FontSize',20)


% % gives the blochsphere for a subsystem
% s.blochsphere('qbit1');
%%gives the blochvector of a subystem
% tmp = s.getBlochvector('qbit1')

% % % %plot energies
% plot(s.time/pstoau, s.getEnergy('qbit1'));
% plot(s.time, s.getEnergy('qbit1'));
% h = plot(s.time, s.getPopulation('qbit1',1));
% hold on;
% h2 = plot(s.time, s.getPopulation('qbit2',1));
% h.LineWidth = 4;
% h2.LineWidth = 4;
% figure;
% % % plot(s.time, s.getEnergy('cavity'));
% % % plot(s.time/pstoau, s.getEnergy('qbit2'));
% % % plot(s.time, s.getEnergy('qbit2'));
% % % plot(s.time, s.getEnergy('anotherphoton'));
% % % plot(s.time, s.getOpValue(s.H));
% % %plots first external field
% % % % plot(s.time, s.Efields{1}.values);
% xlabel('Time in ps','FontSize',18);
% ylabel('Population','FontSize',18);
% set(gca,'FontSize',20)
% % % % title('Three System');
% % % % thelegend = legend('qbit1', 'cavity' ,'qbit2','anotherphoton','Total','efield','Location','northeast');
% % % % thelegend = legend('qbit1', 'cavity' ,'qbit2','anotherphoton','Total','Location','northeast');
% thelegend = legend('qbit1','qbit2','Location','northeast');
% % set(thelegend,'FontSize',16);

% figure;
% s.traceOut('cavity')
h =plot(s.time,s.getEntanglement);
% % h =plot(s.time/pstoau,s.g2correlation('measurementPhoton'));
% % hold on;
% % h2 =plot(s.time/pstoau,0.5e13*s.g2numerator('measurementPhoton'));
% xlabel('Time in ps','FontSize',18);
% ylabel('Concurrence in a.u.','FontSize',18);
% set(gca,'FontSize',20)
% h.LineWidth = 4;
% h2.LineWidth = 4;
% legend('correlation','numerator','Location','northeast');

% plot(s.time,s.getPpopulated('cavity',2));
% hold on; 
% plot(s.time,s.getPpopulated('anotherphoton',2));


%rho_hist contains the density matrix for all iterations
%rho_hist(:,:,it) gives the matrix at iteration it

% plot(s.time,s.g2correlation('measurementPhoton'));
% hold on;
% plot(s.time,s.g2numerator('measurementPhoton'));




