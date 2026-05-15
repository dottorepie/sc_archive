(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=10;
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
	arg  n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

	osc1=BBandPass.ar(InFeedback.ar(4,2),freq1*2*pitch1,MouseY.kr(1,0.00001,1),mul:MouseY.kr(20,5000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(2,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


}).add;);
(SynthDef.new(\of, {
	arg  n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(4,2),freq1*1*pitch1,MouseY.kr(1,0.00001,1),mul:MouseY.kr(20,5000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(2,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));

}).add;);
(SynthDef.new(\og, {
	arg  n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(4,2),freq1*1*pitch1,MouseY.kr(1,0.00001,1),mul:MouseY.kr(20,5000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(2,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


}).add;);

(SynthDef.new(\ok, {
	arg  n1=1,n2=2, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(4,2),freq1*1*pitch1,MouseY.kr(1,0.00001,1),mul:MouseY.kr(20,5000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(2,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


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

~k= Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/free sounds/586990__klankbeeld__dawnchoruscity-517am-210228_2261.wav");
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

(
(SynthDef.new(\ol, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=0.001;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,MouseY.kr(1,0.0001,1),mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.01,500,1)),
			(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\om, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=0.001;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

	bank.do{
env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,MouseY.kr(1,0.0001,1),mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.01,500,1)),
			(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));

m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));
		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\on, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=0.001;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,MouseY.kr(1,0.0001,1),mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.01,500,1)),
			(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));



m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\oo, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=0.001;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,MouseY.kr(1,0.0001,1),mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.01,500,1)),
			(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));



m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));
		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
)


(
l=Pdef(\9, Pbind(\instrument, \ol,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
m=Pdef(\10, Pbind(\instrument, \om,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
n=Pdef(\11, Pbind(\instrument, \on,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
o=Pdef(\12, Pbind(\instrument, \oo,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
)

(
l.play;
m.play;
n.play;
o.play;
)
l.stop;

s.record(numChannels:4)

/////////////////////////

(
(SynthDef.new(\oa, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.00001,1/4,1),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
	(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\ob, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

	bank.do{
env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.00001,1/4,1),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\oc, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.00001,1/4,1),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\od, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
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
	bank=8;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5))*MouseY.kr(0.00001,1/4,1),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
)



(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)
a.stop;

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

(
{Out.ar(4,PlayBuf.ar(2,0,BufRateScale.kr(0),loop:0))}.play;
a.play;
b.play;
c.play;
d.play;
l.play;
m.play;
n.play;
o.play;
e.play;
f.play;
g.play;
k.play;
{Out.ar(0,BPF.ar(InFeedback.ar(2,2),600,1,1))}.play;
{Out.ar(0,BPF.ar(InFeedback.ar(2,2),800,1,3/4))}.play;
{Out.ar(0,BPF.ar(InFeedback.ar(2,2),900,1,2/3))}.play;
{Out.ar(0,BPF.ar(InFeedback.ar(2,2),1200,1,1/2))}.play;

)



~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240228_030737.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_240228_030737.wav",channels:1 );

(
{
    var in1,in2, chainL,chainR, v,b=0,detune1,angle1=0;
    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0);
   250.do{  chainL = FFT(LocalBuf(1024), in1);
		chainR = FFT(LocalBuf(1024), in2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

   chainL = chainL.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

		   chainR = chainR.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		Out.ar(0,PanAz.ar(2,IFFT(chainL),(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1)));
		Out.ar(0,PanAz.ar(2,IFFT(chainR),(detune1.imag.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1)));
	}
}.play
)



(
~e1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/TRACK5.wav",channels:0);
~e2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/TRACK5.wav",channels:1);
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

	~a = Amplitude.ar(sig1, 0.01, 0.25,20).poll;SendReply.ar(Impulse.ar(100), '/a', ~a);
	~b = Amplitude.ar(sig2, 0.01, 0.25,20);SendReply.ar(Impulse.ar(100), '/b', ~b);
	//~c = Amplitude.ar(sig3, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/c', ~c);
	//~d = Amplitude.ar(sig4, 0.01, 0.25);SendReply.ar(Impulse.ar(100), '/d', ~d);

Out.ar(0,sig1*10);
Out.ar(1,sig2*10);
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

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.green);
~v.animate;
~v.drawFunc ={
Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
2000.do{

		x1=x1+(1*(~a*1));
		p1= (x1)/1;
		x2=x2+(1*(~b*1));
		p2= (x2)/1;
		//x3=x3+(1*(~c*0.001));
		//p3= (x3)/1;
		//x4=x4+(1*(~d*0.001));
		//p4= (x4)/1;

		ray=(ray+(360-(360/1.61803398874989484820458683436563811772030917980576)));
		angle=ray.wrap(0,360);
		y=exp(Complex(0,1)*(angle.degrad));
		y1=exp(Complex(0,1)*(angle.degrad+p1));
		y2=exp(Complex(0,1)*(angle.degrad+p2));
		//y3=exp(Complex(0,1)*(angle.degrad+p3));
		//y4=exp(Complex(0,1)*(angle.degrad+p4));

			Pen.width=1;
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


			//Color(red:0.9999.rand,green:0.9999.rand,blue:0.9999.rand).set;
Color.white.set;
Pen.addOval(Rect.new(Polar.new(rad1,(y1.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));

Pen.addOval(Rect.new(Polar.new(rad2,(y1.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));


Pen.addOval(Rect.new(Polar.new(rad3,(y2.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad3).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));

Pen.addOval(Rect.new(Polar.new(rad4,(y2.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad4).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));

	//Pen.addOval(Rect.new(Polar.new(rad3,y.theta).asPoint.x,Polar.new(rad3,y1.theta).asPoint.y,~a*5,~a*5));

		//Pen.addOval(Rect.new(Polar.new(rad4,y.theta).asPoint.x,Polar.new(rad4,y2.theta).asPoint.y,~b*5,~b*5));


Pen.addOval(Rect.new(Polar.new(rad1,(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));

Pen.addOval(Rect.new(Polar.new(rad2,(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~a*100).neg,(~a*100)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a/~a,~a/~a));


Pen.addOval(Rect.new(Polar.new(rad3,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad3).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));

Pen.addOval(Rect.new(Polar.new(rad4,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad4).wrap((~b*100).neg,(~b*100)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b/~b,~b/~b));


//Pen.line(Point.new(Polar.new(rad1,/(y.theta*~a).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad1).wrap((~a*300).neg,(~a*300)),(y1.theta*~a).wrap(pi.neg,pi)).asPoint.y,~a*1,~a*1));
//Pen.line(Point.new(Polar.new(rad1,(y.theta*~b).wrap(pi.neg,pi)).asPoint.x,Polar.new((rad2).wrap((~b*300).neg,(~b*300)),(y2.theta*~b).wrap(pi.neg,pi)).asPoint.y,~b*1,~b*1));
		//Pen.line(Point.new(Polar.new(rad5,y5.theta).asPoint.x,Polar.new(rad6,y6.theta).asPoint.y));
		//Pen.line(Point.new(Polar.new(rad7,y7.theta).asPoint.x,Polar.new(rad8,y8.theta).asPoint.y));

		//Pen.rotate((3/4)*pi);
	//	Pen.rotate((2/3)*pi);
		Pen.rotate((1/2)*pi);
		//Pen.rotate(4);
		Pen.stroke;
		//~v.refresh;




			};

};
{ while { run } {~v.background_(Color.green); ~v.refresh; (1/100).wait } }.fork(AppClock);
)