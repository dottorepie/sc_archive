(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)


(
(
SynthDef.new(\ob, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,dist=0.1.az1=0,el1=0;
	var freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,osc1_y,phx,phy,angle1=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

//az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
//el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;
		// phy=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,az,el);

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,az1,el1);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	//	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\oc, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,dist=0.1;
	var freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,osc1_y,phx,phy,angle1=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;
		// phy=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,az,el);

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,az,el);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	//	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\od, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,dist=0.1;
	var freq, env1,m=1,bank, pitch, fund, angle=0,r1,p;
	var osc1_x,osc1_y,phx,phy,angle1=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	bank.do{
az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

    phx=exp(Complex(0,1)*(angle.degrad)).phase;
		// phy=exp(Complex(0,1)*(angle.degrad)).phase;

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phx,2pi)),~b.bufnum,az,el);

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,az,el);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	//	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
)


(
(
var  angle1=0,angle2=0,az,el;


	~az = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	};
~el = 100.collect{
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	};
)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=4;


~phase2 = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n1=Spherical(rad1,angle1,angle2).x;
	n1=(n1*m).round(1/16);

	};

~phase3 = 100.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle4=(angle4+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n2=Spherical(rad2,angle3,angle4).y;
	n2=(n2*m).round(1/16);

	};

~phase4 = 100.collect{
		angle5=(angle5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle6=(angle6+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n3=Spherical(rad3,angle5,angle6).z;
	n3=(n3*m).round(1/16);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=12;


~n2 = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n1=Spherical(rad1,angle1,angle2).x;
	n1=(n1*m).round(1);

	};

~n3 = 100.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle4=(angle4+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n2=Spherical(rad2,angle3,angle4).y;
	n2=(n2*m).round(1);

	};

~n4 = 100.collect{
		angle5=(angle5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle6=(angle6+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n3=Spherical(rad3,angle5,angle6).z;
	n3=(n3*m).round(1);

	};

);
)


Scale.directory

//////////pattern for mobius strib of sequential or parallel play of directions
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
e=Pdef(\22, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n2.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az.reverse,inf),
	\el,Pseq(~el.reverse,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n3.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az.reverse,inf),
	\el,Pseq(~el.reverse,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n4.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az.reverse,inf),
	\el,Pseq(~el.reverse,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
		e.play;
f.play;
g.play;
	(1).wait;
		bb.play;
cc.play;
dd.play;


	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;

////////////////pattern for web of directions
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Ppatlace([Pseq(~phase2.abs,1),Pseq(~phase2.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n2,inf),Pseq(~n2.reverse,inf)],inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Ppatlace([Pseq(~phase3.abs,1),Pseq(~phase3.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n3,inf),Pseq(~n3.reverse,inf)],inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Ppatlace([Pseq(~phase4.abs,1),Pseq(~phase4.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n4,inf),Pseq(~n4.reverse,inf)],inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
b.play;
//s.record(numChannels:4)
//)
//(
c.play;
//s.record(numChannels:4)
//)
//(
d.play;
s.record(numChannels:4)
)

/////////////////////////pattern for x and y osc to behave according to above, either one
(
~phase2=~phase2++~phase2.reverse;
~n2=~n2++~n2.reverse;
~phase3=~phase3++~phase3.reverse;
~n3=~n3++~n3.reverse;
~phase4=~phase4++~phase4.reverse;
~n4=~n4++~n4.reverse;
~az=~az++~az.reverse;
~el=~el++~el.reverse;

~azz=~az.reverse++~az;
~ell=~el.reverse++~el;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),

	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
/////////////////////////////////in one pattern
(
~phase2=~phase2++~phase2.reverse;
~n2=~n2++~n2.reverse;
~phase3=~phase3++~phase3.reverse;
~n3=~n3++~n3.reverse;
~phase4=~phase4++~phase4.reverse;
~n4=~n4++~n4.reverse;



~phase22=~phase2.reverse++~phase2;
~n22=~n2.reverse++~n2;
~phase33=~phase3.reverse++~phase3;
~n33=~n3.reverse++~n3;
~phase44=~phase4.reverse++~phase4;
~n44=~n4++~n4.reverse;

~az=~az++~az.reverse;
~el=~el++~el.reverse;

~azz=~az.reverse++~az;
~ell=~el.reverse++~el;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,

	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az,inf),
	\el,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
e=Pdef(\22, Pbind(\instrument, \ob,

	\dur,Pseq(~phase22.abs,1),
\n1,PdegreeToKey(Pseq(~n22,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\az,Pseq(~azz,inf),
	\el,Pseq(~ell,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase33.abs,1),
\n1,PdegreeToKey(Pseq(~n33,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azz,inf),
	\el,Pseq(~ell,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase44.abs,1),
\n1,PdegreeToKey(Pseq(~n44,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azz,inf),
	\el,Pseq(~ell,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
b.play;
//s.record(numChannels:4)
//)
//(
c.play;
//s.record(numChannels:4)
//)
//(
d.play;
e.play;
//s.record(numChannels:4)
//)
//(
f.play;
//s.record(numChannels:4)
//)
//(
g.play;
s.record(numChannels:4)
)

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
	(1).wait;
		bb.play;
cc.play;
dd.play;


	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;