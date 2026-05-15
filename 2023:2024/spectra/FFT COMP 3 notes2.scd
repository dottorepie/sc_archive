(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.options.blockSize = 64/4;
s.waitForBoot
)



(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

		osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(0.1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

		osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(0.1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(0.1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(0.1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(0.1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(0.1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(0.1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(0.1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)

(
var  anglex=0,angley=0,x=0,y=0;


	~phasex = 10000.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.theta
	};

~phasey = 10000.collect{
		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
	y=y.imag
	};


)



(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)

