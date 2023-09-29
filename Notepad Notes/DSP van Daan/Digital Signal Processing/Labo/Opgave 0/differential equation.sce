function yprim=f(t,y)
    yprim(1)=y(2);
    yprim(2)=-4*y(1) ;
endfunction
t0=0; tmax=5;
t=t0:0.05:tmax;
y0=3; yprim0=0;
y=ode([y0;yprim0],t0,t,f);
clf; plot(t,y(1,:))
