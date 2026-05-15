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
	levels=level.rrand(exp(Complex(0,1)*angle+((1/6)/1.6180339887499)).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~b.loadCollection(wt);
sig.plot;
)

////////arrays
(
(
var phase,angle=0,phase1,angle1=90;

~phase1=720.collect{

	phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round(0.000000001)
};
~phase2=720.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.000000001).neg
};

)

(
var phase1,phase2,angle1=0,angle2=0,m1=2,m2=2;

~posL=720.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.000000001)*m1),sin(phase1.round(0.000000001)*m1)).rho.round(0.000000001)*Complex(cos(phase1.round(0.000000001)*m1),cos(phase1.round(0.000000001)*m1)).rho).round(0.000000001);

};

~posR=720.collect{

	phase2=exp(Complex(0,1)*angle2.degrad).theta;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.000000001)*m2),sin(phase2.round(0.000000001)*m2)).rho.round(0.000000001)*Complex(cos(phase2.round(0.000000001)*m2),cos(phase2.round(0.000000001)*m2)).rho).neg.round(0.000000001);
};

)

(
var phase,angle=0,mag,phase1,angle1=0,mag1,m1=2,m2=2;

~magL = 720.collect{

	phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	//mag=(Complex(cos(phase.round(0.000000001)*3),0).rho*Complex(cos(phase.round(0.000000001)*0),0).rho).round(0.000000001);
	mag=Complex(cos(phase.round(0.000000001)*m1),cos(phase.round(0.000000001)*m1)).rho.round(0.000000001)*Complex(sin(phase.round(0.000000001)*m1),sin(phase.round(0.000000001)*m1)).rho.round(0.000000001);
	};

~magR = 720.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.000000001)*m2),sin(phase1.round(0.000000001)*m2)).rho.round(0.000000001)*Complex(cos(phase1.round(0.000000001)*m2),cos(phase1.round(0.000000001)*m2)).rho.round(0.000000001);
	};
)
)

////////////////////osc

(
{
var signal1,signal2,env1,env2,pl=89,m=1,fund=55;
var pos1,pos2,phase1,phase2,ph1,ph2,mag;
var chainx,chainy;

360.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		phase1=~phase1.[pl];
		phase2=~phase2.[pl];
			mag=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt)).rho/(2.sqrt);

		ph1=SinOsc.ar(mag,phase1);
		ph2=SinOsc.ar(mag,phase2);

		env1=EnvGen.ar(Env([1,1],[240]),doneAction:2,levelScale:m.reciprocal);
		env2=EnvGen.ar(Env([1,1],[240]),doneAction:2,levelScale:m.reciprocal);

		signal1=LPF.ar(Osc.ar(~b.bufnum,fund*m,ph1,m.reciprocal),3000,env1);
		signal2=LPF.ar(Osc.ar(~b.bufnum,fund*m,ph2,m.reciprocal),3000,env2);

	m=m+1;

pl=pl+1;

		Out.ar(0,Pan2.ar(LeakDC.ar(signal1),pos1,mag));
		Out.ar(0,Pan2.ar(LeakDC.ar(signal2),pos2,mag));

}
}.play
)

