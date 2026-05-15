(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=12;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.waitForBoot
)
s.options.device_("ASIO : ASIO4ALL v2");
s.reboot
Server.killAll
Buffer.freeAll

////////////////////////////////////////////////

(
(SynthDef.new(\oe, {
	arg pass=1,mul=1,n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [2, 3]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:100);
		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


	osc1=BBandPass.ar(InFeedback.ar(8,2),freq1*pitch1,In.kr(0,1),mul:In.kr(1,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*2/**In.kr(3)*/));


}).add;);
(SynthDef.new(\of, {
	arg pass=1,mul=1, n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [2, 3]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:100);
		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


		osc1=BBandPass.ar(InFeedback.ar(8,2),freq1*pitch1,In.kr(0,1),mul:In.kr(1,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*(3/4)/**In.kr(4)*/));

}).add;);
(SynthDef.new(\og, {
	arg pass=1,mul=1, n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [2, 3]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:100);
		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


		osc1=BBandPass.ar(InFeedback.ar(8,2),freq1*pitch1,In.kr(0,1),mul:In.kr(1,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*(2/3)/**In.kr(5)*/));


}).add;);

(SynthDef.new(\ok, {
	arg pass=1,mul=1, n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [2, 3]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;
//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:100);

		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


		osc1=BBandPass.ar(InFeedback.ar(8,2),freq1*pitch1,In.kr(0,1),mul:In.kr(1,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*2/**In.kr(6)*/));


}).add;);
)



(
e=Pdef(\5, Pbind(\instrument, \oe,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\pass,Pgeom(1,10,inf),
\n1,Prand([
0,5,7,12],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
f=Pdef(\6, Pbind(\instrument, \of,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\pass,Pgeom(1,10,inf),
\n1,Prand([
0,5,7,12],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
g=Pdef(\7, Pbind(\instrument, \og,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\pass,Pgeom(1,10,inf),
\n1,Prand([
0,5,7,12],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
k=Pdef(\8, Pbind(\instrument, \ok,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\pass,Pgeom(1,10,inf),
\n1,Prand([
0,5,7,12],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
)

~k= Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/DSC_0044.wav");
({Out.ar(4,PlayBuf.ar(2,0,BufRateScale.kr(0),loop:inf))}.play)

(
e.play;
f.play;
g.play;
k.play;
)
a.stop;

s.record(numChannels:4)

///////////////////////////////////////////

/////////////////////////

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0;
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=24;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0;
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=24;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0;
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=24;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0;
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=24;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


	osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:LFNoise2.ar(WhiteNoise.ar(2).abs,m.reciprocal).abs*In.kr(2,1),phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,pi.neg,pi),180).degrad), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)




(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		//\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,4,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		//\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		//\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,4,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		//\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,4,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)



s.record(numChannels:4)

///////////


//;//./////

//~z= Buffer.read(s,);

// (
// {Out.ar(0,BPF.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0),600,1,1))}.play;
// {Out.ar(0,BPF.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0),800,1,3/4))}.play;
// {Out.ar(0,BPF.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0),900,1,2/3))}.play;
// {Out.ar(0,BPF.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0),1200,1,1/2))}.play;
// )
MouseY.kr(0.01,100,1)

(
{Out.kr(0,(0.01*SinOsc.ar(0.02,phase:90.neg.degrad,mul:40).dbamp))}.play;
{Out.kr(1,(80*SinOsc.kr(0.02,mul:30,phase:90.degrad).dbamp))}.play;
{Out.kr(2,(0.1*SinOsc.kr(0.02,mul:40,phase:90.degrad).dbamp))}.play;

//{Out.kr(3,LFPulse.kr(0.01,width:100,mul:(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.degrad).dbamp)).abs)}.play;
//{Out.kr(3,LFNoise2.kr(1,(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.neg.degrad).dbamp)).abs)}.play;

//{Out.kr(4,LFPulse.kr(0.01,width:100,mul:(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.degrad).dbamp)).abs)}.play;
//{Out.kr(4,LFNoise2.kr(1,(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.neg.degrad).dbamp)).abs)}.play;


//{Out.kr(5,LFPulse.kr(0.01,width:100,mul:(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.degrad).dbamp)).abs)}.play;
//{Out.kr(5,LFNoise2.kr(1,(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.neg.degrad).dbamp)).abs)}.play;


//{Out.kr(6,LFPulse.kr(0.01,width:100,mul:(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.degrad).dbamp)).abs)}.play;
//{Out.kr(6,LFNoise2.kr(1,(0.1*SinOsc.kr(0.01+MouseY.kr(0.01,100,1),mul:20,phase:90.neg.degrad).dbamp)).abs)}.play;

//{Out.kr(1,(1000*SinOsc.ar(0.02,phase:90.degrad,mul:32).dbamp))}.play;
{Out.ar(8,PanAz.ar(2,PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0)))}.play;
a.play;
b.play;
c.play;
d.play;
//l.play;
//m.play;
//n.play;
//o.play;
e.play;
f.play;
g.play;
k.play;
s.record;
//z.play;
//{Out.ar(0,BPF.ar(InFeedback.ar(2,2),600,1,1)}.play;
//{Out.ar(0,BPF.ar(InFeedback.ar(2,2),800,1,3/4))}.play;
//{Out.ar(0,BPF.ar(InFeedback.ar(2,2),900,1,2/3))}.play;
//{Out.ar(0,BPF.ar(InFeedback.ar(2,2),1200,1,1/2)}.play;
//{Out.ar(0,PanAz.ar(1,InFeedback.ar(2,1),level:1))}.play;
//{Out.ar(1,PanAz.ar(1,InFeedback.ar(3,1),level:1))}.play;
//{Out.ar(0,PanAz.ar(1,InFeedback.ar(4,1),level:(100*SinOsc.kr(MouseY.kr(00.05,0.0.05),mul:32,phase:90.degrad).dbamp)))}.play;
//{Out.ar(1,PanAz.ar(1,InFeedback.ar(5,1),level:100*SinOsc.kr(MouseY.kr(0.0.05,0.0.05),mul:32,phase:90.degrad).dbamp))}.play;0.01
//{Out.ar(0,PanAz.ar(1,InFeedback.ar(6,1),level:1))}.play;
//{Out.ar(1,PanAz.ar(1,InFeedback.ar(7,1),level:1))}.play;
)

////MouseY.kr(1,0.00001,1),mul:MouseY.kr(10,10000,1));

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240304_154429.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240304_154429.wav",channels:1 );

(
{
    var in1,in2, chainL,chainR, v,b=0,detune1,angle1=0;
    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0);
   250.do{  chainL = FFT(LocalBuf(1024), in1);
		chainR = FFT(LocalBuf(1024), in2);

		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));


   chainL = chainL.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

		   chainR = chainR.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		Out.ar(0,PanAz.ar(2,LeakDC.ar(IFFT(chainL)),LFSaw.ar(BufRateScale.kr(~c1),detune1.real)));
		Out.ar(0,PanAz.ar(2,LeakDC.ar(IFFT(chainR)),LFSaw.ar(BufRateScale.kr(~c2),detune1.imag)));
	}
}.play
)



(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240414_142504.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240414_142504.wav",channels:1);
)

(
SynthDef.new(\player,{
	arg tempo;
	var env;
	var sig1, sig2, sig3, sig4;

	//env=EnvGen.ar(Env.new([0,tempo.reciprocal,tempo.reciprocal,0],[1,50,1]), doneAction: 2);

	sig1=PlayBuf.ar(1,~e1.bufnum,BufRateScale.kr(~e1.bufnum),loop:0);
	sig2=PlayBuf.ar(1,~e2.bufnum,BufRateScale.kr(~e2.bufnum),loop:0);
	//sig1=PlayBuf.ar(1,0,BufRateScale.kr(0),startPos:0,loop:inf,rate:1);//*env;
	//sig2=PlayBuf.ar(1,1,BufRateScale.kr(1),startPos:0,loop:inf,rate:1);//*env;
	//sig3=PlayBuf.ar(1,2,BufRateScale.kr(2),startPos:0,loop:inf,rate:1);//*env;
	//sig4=PlayBuf.ar(1,3,BufRateScale.kr(3),startPos:0,loop:inf,rate:1);//*env;

	~a = Amplitude.ar(sig1, 0.01, 0.25,1).poll;SendReply.ar(Impulse.ar(1000), '/a', ~a);
	~b = Amplitude.ar(sig2, 0.01, 0.25,1);SendReply.ar(Impulse.ar(1000), '/b', ~b);
	//~c = Amplitude.ar(sig3, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/c', ~c);
	//~d = Amplitude.ar(sig4, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/d', ~d);

Out.ar(0,sig1);
Out.ar(1,sig2);
//Out.ar(2,sig3);
//Out.ar(3,sig4);
}).add;
);
Synth.new(\player);






(
var y1,y2,y3,y4,y5,y6,y7,y8;
var	p1,p2,p3,p4;
var run = true;
var x1=0,x2=0,x3=0,x4=0;
var ray=0, angle=ray.wrap(0,360);
var rad1=1,rad2=1,rad3=1,rad4=1,rad5=1,rad6=1,rad7=1,rad8=1,rad=1,rad0=1;


OSCdef(\amp1, { |msg|
	~a = msg[3];
	defer { ~v.refresh };
}, '/a', s.addr);

OSCdef(\amp2, { |msg|
	~b = msg[3];
	defer { ~v.refresh };
}, '/b', s.addr);


///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.green;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.white);
~v.animate;
~v.drawFunc ={
Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
2000.do{

			x1=x1+(1);
		//x1=x1+(1*(1));
		p1= (x1)/1;
		x2=x2+(1);
		//x2=x2+(1*(1));
		p2= (x2)/1;
		//x3=x3+(1*(~c*0.001));
		//p3= (x3)/1;
		//x4=x4+(1*(~d*0.001));
		//p4= (x4)/1;

		ray=(ray+(360-(360/1.61803398874989484820458683436563811772030917980576)));
		angle=ray.wrap(0,360);
		y=exp(Complex(0,1)*(angle.degrad));
		y1=exp(Complex(0,1)*((angle.degrad)));
	y2=exp(Complex(0,1)*((angle.degrad)));
		//y3=exp(Complex(0,1)*(angle.degrad+p3));
		//y4=exp(Complex(0,1)*(angle.degrad+p4));


		rad=y.real*300;
		rad0=y.imag*300;
			rad1=y1.real*300;
		    rad2=y1.imag*300;
		    rad3=y2.real*300;
		    rad4=y2.imag*300;
		   // rad5=y3.real*300;
		   // rad6=y3.imag*300;
		   // rad7=y4.real*300;
		   // rad8=y4.imag*300;
Pen.width=1;

			//Color(red:0.9999.rand,green:0.9999.rand,blue:0.9999.rand).set;
//Color(red:1,green:1,blue:1,alpha:1).set;
		Color.black.set;




Pen.addOval(Rect.new(Polar.new(rad1,(y1.real.linlin(1.neg,1,2pi.neg,2pi))*~a).asPoint.x,Polar.new((rad2),(y1.imag.linlin(1.neg,1,2pi.neg,2pi))*~a).asPoint.y,~a/~a,~a/~a));

Pen.addOval(Rect.new(Polar.new(rad3,(y2.real.linlin(1.neg,1,2pi.neg,2pi))*~b).asPoint.x,Polar.new((rad4),(y2.imag.linlin(1.neg,1,2pi.neg,2pi))*~b).asPoint.y,~b/~b,~b/~b));






//Pen.addOval(Rect.new(Polar.new(rad1,(y1.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));

//Pen.addOval(Rect.new(Polar.new(rad2,(y1.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));


//Pen.addOval(Rect.new(Polar.new(rad3,(y2.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad3).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));
//
//Pen.addOval(Rect.new(Polar.new(rad4,(y2.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad4).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));

	//Pen.addOval(Rect.new(Polar.new(rad3,y.theta).asPoint.x,Polar.new(rad3,y1.theta).asPoint.y,~a*5,~a*5));

		//Pen.addOval(Rect.new(Polar.new(rad4,y.theta).asPoint.x,Polar.new(rad4,y2.theta).asPoint.y,~b*5,~b*5));

//Pen.addOval(Rect.new(Polar.new(rad,(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));

//Pen.addOval(Rect.new(Polar.new(rad0,(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));


//Pen.addOval(Rect.new(Polar.new(rad,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad3).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));

//Pen.addOval(Rect.new(Polar.new(rad0,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad4).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));


//Pen.line(Point.new(Polar.new(rad1,/(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*300).neg,(~a*300)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a*1,~a*1));
//Pen.line(Point.new(Polar.new(rad1,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~b*300).neg,(~b*300)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b*1,~b*1));
		//Pen.line(Point.new(Polar.new(rad5,y5.theta).asPoint.x,Polar.new(rad6,y6.theta).asPoint.y));
		//Pen.line(Point.new(Polar.new(rad7,y7.theta).asPoint.x,Polar.new(rad8,y8.theta).asPoint.y));

	//Pen.rotate((3/4)*pi);
		//Pen.rotate((2/3)*pi);
		Pen.rotate(pi);
		//Pen.rotate(4);
		Pen.stroke;
		//~v.refresh;




			};

};
{ while { run } {~v.background_(Color.white); ~v.refresh; (1/60).wait } }.fork(AppClock);
)