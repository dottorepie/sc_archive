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




(
SynthDef.new(\ob, {
arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,az=0,az1=0,dist=0.1,az2=0,az3=0,mag1,mag2,mag3;
	var freq, env1,m=1,bank, pitch, fund, angle=0,angle1,angle2,angle3,ang1,ang2,ang3,ang,azz1,azz2,azz3;
	var osc1_x,osc1_y,osc1_z,phx,phy,phz;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
		var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

	angle1=az1.linlin(1.neg,1,360.neg,360);
	angle2=az2.linlin(1.neg,1,360.neg,360);
	angle3=az3.linlin(1.neg,1,360.neg,360);

	bank.do{
angle=(angle+(1-(1/1.6180339887499))).wrap(0,1);

angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);

ang=angle;
ang1=angle1;
ang2=angle2;
ang3=angle3;

~angle1=100.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);phx=exp(Complex(0,1)*(ang.degrad)).phase;};
~angle2=100.collect{ang2=(ang2+(360-(360/1.6180339887499))).wrap(0,360);phy=exp(Complex(0,1)*(ang.degrad)).phase;};
~angle3=100.collect{ang3=(ang3+(360-(360/1.6180339887499))).wrap(0,360);phz=exp(Complex(0,1)*(ang.degrad)).phase;};

~mag=100.collect{ang=(ang+(1-(1/1.6180339887499))).wrap(0,1);};

az1=(az1+(1-(1/1.6180339887499))).wrap(1.neg,1);
az2=(az2+(1-(1/1.6180339887499))).wrap(1.neg,1);
az3=(az3+(1-(1/1.6180339887499))).wrap(1.neg,1);
azz1=az1;
azz2=az2;
azz3=az3;

~azim1=16.collect{azz1=(azz1+(1-(1/1.6180339887499))).wrap(1.neg,1)};
~azim2=16.collect{azz2=(azz2+(1-(1/1.6180339887499))).wrap(1.neg,1)};
~azim3=16.collect{azz3=(azz3+(1-(1/1.6180339887499))).wrap(1.neg,1)};



env1=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:dist);


osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:EnvGen.ar(Env(~mag.scramble,[0.1]),levelScale:m.reciprocal),phase:EnvGen.ar(Env(~angle1,[0.1]))),EnvGen.ar(Env(~azim1,[0.1])));
osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:EnvGen.ar(Env(~mag.scramble,[0.1]),levelScale:m.reciprocal),phase:EnvGen.ar(Env(~angle2,[0.1]))),EnvGen.ar(Env(~azim2,[0.1])));
osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:EnvGen.ar(Env(~mag.scramble,[0.1]),levelScale:m.reciprocal),phase:EnvGen.ar(Env(~angle3,[0.1]))),EnvGen.ar(Env(~azim3,[0.1])));

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env1),cutt));
	wrappedOut2.value(out,LPF.ar(LeakDC.ar((osc1_y)*env1),cutt));
	wrappedOut3.value(out,LPF.ar(LeakDC.ar((osc1_z)*env1),cutt));




	};
}).add;
)



(

(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 1000.collect{

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

~el = 1000.collect{

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
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,v4,r,m=1,sph1,sph2,rot1,rot2;
var az3=0,el3=0,sph3,rot3,q3,i3,j3,k3,x1,y1,z1,x2,y2,z2,x3,y3,z3;
var sph11,sph22,sph33,rot11,rot22,rot33,i11,j11,k11,i22,j22,k22,i33,j33,k33,q11,q22,q33,v22,v33,v44;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0,aza,azb,azc,pl1=0,pl2=0,pl3=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v22=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v33=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v44=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az1 = 1000.collect{

	az1=~az.[pl1];
	el1=~el.[pl1];
	pl1=pl1+1;

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	x1=v2.b.round(0.00001).linlin(1.neg,1,180.neg,180);
	x2=v2.b.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph11=Spherical(1,x1,x2).asCartesian;

	rot11=[sph11.x,sph11.y,sph11.z];

	i11=Quaternion(0, rot11.[0], 0, 0);
	j11=Quaternion(0, 0, rot11.[1], 0);
	k11=Quaternion(0, 0, 0, rot11.[2]);

		q11=(cos(angle.degrad)+(sin(angle.degrad)*(i11+j11+k11)));
	    v22=q11*v22*q11.conjugate;

	aza=v22.b.round(0.00001);


	};

~az2 = 1000.collect{

		az2=~az.[pl2];
	el2=~el.[pl2];
	pl2=pl2+1;

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	y1=v3.c.round(0.00001).linlin(1.neg,1,180.neg,180);
	y2=v3.c.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph22=Spherical(1,y1,y2).asCartesian;

	rot22=[sph22.x,sph22.y,sph22.z];

	i22=Quaternion(0, rot22.[0], 0, 0);
	j22=Quaternion(0, 0, rot22.[1], 0);
	k22=Quaternion(0, 0, 0, rot22.[2]);

		q22=(cos(angle.degrad)+(sin(angle.degrad)*(i22+j22+k22)));
	    v33=q22*v33*q22.conjugate;

	azb=v33.c.round(0.00001);

	};

~az3 = 1000.collect{

		az3=~az.[pl3];
	el3=~el.[pl3];
	pl3=pl3+1;

	sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

		q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
	    v4=q3*v4*q3.conjugate;

	z1=v4.d.round(0.00001).linlin(1.neg,1,180.neg,180);
	z2=v4.d.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph33=Spherical(1,z1,z2).asCartesian;

	rot33=[sph33.x,sph33.y,sph33.z];

	i33=Quaternion(0, rot33.[0], 0, 0);
	j33=Quaternion(0, 0, rot33.[1], 0);
	k33=Quaternion(0, 0, 0, rot33.[2]);

		q33=(cos(angle.degrad)+(sin(angle.degrad)*(i33+j33+k33)));
	    v44=q33*v44*q33.conjugate;

	azc=v44.d.round(0.00001);


	};

);

(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=1;


~phase2 = 1000.collect{
		angle1=(angle1+(1-(1/1.6180339887499))).wrap(0,1);
	n1=angle1;
	n1=(n1*m).round(1/16)
	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=12;


~n2 = 1000.collect{
		angle1=(angle1+(2-(2/1.6180339887499))).wrap(1.neg,1);
	n1=angle1;
	n1=(n1*m).round(1)
	};

);
////////////////////////


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
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
	\az1,Pseq(~az1,inf),
	\az2,Pseq(~az2,inf),
	\az3,Pseq(~az3,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,4,1,inf);
));
)

(
e=Pdef(\22, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n2.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
	\az1,Pseq(~az1,inf),
	\az2,Pseq(~az2,inf),
	\az3,Pseq(~az3,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)



	b.play;
e.play


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
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
b.play;
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
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
	\az,Pseq(~az1,inf),
	\el,Pseq(~el1,inf),
		\az1,Pseq(~az11,inf),
	\el1,Pseq(~el11,inf),
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
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
		\az,Pseq(~azz1,inf),
	\el,Pseq(~ell1,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
e=Pdef(\22, Pbind(\instrument, \ob,

	\dur,Pseq(~phase22.abs,1),
\n1,PdegreeToKey(Pseq(~n22,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,], 1), inf).clump(2).collect([_]),
		\az,Pseq(~azzz1,inf),
	\el,Pseq(~elll1,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
b.play;

s.record(numChannels:4)
)


