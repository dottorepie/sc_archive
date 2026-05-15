(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*32;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
(
~b= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
)
(
var env,sig,wt,angle=0,level,levels;

~levels=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/100).degrad).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~b.loadCollection(wt);
sig.plot;
)


(
~time=6;
////////fractal
		{
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
{
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (720*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

}.value;
{
var phase1,phase2,angle1=0,angle2=0,m=3,pl1=0,pl2=0;

~posL=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR1 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR2 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR3 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=4,pl1=0,pl2=0;

~magL4 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR4 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=5,pl1=0,pl2=0;

~magL5 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR5 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=6,pl1=0,pl2=0;

~magL6 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR6 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

(
~magR=~magR.normalize(0,1);
~magL=~magL.normalize(0,1);
~magR1=~magR1.normalize(0,1);
~magL1=~magL1.normalize(0,1);
~magR2=~magR2.normalize(0,1);
~magL2=~magL2.normalize(0,1);
~magR3=~magR3.normalize(0,1);
~magL3=~magL3.normalize(0,1);
~magR4=~magR4.normalize(0,1);
~magL4=~magL4.normalize(0,1);
~magR5=~magR5.normalize(0,1);
~magL5=~magL5.normalize(0,1);
~magR6=~magR6.normalize(0,1);
~magL6=~magL6.normalize(0,1);
);

	(	~magx=[~magR1.round(0.0000000000001),~magR2.round(0.0000000000001),~magR3.round(0.0000000000001),~magR4.round(0.0000000000001),~magR5.round(0.0000000000001),~magR6.round(0.0000000000001)];
	~magy=[~magL1.round(0.0000000000001),~magL2.round(0.0000000000001),~magL3.round(0.0000000000001),~magL4.round(0.0000000000001),~magL5.round(0.0000000000001),~magL6.round(0.0000000000001)];
);

{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=12;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/1,1,1,1/1];

~dur1 = (90*~time).collect{
	ph1=(Complex(~magL.[pl1],~magR.[pl1])).real.round(0.0000000001);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/32);
	t1=ph1*index1;

	};

~dur2 = (90*~time).collect{
	ph2=(Complex(~magL.[pl2],~magR.[pl2])).imag.round(0.0000000001);
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/32);
	t2=ph2*index2;
	};


}.value;
)


////////////////////osc
// (
// (
// SynthDef.new(\ostereo1,
// 	{
// 		arg decay=8,speed=1,pl1=0,angle_r=0,gate=1;
// 		var signal1,signal2,env,m=2,freq1,freq2,amp1,amp2,pl=0,nx,ny,octave=4,phase;
// 		var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=55,freq,pitch1,pitch2,mult=12;
// 		var chainx,chainy,amp,rq=1,cutt,f,pl2=0,bank1=180;
//
// 		var wrappedOut1 = { |busArray, signalArray|
// 			[busArray, signalArray].flop.do { |pair|
// 		Out.ar(pair[0], pair[1])}};
// 		var wrappedOut2 = { |busArray, signalArray|
// 			[busArray, signalArray].flop.do { |pair|
// 		Out.ar(pair[0], pair[1])}};
//
// 		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
// 		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!
//
// 		fundamental=fundamental*speed.reciprocal;
// 		freq=fundamental*octave;
//
// 		bank1.do{
//
// 			pos1=Select.kr(pl1,~posR);
// 			pos2=Select.kr(pl1,~posL);
// 			//phase1=~phase1.[pl];
// 			//phase2=~phase2.[pl];
// 			//mag=Complex(Select.kr(pl1,~magR),Select.kr(pl1,~magL));
// 			mag=Complex(Select.kr(pl1,~magx.[pl2]),Select.kr(pl1,~magy.[pl2]));
//
// 			//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
// 			//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
// 			mag=mag.round(0.0000000001);
//
// 			nx=exp(Complex(0,1)*((angle_r*Complex(mag.real,mag.imag).theta)).wrap(2pi.neg,2pi)).real*mult;
// 			ny=exp(Complex(0,1)*((angle_r*Complex(mag.real,mag.imag).theta)).wrap(2pi.neg,2pi)).imag*mult;
//
// 			pitch1=2.pow(nx/12);
// 			pitch2=2.pow(ny/12);
// 			//pitch1=pitch1.round(1);
// 			//	pitch2=pitch2.round(1);
//
//
// 			ph1=exp(Complex(0,1)*(Complex(mag.real,0).theta)).theta;
// 			ph2=exp(Complex(0,1)*(Complex(0,mag.imag).theta)).theta;
//
// 			amp1=m.reciprocal*octave.reciprocal*speed*pitch1.reciprocal;
// 			amp2=m.reciprocal*octave.reciprocal*speed*pitch2.reciprocal;
// 			f=freq*m;
// 			phase=if(pl2%2==0,0.degrad,90.degrad);
// 			env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate:gate,doneAction:2);
//
// 			signal1=(Osc.ar(~b.bufnum,f*pitch1,phase+ph1,amp1));
// 			//signal2=(Osc.ar(~t.bufnum,f*pitch2,ph2,amp2));
// 			m=m+1;
//
// 			wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos1,env));
// 			//wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos2,env));
//
// 			pl2=pl2+1;
// 			m=m+1;
// 		}
// }).add;
// );
//
// (
// SynthDef.new(\ostereo2,
// 	{
// 		arg decay=8,speed=1,pl1=0,angle_r=0,gate=1;
// 		var signal1,signal2,env,m=2,freq1,freq2,amp1,amp2,pl=0,nx,ny,octave=4;
// 		var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=55,freq,pitch1,pitch2,mult=12;
// 		var chainx,chainy,amp,rq=1,cutt,f,pl2=0,bank1=180,phase;
//
// 		var wrappedOut1 = { |busArray, signalArray|
// 			[busArray, signalArray].flop.do { |pair|
// 		Out.ar(pair[0], pair[1])}};
// 		var wrappedOut2 = { |busArray, signalArray|
// 			[busArray, signalArray].flop.do { |pair|
// 		Out.ar(pair[0], pair[1])}};
//
// 		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
// 		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!
//
// 		fundamental=fundamental*speed.reciprocal;
// 		freq=fundamental*octave;
//
// 		bank1.do{
//
// 			pos1=Select.kr(pl1,~posR);
// 			pos2=Select.kr(pl1,~posL);
// 			//phase1=~phase1.[pl];
// 			//phase2=~phase2.[pl];
// 			mag=Complex(Select.kr(pl1,~magx.[pl2]),Select.kr(pl1,~magy.[pl2]));
// 			//mag=Complex(Select.kr(pl1,~magR),Select.kr(pl1,~magL));
//
// 			//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
// 			//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
// 			mag=mag.round(0.0000000001);
//
// 			nx=exp(Complex(0,1)*((angle_r*Complex(mag.real,mag.imag).theta)).wrap(2pi.neg,2pi)).real*mult;
// 			ny=exp(Complex(0,1)*((angle_r*Complex(mag.real,mag.imag).theta)).wrap(2pi.neg,2pi)).imag*mult;
//
// 			pitch1=2.pow(nx/12);
// 			pitch2=2.pow(ny/12);
// 			//pitch1=pitch1.round(1);
// 			//pitch2=pitch2.round(1);
//
// 			ph1=exp(Complex(0,1)*(Complex(mag.real,0).theta)).theta;
// 			ph2=exp(Complex(0,1)*(Complex(0,mag.imag).theta)).theta;
//
// 			amp1=m.reciprocal*octave.reciprocal*speed*pitch1.reciprocal;
// 			amp2=m.reciprocal*octave.reciprocal*speed*pitch2.reciprocal;
// 			f=freq*m;
// 			phase=if(pl2%2==0,0.degrad,90.degrad);
// 			env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate:gate,doneAction:2);
//
// 			//signal1=(Osc.ar(~t.bufnum,f*pitch1,ph1,amp1));
// 			signal2=(Osc.ar(~b.bufnum,f*pitch2,phase+ph2,amp2));
// 			m=m+1;
//
// 			//wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos1,env));
// 			wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos2,env));
//
// 			pl2=pl2+1;
// 			m=m+1;
// 		}
// }).add;
// )
// )
(
(
SynthDef.new(\ostereo1,
{
		arg decay=8,speed=1,pl1=0,angle_r=0,gate=1;
var signal1,signal2,env,m=2,freq1,freq2,amp1,amp2,pl=1,nx,ny,octave=8,phase;
var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=110,freq,pitch1,pitch2,mult=20;
var chainx,chainy,amp,rq=1,cutt,f,pl2=0,bank1=360;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!

fundamental=fundamental*speed.reciprocal;
		freq=fundamental*octave;

bank1.do{

		pos1=~posR.[pl];
		pos2=~posL.[pl];
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
				//mag=Complex(Select.kr(pl1,~magR),Select.kr(pl1,~magL));
			mag=Complex(~magL.[pl],~magR.[pl]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

				nx=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).real*mult;
				ny=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).imag*mult;

		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);
			//pitch1=pitch1.round(1);
		//	pitch2=pitch2.round(1);


		ph1=exp(Complex(0,1)*(Complex(mag.real.round(0.00001),0).theta)).theta;
		ph2=exp(Complex(0,1)*(Complex(0,mag.imag.round(0.00001)).theta)).theta;

			amp1=octave.reciprocal*speed*pitch1.reciprocal;
		amp2=octave.reciprocal*speed*pitch2.reciprocal;
		f=freq;
phase=if(pl2%2==0,0.degrad,90.degrad);
env=EnvGen.ar(Env.adsr(0.5,0.5,0.5,decay),gate:gate,doneAction:2);

				signal1=SinOsc.ar(f*pitch1,ph1,amp1);
				//signal2=(Osc.ar(~t.bufnum,f*pitch2,ph2,amp2));
	//m=m+1;

		wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos1,env));
		//wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos2,env));

					pl=pl+1;
}
}).add;
);

(
SynthDef.new(\ostereo2,
{
		arg decay=8,speed=1,pl1=0,angle_r=0,gate=1;
var signal1,signal2,env,m=2,freq1,freq2,amp1,amp2,pl=1,nx,ny,octave=8;
var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=110,freq,pitch1,pitch2,mult=20;
var chainx,chainy,amp,rq=1,cutt,f,pl2=0,bank1=360,phase;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!

fundamental=fundamental*speed.reciprocal;
		freq=fundamental*octave;

bank1.do{

		pos1=~posR.[pl];
		pos2=~posL.[pl];
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
				mag=Complex(~magL.[pl],~magR.[pl]);
			//mag=Complex(Select.kr(pl1,~magR),Select.kr(pl1,~magL));

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

				nx=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).real*mult;
				ny=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).imag*mult;

		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);
//pitch1=pitch1.round(1);
			//pitch2=pitch2.round(1);

		ph1=exp(Complex(0,1)*(Complex(mag.real,0).theta)).theta;
		ph2=exp(Complex(0,1)*(Complex(0,mag.imag).theta)).theta;

		amp1=octave.reciprocal*speed*pitch1.reciprocal;
		amp2=octave.reciprocal*speed*pitch2.reciprocal;
		f=freq;
phase=if(pl2%2==0,0.degrad,90.degrad);
env=EnvGen.ar(Env.adsr(0.5,0.5,0.5,decay),gate:gate,doneAction:2);

				//signal1=(Osc.ar(~t.bufnum,f*pitch1,ph1,amp1));
				signal2=SinOsc.ar(f*pitch2,ph2,amp2);
	//m=m+1;

		//wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos1,env));
		wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos2,env));

					pl=pl+1;
}
}).add;
)
)

(
	({
		var n=1.neg;
		~list=(720*~time).collect{
		n=n+1;
		}
		}.value
	);

	({
		var angle=0;
		~angle=(90*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value
	);
);
(
a=Pdef(\1, Pbind(\instrument, \ostereo1,
	\dur,Pseq(~dur1,1),
\angle_r,Pseq(~angle,inf),
	\gate,Pseq([1,0,1,1,0,1,0,1,1,0,1,1,1,0],inf),
	//\pl1,Pseq(~list,inf),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\decay,Pbrown(2,4,1,inf),
	//\speed,Prand([1,3/4,2/3,1/2],inf);
));
b=Pdef(\2, Pbind(\instrument, \ostereo2,
	\dur,Pseq(~dur2,1),
\angle_r,Pseq(~angle,inf),
	\gate,Pseq([1,0,1,1,0,1,0,1,1,0,1,1,1,0],inf),
	//\pl1,Pseq(~list,inf),
	//	\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\decay,Pbrown(2,4,1,inf),
	//\speed,Prand([1,3/4,2/3,1/2],inf);
));

	);
TempoClock.default.tempo_(1/2);
/////with tempo 1 and ~time 1 overall duration of a is 2.08 min

	/////////////////////scales
Scale.directory;

(
Tdef.new(\h,{
//loop({
a.play;
//(120).wait;
b.play;
//(120).wait;
//	})
})
)


//Tdef(\h).stop;
Tdef(\h).play;
//Tdef(\h).clear;
