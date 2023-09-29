// Daan Dekoning - Jun 6, 2022
// Labo 5 Oefening 2
// 

clf;
clear;

// Genormaliseerde afsnij frequentie 78Hz / 1kHz = 0.078
FC=0.078
M=500
HD=zeros(2:M+1)
for i = 1:M+1
    if ((i-M/2)-1)==0 then
        HD(i)=2*%pi*FC;
    else
        HD(i)=sin(2*%pi*FC*((i-M/2)-1))/((i-M/2)-1);
    end
    HD(i)=HD(i)*(0.42-(0.50*cos(2*%pi*i)/M)+(0.08*cos(4*%pi*i)/M));
end


som=0
for i=1:M+1
    som=som+HD(i)
end
for i=1:M+1
    HD(i)=HD(i)/som
end
for i=1:M+1
    HD(i)=-HD(i)
end

HD(M/2+1)=HD(M/2+1)+1


t=[0:1D-3:7D-1]
sin50hz=sin(2*%pi*50*t);
sin70hz=sin(2*%pi*70*t);
sin130hz=sin(2*%pi*130*t);
signaal=sin50hz+sin70hz+sin130hz;

output=zeros(1:length(t))
for i=M+2:length(t)
    for j=1:M+1
        output(i)=output(i)+signaal(i-j)*HD(j)
    end
end
plot(t,signaal, 'k')
plot(t,output, 'r')


scf(1)
clf


M=500
//Laagdoorlaat
FCL=0.032
LD=zeros(1:M+1)
for i=1:M+1
    if((i-M/2)-1)==0 then
        LD(i)=2*%pi*FCL;
    else
        LD(i)=sin(2*%pi*FCL*((i-M/2)-1))/((i-M/2)-1);
    end
    LD(i)=LD(i)*(0.42-(0.50*cos(2*%pi*i)/M)+(0.08*cos(1*%pi*i)/M));
end




som=0
for i=1:M+1
    som=som+LD(i)
end
for i=1:M+1
    LD(i)=LD(i)/som
end

// Hoogdoorlaat
FCH=0.078
HD=zeros(1:M+1)
for i=1:M+1
    if((i-M/2)-1)==0 then
        HD(i)=2*%pi*FCH;
    else
        HD(i)=sin(2*%pi*FCH*((i-M/2)-1))/((i-M/2)-1);
    end
    HD(i)=HD(i)*(0.42-(0.50*cos(2*%pi*i)/M)+(0.08*cos(4*%pi*i)/M));
end
som=0
for i=1:M+1
    som=som+HD(i)
end
for i=1:M+1
    HD(i)=HD(i)/som
end
for i=1:M+1
    HD(i)=-HD(i)
end
HD(M/2+1)=HD(M/2+1)+1
BD=HD+LD
for i=1:M+1
    BD(i)=-BD(i)
end
BD(M/2+1)=BD(M/2+1)+1




t=[0:1D-3:7D-1]
sin25hz=sin(2*%pi*25*t);
sin50hz=sin(2*%pi*50*t);
sin70hz=sin(2*%pi*70*t);
sin130hz=sin(2*%pi*130*t);
signaal=sin25hz+sin50hz+sin70hz+sin130hz;

output=zeros(1:length(t))
for i=M+2:length(t)
    for j=1:M+1
        output(i)=output(i)+signaal(i-j)*BD(j)
    end
end
plot(t,signaal, 'k')
plot(t,output, 'r')


