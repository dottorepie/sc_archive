(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
~b= Buffer.alloc(s,2048);

(
var env,sig,wt,angle=0,level,levels;

~levels=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+(45-(45/1.6180339887499)).degrad).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~b.loadCollection(wt);
sig.plot;
)

////////fractal
(
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (1440*2).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

)

////////arrays
(
var phase,angle=0,phase1,angle1=90,pl1=0,pl2=0;

~phase1=1440.collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round(0.0001)
};
~phase2=1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001)
};

)

(
var phase1,phase2,angle1=0,angle2=0,m1=5,m2=5,pl1=0,pl2=0;

~posL=1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m1),sin(phase1.round(0.0001)*m1)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m1),cos(phase1.round(0.0001)*m1)).rho).round(0.0001);

};

~posR=1440.collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m2),sin(phase2.round(0.0001)*m2)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m2),cos(phase2.round(0.0001)*m2)).rho).round(0.0001).neg;
};

)

(
var phase,angle=0,mag,phase1,angle1=0,mag1,m1=5,m2=5,pl1=0,pl2=0;

~magL = 1440.collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m1),cos(phase.round(0.0001)*m1)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m1),cos(phase.round(0.0001)*m1)).rho.round(0.0001);
	};

~magR = 1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m2),sin(phase1.round(0.0001)*m2)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m2),cos(phase1.round(0.0001)*m2)).rho.round(0.0001);
	};
)


////////////////////osc

(
{
var signal1,signal2,env1,env2,pl=89,m=1,fund=110;
var pos1,pos2,phase1,phase2,ph1,ph2,mag;
var chainx,chainy;

360.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		phase1=~phase1.[pl];
		phase2=~phase2.[pl];
			mag=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt)).rho/(2.sqrt);

		ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		ph2=SinOsc.ar(mag.reciprocal,phase2,mag);

env1=EnvGen.ar(Env.sine(45,0.1),doneAction:2);
env2=EnvGen.ar(Env.sine(45,0.1),doneAction:2);

		signal1=LPF.ar(Osc.ar(~b.bufnum,fund*m,ph1,m.reciprocal),fund*16,env1);
		signal2=LPF.ar(Osc.ar(~b.bufnum,fund*m,ph2,m.reciprocal),fund*16,env2);

	m=m+1;

pl=pl+1;

		Out.ar(0,Pan2.ar(LeakDC.ar(signal1),pos1,mag));
		Out.ar(0,Pan2.ar(LeakDC.ar(signal2),pos2,mag));

}
}.play;
//s.record
)

