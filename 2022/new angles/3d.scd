(
s.options.numWireBufs = 1024;
s.options.numOutputBusChannels=17;
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.options.numInputBusChannels=0;
s.waitForBoot
(
(
SynthDef.new(\id1, { arg dur = 1, interval = 1, presence = 1, delay =1 , n=1, wide=1,xx=1;
var a=10,y=0;
	var aToW = NamedControl.kr(\aToW, 0 ! 28);
	var  x = 0, amp = (0.6/n), fund = (55 )*n;
	var enva, envb, envd1, envd2, envf;
	var under = 1/a, over = 1,attack=0.1;
	var aToWNeg = aToW.neg;
	var tone = 2.pow(interval/12);
	var i = fund * tone, ii = fund *tone;
	var decay = delay*((sqrt(5)+1)/2);
	var s1, s2, s3, s4, trig = Impulse.ar(0);
	var pos = 1/2, an = 0, pang=an.wrap(0,360);

	//envd2 = EnvGen.ar(Env.perc(attack,(decay), amp/tone), doneAction: 2);
	envd2 = EnvGen.ar(Env.sine((decay), amp/tone), doneAction: 2);

	28.do {
		envb = EnvGen.ar(Env.perc(attack,decay, amp/over, [-4, -4]), trig);

		envf = EnvGen.ar(Env(
			aToW.collect { |letter, i|
				Rand(aToWNeg[i], letter)
			},
			Array.fill(aToW.size - 1, { 0.1999.rand2 }),
			[-4]
		), trig);

		s2 = PanAz.ar(5,SinOsc.ar(freq:((ii*over)+envf),phase:pang.degrad,mul: envb),SinOsc.ar(xx),width:1);

		Out.ar(2,s2*envd2);

		x = x+1;
			y=y+a;
		over = (x+1)/1;
		under = 1/(y+a);

			an = an+137.5;
		pang = an.wrap(0, 360);

			    pos = pang.linlin(0, 360, -1,1);

		trig = TDelay.ar(trig, under);
	};
}).add;
);
(
SynthDef.new(\id2, { arg dur = 1, interval = 1, presence = 1, delay =1 , n=1, wide=1,yy=1;
var a=10,y=0;
	var aToW = NamedControl.kr(\aToW, 0 ! 28);
	var  x = 0, amp = (0.6/n), fund = (55 )*n;
	var enva, envb, envd1, envd2, envf;
	var under = 1/a, over = 1,attack=0.1;
	var aToWNeg = aToW.neg;
	var tone = 2.pow(interval/12);
	var i = fund * tone, ii = fund *tone;
	var decay = delay*((sqrt(5)+1)/2);
	var s1, s2, s3, s4, trig = Impulse.ar(0);
	var pos = 1/2, an = 0, pang=an.wrap(0,360);

	//envd2 = EnvGen.ar(Env.perc(attack,(decay), amp/tone), doneAction: 2);
	envd2 = EnvGen.ar(Env.sine((decay), amp/tone), doneAction: 2);

	28.do {
		envb = EnvGen.ar(Env.perc(attack,decay, amp/over, [-4, -4]), trig);

		envf = EnvGen.ar(Env(
			aToW.collect { |letter, i|
				Rand(aToWNeg[i], letter)
			},
			Array.fill(aToW.size - 1, { 0.1999.rand2 }),
			[-4]
		), trig);

		s2 = PanAz.ar(5,SinOsc.ar(freq:((ii*over)+envf),phase:pang.degrad,mul: envb),SinOsc.ar(yy),width:1);
		  	Out.ar(7,s2*envd2);

		x = x+1;
			y=y+a;
		over = (x+1)/1;
		under = 1/(y+a);

			an = an+137.5;
		pang = an.wrap(0, 360);

			    pos = pang.linlin(0, 360, -1,1);

		trig = TDelay.ar(trig, under);
	};
}).add;
);

(
SynthDef.new(\id3, { arg dur = 1, interval = 1, presence = 1, delay =1 , n=1, wide=1,zz=1;
var a=10,y=0;
	var aToW = NamedControl.kr(\aToW, 0 ! 28);
	var  x = 0, amp = (0.6/n), fund = (55 )*n;
	var enva, envb, envd1, envd2, envf;
	var under = 1/a, over = 1,attack=0.1;
	var aToWNeg = aToW.neg;
	var tone = 2.pow(interval/12);
	var i = fund * tone, ii = fund *tone;
	var decay = delay*((sqrt(5)+1)/2);
	var s1, s2, s3, s4, trig = Impulse.ar(0);
	var pos = 1/2, an = 0, pang=an.wrap(0,360);

	//envd2 = EnvGen.ar(Env.perc(attack,(decay), amp/tone), doneAction: 2);
	envd2 = EnvGen.ar(Env.sine((decay), amp/tone), doneAction: 2);

	28.do {
		envb = EnvGen.ar(Env.perc(attack,decay, amp/over, [-4, -4]), trig);

		envf = EnvGen.ar(Env(
			aToW.collect { |letter, i|
				Rand(aToWNeg[i], letter)
			},
			Array.fill(aToW.size - 1, { 0.1999.rand2 }),
			[-4]
		), trig);

		s2 = PanAz.ar(5,SinOsc.ar(freq:((ii*over)+envf),phase:pang.degrad,mul: envb),SinOsc.ar(zz),width:1);
		 	Out.ar(12, s2*envd2);

		x = x+1;
			y=y+a;
		over = (x+1)/1;
		under = 1/(y+a);

			an = an+137.5;
		pang = an.wrap(0, 360);

			    pos = pang.linlin(0, 360, -1,1);

		trig = TDelay.ar(trig, under);
	};
}).add;
)
);

(
~aPattern = Pexprand(1, 10, inf);

Pdef(\1, Pbind(\instrument, \id1,
	\dur, Pexprand(1, 4, inf),
//	\dur, Prand([0.2,0.4], inf),

	\aToW, Ptuple(Array.fill(28, ~aPattern))
	.collect { |array| [array] },
	\xx, Pexprand(0.10, 0.1, inf),
	\interval, Pseq( Array.rand(12,1,12), inf),
	\presence, Pexprand(1, 1.2, inf),
	\delay, Pexprand(2,4,inf);
	//\n, Prand([1,(4/3),(3/2),2],inf),
//\wide,Prand([0.5,0.6,0.7,0.8,0.9,1],inf);
)).play(quant:1);

Pdef(\2, Pbind(\instrument, \id2,
	\dur, Pexprand(1, 4, inf),
//	\dur, Prand([0.2,0.4], inf),

	\aToW, Ptuple(Array.fill(28, ~aPattern))
	.collect { |array| [array] },
	\yy, Pexprand(0.10, 0.1, inf),
	\interval, Pseq( Array.rand(12,1,12), inf),
	\presence, Pexprand(1, 1.2, inf),
	\delay, Pexprand(2,4,inf);
	//\n, Prand([1,(4/3),(3/2),2],inf),
	//\wide,Prand([0.5,0.6,0.7,0.8,0.9,1],inf);

)).play(quant:1);

Pdef(\3, Pbind(\instrument, \id3,
	\dur, Pexprand(1, 4, inf),
//	\dur, Prand([0.2,0.4], inf),

	\aToW, Ptuple(Array.fill(28, ~aPattern))
	.collect { |array| [array] },
	\zz, Pexprand(0.1, 0.1, inf),
	\interval, Pseq( Array.rand(12,1,12), inf),
	\presence, Pexprand(1, 1.2, inf),
	\delay, Pexprand(2,4,inf);
	//\n, Prand([1,(4/3),(3/2),2],inf),
	//\wide,Prand([0.5,0.6,0.7,0.8,0.9,1],inf);

)).play(quant:1);

)
)
(
{Out.ar(0,InFeedback.ar([2,7,12],3))}.play;
{Out.ar(1,InFeedback.ar([2,7,12],3))}.play;
)