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
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,az1=0,el1=0,dist=0.1;
	var freq, env1,m=1,bank, pitch, fund, angle=0;
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
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
//angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

~angle=100.collect{angle=(angle+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;};
//~angel1=16.collect{angle1=(angle1+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;}

az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

~azim=16.collect{az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180)};
~elev=16.collect{el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90)};

//az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
//el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

//~azim1=16.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
//~elev1=16.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:EnvGen.ar(Env(~angle,[0.1]))),~b.bufnum,EnvGen.ar(Env(~azim,[1/2])),EnvGen.ar(Env(~elev,[1/2])));

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,EnvGen.ar(Env(~azim1,[1/2])),EnvGen.ar(Env(~elev1,[1/2])));

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	//	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\oc, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,az1=0,el1=0,dist=0.1;
	var freq, env1,m=1,bank, pitch, fund, angle=0;
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
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
//angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

~angle=100.collect{angle=(angle+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;};
//~angel1=16.collect{angle1=(angle1+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;}

az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

~azim=16.collect{az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180)};
~elev=16.collect{el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90)};

//az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
//el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

//~azim1=16.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
//~elev1=16.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:EnvGen.ar(Env(~angle,[0.1]))),~b.bufnum,EnvGen.ar(Env(~azim,[1/2])),EnvGen.ar(Env(~elev,[1/2])));

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,EnvGen.ar(Env(~azim1,[1/2])),EnvGen.ar(Env(~elev1,[1/2])));

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	//	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));

	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\od, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,el=0,az1=0,el1=0,dist=0.1;
	var freq, env1,m=1,bank, pitch, fund, angle=0;
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
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
//angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

~angle=100.collect{angle=(angle+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;};
//~angel1=16.collect{angle1=(angle1+(360-(360/1.6180339887499))).wrap(0.neg,360);phx=exp(Complex(0,1)*(angle.degrad)).phase;}

az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);
el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

~azim=16.collect{az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180)};
~elev=16.collect{el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90)};

//az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
//el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

//~azim1=16.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
//~elev1=16.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};

env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:EnvGen.ar(Env(~angle,[0.1]))),~b.bufnum,EnvGen.ar(Env(~azim,[1/2])),EnvGen.ar(Env(~elev,[1/2])));

//osc1_y=VBAP.ar(4,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,phy,2pi)),~b.bufnum,EnvGen.ar(Env(~azim1,[1/2])),EnvGen.ar(Env(~elev1,[1/2])));

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
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 100.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 100.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

);
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
////////////////////////

(
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=4,pl1=0,pl2=0,pl3=0;


~phase2 = 100.collect{
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n1=Spherical(rad1,~az.[pl1],~el.[pl1]).x;
	pl1=pl1+1;
	n1=(n1).round(1/16);

	};

~phase3 = 100.collect{
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n2=Spherical(rad2,~az.[pl2],~el.[pl2]).y;
	pl2=pl2+1;
	n2=(n2).round(1/16);

	};

~phase4 = 100.collect{
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n3=Spherical(rad3,~az.[pl3],~el.[pl3]).z;
	pl3=pl3+1;
	n3=(n3).round(1/16);

	};

);
(
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=12,pl1=0,pl2=0,pl3=0;


~n2 = 100.collect{
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n1=Spherical(rad1,~az.[pl1],~el.[pl1]).x;
	pl1=pl1+1;
	n1=(n1).round(1);

	};

~n3 = 100.collect{
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n2=Spherical(rad2,~az.[pl2],~el.[pl2]).y;
	pl2=pl2+1;
	n2=(n2).round(1);

	};

~n4 = 100.collect{
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(m.neg,m);
	n3=Spherical(rad3,~az.[pl3],~el.[pl3]).z;
	pl3=pl3+1;
	n3=(n3).round(1);

	};

);

)


Scale.directory

(
~az1=~az.scramble;
~az2=~az.scramble;
~az3=~az.scramble;
~el1=~el.scramble;
~el2=~el.scramble;
~el3=~el.scramble;
)

//////////pattern for mobius strib of sequential or parallel play of directions

(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az1,inf),
	\el,Pseq(~el1,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az2,inf),
	\el,Pseq(~el2,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az3,inf),
	\el,Pseq(~el3,inf),
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
\az,Pseq(~az1.reverse,inf),
	\el,Pseq(~el1.reverse,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n3.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az2.reverse,inf),
	\el,Pseq(~el2.reverse,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n4.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az3.reverse,inf),
	\el,Pseq(~el3.reverse,inf),
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
~phase22=~phase2.reverse.mirror;
~n22=~n2.reverse.mirror;
~phase33=~phase3.reverse.mirror;
~n33=~n3.reverse.mirror;
~phase44=~phase4.reverse.mirror;
~n44=~n4++~n4.reverse.mirror;

~phase2=~phase2.mirror;
~n2=~n2.mirror.mirror;
~phase3=~phase3.mirror
~n3=~n3.mirror;
~phase4=~phase4.mirror;
~n4=~n4.mirror;

~azz1=~az1.mirror;
~azz2=~az2.mirror;
~azz3=~az3.mirror;
~ell1=~el1.mirror;
~ell2=~el2.mirror;
~ell3=~el3.mirror;

~azzz1=~az1.reverse.mirror;
~azzz2=~az2.reverse.mirror;
~azzz3=~az3.reverse.mirror;
~elll1=~el1.reverse.mirror;
~elll2=~el2.reverse.mirror;
~elll3=~el3.reverse.mirror;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Ppatlace([Pseq(~phase2.abs,1),Pseq(~phase22.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n2,inf),Pseq(~n22,inf)],inf),Scale.mixolydian),
	\az,Ppatlace([Pseq(~azz1,inf),Pseq(~azzz1,inf)],inf),
	\el,Ppatlace([Pseq(~ell2,inf),Pseq(~elll2,inf)],inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Ppatlace([Pseq(~phase3.abs,1),Pseq(~phase33.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n3,inf),Pseq(~n33,inf)],inf),Scale.mixolydian),
		\az,Ppatlace([Pseq(~azz2,inf),Pseq(~azzz2,inf)],inf),
	\el,Ppatlace([Pseq(~ell2,inf),Pseq(~elll2,inf)],inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Ppatlace([Pseq(~phase4.abs,1),Pseq(~phase44.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n4,inf),Pseq(~n44,inf)],inf),Scale.mixolydian),
		\az,Ppatlace([Pseq(~azz3,inf),Pseq(~azzz3,inf)],inf),
	\el,Ppatlace([Pseq(~ell3,inf),Pseq(~elll3,inf)],inf),
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
~az1=~az.scramble;
~az11=~az1.scramble;
~az2=~az.scramble;
~az22=~az2.scramble;
~az3=~az.scramble;
~az33=~az3.scramble;
~el1=~el.scramble;
~el11=~el1.scramble;
~el2=~el.scramble;
~el22=~el2.scramble;
~el3=~el.scramble;
~el33=~el3.scramble;
)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az1,inf),
	\el,Pseq(~el1,inf),
		\az1,Pseq(~az11,inf),
	\el1,Pseq(~el11,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~az2,inf),
	\el,Pseq(~el2,inf),
			\az1,Pseq(~az22,inf),
	\el1,Pseq(~el22,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az,Pseq(~az3,inf),
	\el,Pseq(~el3,inf),
			\az1,Pseq(~az33,inf),
	\el1,Pseq(~el33,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
/////////////////////////////////in one pattern
(

~phase22=~phase2.reverse.mirror;
~n22=~n2.reverse.mirror;
~phase33=~phase3.reverse.mirror;
~n33=~n3.reverse.mirror;
~phase44=~phase4.reverse.mirror;
~n44=~n4++~n4.reverse.mirror;

~phase2=~phase2.mirror;
~n2=~n2.mirror.mirror;
~phase3=~phase3.mirror
~n3=~n3.mirror;
~phase4=~phase4.mirror;
~n4=~n4.mirror;

~azz1=~az1.mirror;
~azz2=~az2.mirror;
~azz3=~az3.mirror;
~ell1=~el1.mirror;
~ell2=~el2.mirror;
~ell3=~el3.mirror;

~azzz1=~az1.reverse.mirror;
~azzz2=~az2.reverse.mirror;
~azzz3=~az3.reverse.mirror;
~elll1=~el1.reverse.mirror;
~elll2=~el2.reverse.mirror;
~elll3=~el3.reverse.mirror;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\az,Pseq(~azz1,inf),
	\el,Pseq(~ell1,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azz2,inf),
	\el,Pseq(~ell2,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,

	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azz3,inf),
	\el,Pseq(~ell3,inf),
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
		\az,Pseq(~azzz1,inf),
	\el,Pseq(~elll1,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase33.abs,1),
\n1,PdegreeToKey(Pseq(~n33,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azzz2,inf),
	\el,Pseq(~elll2,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase44.abs,1),
\n1,PdegreeToKey(Pseq(~n44,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az,Pseq(~azzz3,inf),
	\el,Pseq(~elll3,inf),
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