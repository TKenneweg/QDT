clear; close all;
s = System; %create a System
a = Nlevel([1 1]);
a.setDipole([1 0], 2);
s.addEntity(a,'A'); %add the defined Nlevel object and call ist 'A'
s.addEntity(Nlevel([1 1]),'B'); %Create another equidistant three-level subsystem
s.addCoupling('A',[1 0],'B',[1 0],0.05); %add a coupling between the |0> - |1> transition of A and the |0> - |1> transition of B
s.addExternalField(Gausspulse(0.04,50,30,1),'A'); %set an external electric field that interacts only with A

s.setTmax(200);
s.setTimestep(0.1);
s.simulate;
s.plotoccupation;