(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)
s.options.device_("ASIO : ASIO4ALL v2");
s.reboot
Server.killAll
Buffer.freeAll

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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5)),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
	SinOsc.ar(0.9999.rand));


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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

	bank.do{
env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5)),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		SinOsc.ar(0.9999.rand));


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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5)),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		SinOsc.ar(0.9999.rand));


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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(5)),
		 	phase:(detune1.theta+TExpRand.kr(1,10,Dust.kr(5))).wrap(pi.neg,pi))),
		SinOsc.ar(0.9999.rand));


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

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
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
////////////////////////////

(
(SynthDef.new(\oa, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1,trigger;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	trigger=Dust.kr(1);

	n1=TChoose.kr(trigger,[7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19]);
	bank=32;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trigger,doneAction:0);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(1)),
		 	phase:detune1.theta)),
	SinOsc.ar(0.9999.rand));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LPF.ar(LeakDC.ar(((osc1*env1))*TExpRand.ar(0.01,1,Dust.kr(1))),cutt));
		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\ob, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1,trigger;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	trigger=Dust.kr(1);

	n1=TChoose.kr(trigger,[7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19]);
	bank=32;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

	bank.do{
env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trigger,doneAction:0);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(1)),
		 	phase:detune1.theta)),
		SinOsc.ar(0.9999.rand));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LPF.ar(LeakDC.ar(((osc1*env1))*TExpRand.ar(0.01,1,Dust.kr(1))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\oc, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,m=1,x=0;
	var bank, pitch1,trigger;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	trigger=Dust.kr(1);

	n1=TChoose.kr(trigger,[7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19]);
	bank=32;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trigger,doneAction:0);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(1)),
		 	phase:detune1.theta)),
		SinOsc.ar(0.9999.rand));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LPF.ar(LeakDC.ar(((osc1*env1))*TExpRand.ar(0.01,1,Dust.kr(1))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\od, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1,trigger;
	var freq1, env1,m=1,x=0;
	var bank, pitch1;
	var fund,trig = Impulse.ar(0);
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	trigger=Dust.kr(1);
	n1=TChoose.kr(trigger,[7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19]);
	bank=32;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trigger,doneAction:0);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,FreeVerb.ar(SinOsc.ar((freq1*m)*pitch1,mul:TExpRand.ar(0.01,1,Dust.kr(1)),
		 	phase:detune1.theta)),
		SinOsc.ar(0.9999.rand));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LPF.ar(LeakDC.ar(((osc1*env1))*TExpRand.ar(0.01,1,Dust.kr(1))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
)

(
Synth.new(\oa);
Synth.new(\ob);
Synth.new(\oc);
Synth.new(\od);
)

/////////////////////////////

~e= Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/584948__dibko__birds-and-nature-4-channel-recording.wav");



(SynthDef.new(\oa, {
	arg  n1=1,decay=6,t=2,attack=0.01,angle1;
	var amps,tf,tfBuf=0;
	var detune1, osc1;
	var freq1, env1,pass=1;
	var pitch1, fund, trigger;
	var wrappedOut = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	trigger=Dust.kr(1);

	n1=TChoose.kr(trigger,[7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19]);
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;


//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),trigger,doneAction:0);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),trigger,doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

	osc1=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),loop:inf),freq1*pitch1,Line.kr(1,0.001,10),mul:XLine.kr(1,100,10));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,osc1*env1);

}).add;)

(
Synth.new(\oa);
Synth.new(\ob);
Synth.new(\oc);
Synth.new(\od);
)

////////////////////////////////////////////////


(
(SynthDef.new(\oe, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

	osc1=BBandPass.ar(InFeedback.ar(2,2),freq1*2*pitch1,MouseX.kr(1,0.00001,1),mul:MouseY.kr(10,10000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


}).add;);
(SynthDef.new(\of, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(2,2),freq1*2*pitch1,MouseX.kr(1,0.00001,1),mul:MouseY.kr(10,10000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));

}).add;);
(SynthDef.new(\og, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(2,2),freq1*2*pitch1,MouseX.kr(1,0.00001,1),mul:MouseX.kr(10,10000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


}).add;);

(SynthDef.new(\ok, {
	arg  n1=1,n2=1, cutt=1300,decay=6,t=2,attack=0.01,angle1,pass=1;
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;
//env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		osc1=BBandPass.ar(InFeedback.ar(2,2),freq1*2*pitch1,MouseX.kr(1,0.00001,1),mul:MouseY.kr(10,10000,1));


				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	Out.ar(0,LeakDC.ar(osc1*env1*TExpRand.ar(0.01,1,Dust.kr(5))));


}).add;);
)



(
e=Pdef(\5, Pbind(\instrument, \oe,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
	//\pass,Pgeom(1,10,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
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

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
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

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
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

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

	//\cutt,Pbrown(220*2,220*16,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
)

~k= Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/TRACK1.wav");
({Out.ar(2,PlayBuf.ar(2,0,BufRateScale.kr(0),loop:inf))}.play)

(
e.play;
f.play;
g.play;
k.play;
)
a.stop;

s.record(numChannels:4)

///////////////////////////////////////////
~e= Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_240213_222905.wav");
(
(SynthDef.new(\oa, {
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*6;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,pass,mul:MouseX.kr(0.01,1000,1)),
			SinOsc.ar(0.9999.rand));


m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\ob, {
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*8;

	bank.do{
env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,pass,mul:MouseX.kr(0.01,1000,1)),
			SinOsc.ar(0.9999.rand));

m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));
		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\oc, {
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*9;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);
		detune1=exp(Complex(0,1)*(angle1.degrad));

				//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,pass,mul:MouseX.kr(0.01,1000,1)),
			SinOsc.ar(0.9999.rand));



m=m+1;
	//m.postln;
				angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut.value(out, LPF.ar(LeakDC.ar(((osc1)*env1)*TExpRand.ar(0.01,1,Dust.kr(5))),cutt));

		//trig = TDelay.ar(trig, 0.1);
	};
}).add;);
(SynthDef.new(\od, {
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
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!
	bank=12;
	angle1=45;
	pitch1=2.pow(n1/(2*6));
fund=(((4*t)-1)*((4*t)/2))/2;
	freq1 = fund*12;

	bank.do{

env1=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2);
//env1=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

		//osc1=BBandPass.ar(PlayBuf.ar(2,1,BufRateScale.kr(1),startPos:~e.numFrames.rand,loop:inf),freq1*2*pitch1,pass,mul:MouseX.kr(0.01,1000,1));
		osc1=PanAz.ar(2,BBandPass.ar(WhiteNoise.ar(TExpRand.ar(0.01,1,Dust.kr(5))),freq1*m*pitch1,pass,mul:MouseX.kr(0.01,1000,1)),
			SinOsc.ar(0.9999.rand));



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

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(4,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([

	7,19,22,10,24,14,22,21,7,19,22,10,21,14,17,19

	],inf),

		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
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