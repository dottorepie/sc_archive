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
	levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/10).degrad).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~b.loadCollection(wt);
sig.plot;
)


(
~time=2;
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
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

~posL=1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	phase1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

};

~posR=1440.collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

	phase2=(Complex(exp(Complex(0,1)*(phase2.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase2.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase2.round(0.0001)*m)).real,exp(Complex(0,1)*(phase2.round(0.0001)*m)).real).rho).round(0.0001).neg;
};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR1 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR2 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR3 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=4,pl1=0,pl2=0;

~magL4 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR4 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=5,pl1=0,pl2=0;

~magL5 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR5 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=6,pl1=0,pl2=0;

~magL6 = (360*64).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round((0.0001));

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR6 = (360*64).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001);

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

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

~dur1 = (45*~time).collect{
	ph1=(Complex(~magL1.[pl1],~magR1.[pl1]).rho/(2.sqrt)).round(0.0000000001);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/32);
	t1=ph1*index1;

	};

~dur2 = (45*~time).collect{
	ph2=(Complex(~magL2.[pl2],~magR2.[pl2]).rho/(2.sqrt)).round(0.0000000001);
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/32);
	t2=ph2*index2;
	};

~dur3 = (45*~time).collect{
	ph3=(Complex(~magL3.[pl3],~magR3.[pl3]).rho/(2.sqrt)).round(0.0000000001);
	index3=rythm.wrapAt(pl9);
	pl9=pl9+1;
	pl3=pl3+1;
	ph3=(ph3*dur).round((1/32));
	t3=ph3*index3;
	};

~dur4 = (45*~time).collect{
	ph4=(Complex(~magL4.[pl10],~magR4.[pl10]).rho/(2.sqrt)).round(0.0000000001);
	index4=rythm.wrapAt(pl11);
	pl11=pl11+1;
	pl10=pl10+1;
	ph4=(ph4*dur).round((1/32));
	t4=ph4*index4;
	};
~dur5 = (45*~time).collect{
	ph5=(Complex(~magL5.[pl12],~magR5.[pl12]).rho/(2.sqrt)).round(0.0000000001);
	index5=rythm.wrapAt(pl13);
	pl13=pl13+1;
	pl12=pl12+1;
	ph5=(ph5*dur).round((1/32));
	t5=ph5*index5;
	};

~dur6 = (45*~time).collect{
	ph6=(Complex(~magL6.[pl14],~magR6.[pl14]).rho/(2.sqrt)).round(0.0000000001);
	index6=rythm.wrapAt(pl9);
	pl15=pl15+1;
	pl14=pl14+1;
	ph6=(ph6*dur).round((1/32));
	t6=ph6*index6;
	};

~nx = (45*~time).collect{
	//mag1=Cartesian(~magx1.[pl4],~magy1.[pl4],~magz1.[pl4]).rho/(2.sqrt);
	mag1=1;
		sph1=Complex(mult*~magL.[pl4],mult*~magR.[pl4]).real.round(0.0000000001);
	pl4=pl4+1;
	n1=(sph1).round(1);
	};

~ny = (45*~time).collect{
	//mag2=Cartesian(~magx1.[pl5],~magy1.[pl5],~magz1.[pl5]).rho/(2.sqrt);
	mag2=1;
	sph2=Complex(mult*~magL.[pl5],mult*~magR.[pl5]).imag.round(0.0000000001);
	pl5=pl5+1;
	n2=(sph2).round(1);
	};
}.value;
)


////////////////////osc

(
SynthDef.new(\ostereo,
{
		arg decay=8,nx=1,ny=1,speed=1,octave=4;
var signal1,signal2,env,pl=0,m=2,freq1,freq2,amp1,amp2;
var pos1,pos2,phase1,phase2,ph1,ph2,mag,fundamental=64,freq,pitch1,pitch2;
var chainx,chainy,amp,rq=1,cutt,f,pl1=0,pl2=0,bank1=4,bank2=4;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!

		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);

		freq=fundamental*octave;
		fundamental=fundamental*speed.reciprocal;

bank1.do{
bank2.do{

		pos1=~posL.[pl1]/(2.sqrt);
		pos2=~posR.[pl1]/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
				mag=Complex(~magx.[pl2].[pl1],~magy.[pl2].[pl1]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);


		ph1=exp(Complex(0,1)*(2pi*mag.real).mod(2pi)).theta;
		ph2=exp(Complex(0,1)*(2pi*mag.imag).mod(2pi)).theta;

		amp1=m.reciprocal*octave.reciprocal*speed*pitch1.reciprocal;
		amp2=m.reciprocal*octave.reciprocal*speed*pitch2.reciprocal;
		f=freq*m;

		cutt=freq*m;

env=EnvGen.ar(Env.sine(decay,1),doneAction:2);

				signal1=LPF.ar(Osc.ar(~t.bufnum,f*pitch1,ph1,amp1),cutt*pitch1,env);
					signal2=LPF.ar(Osc.ar(~t.bufnum,f*pitch2,ph2,amp2),cutt*pitch2,env);
	m=m+1;

		wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos1,mag.rho/(2.sqrt)));
		wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos2,mag.rho/(2.sqrt)));
pl1=pl1+1;
			};
					pl2=pl2+1;
		m=m+2;
}
}).add;
)

(
a=Pdef(\1, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur1.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
b=Pdef(\2, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur2.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
			\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
c=Pdef(\3, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur3.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
			\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
d=Pdef(\4, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur4.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
			\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
e=Pdef(\5, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur5.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
f=Pdef(\6, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur6.mirror,1),
\nx,PdegreeToKey(Pseq(~nx.mirror,inf),Scale.phrygian),
	\ny,PdegreeToKey(Pseq(~ny.mirror,inf),Scale.phrygian),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
	);
TempoClock.default.tempo_(3);
/////with tempo 1 and ~time 1 overall duration of a is 2.08 min

	/////////////////////scales
Scale.directory;

(
Tdef.new(\h,{
//loop({
a.play;
//(120).wait;
b.play;
	s.record;
//(120).wait;
c.play;
(120).wait;
d.play;
(120).wait;
e.play;
(120).wait;
f.play;
//	})
})
)


//Tdef(\h).stop;
Tdef(\h).play;
//Tdef(\h).clear;
