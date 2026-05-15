
////server setup
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(80/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

/////wavetables
Buffer.freeAll
(
~w= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
)

(
var env,sig,wt,angle=0,level,levels;

~levels=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+((1/3)/1.6180339887499)).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w.loadCollection(wt);
sig.plot;
)

(
var signal,wt,m=1,amp;

~level=360.collect{m=m+1;amp=m.reciprocal};
~phase=360.collect{2pi/2};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
)


////speaker setup
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

/////synths
(
(
SynthDef.new(\ob, {
	var n1=0,cutt=1200,az=0,el=0,mag=1;
	var phase,scale=4,pl=0,osc;
	var freq, env,m=1,bank,pitch,fund=55, angle=0,rad;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=100;
pitch=2.pow(n1/(2*6));
freq=(fund*scale)*pitch;

bank.do{
phase=exp(Complex(0,1)*angle.degrad).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

env=EnvGen.ar(Env([1,2],[360]),doneAction:2,levelScale:pitch.reciprocal);

osc=VBAP.ar(4,
Osc.ar(~w,(freq*m),
mul:SinOsc.ar(~magx.[pl].reciprocal,phase,mul:~magx.[pl],add:1),
phase:SinOsc.ar(~magx.[pl],phase)),
~b.bufnum,
Osc.ar(~t,1/2,phase:~az_x.[pl].linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t,1/2,phase:~el_x.[pl].linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+1;
pl=pl+1;

//wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt))
		Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt,m.reciprocal));
	};
}).add;
);
(
SynthDef.new(\oc, {
	var n1=0,cutt=1200,az=0,el=0,mag=1;
	var phase,scale=4,pl=0,osc;
	var freq, env,m=1,bank,pitch,fund=55, angle=0,rad;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=100;
pitch=2.pow(n1/(2*6));
freq=(fund*scale)*pitch;

bank.do{
phase=exp(Complex(0,1)*angle.degrad).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

env=EnvGen.ar(Env([1,2],[360]),doneAction:2,levelScale:pitch.reciprocal);

osc=VBAP.ar(4,
Osc.ar(~w,(freq*m),
mul:SinOsc.ar(~magy.[pl].reciprocal,phase,mul:~magy.[pl],add:1),
phase:SinOsc.ar(~magy.[pl],phase)),
~b.bufnum,
Osc.ar(~t,1/2,phase:~az_y.[pl].linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t,1/2,phase:~el_y.[pl].linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+1;
pl=pl+1;

//wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt))
		Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt,m.reciprocal));
	};
}).add;
);
(
SynthDef.new(\od, {
	var n1=0,cutt=1200,az=0,el=0,mag=1;
	var phase,scale=4,pl=0,osc;
	var freq, env,m=1,bank,pitch,fund=55, angle=0,rad;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=100;
pitch=2.pow(n1/(2*6));
freq=(fund*scale)*pitch;

bank.do{
phase=exp(Complex(0,1)*angle.degrad).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

env=EnvGen.ar(Env([1,2],[360]),doneAction:2,levelScale:pitch.reciprocal);

osc=VBAP.ar(4,
Osc.ar(~w,(freq*m),
mul:SinOsc.ar(~magz.[pl].reciprocal,phase,mul:~magz.[pl],add:1),
phase:SinOsc.ar(~magz.[pl],phase)),
~b.bufnum,
Osc.ar(~t,1/2,phase:~az_z.[pl].linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t,1/2,phase:~el_z.[pl].linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+1;
pl=pl+1;

//wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt))
		Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt,m.reciprocal));
	};
}).add;
)

)

(Synth(\ob);Synth(\oc);Synth(\od);)
//////////arrays
(
~time=1;
(
var  sph1,sph2,m_x=2,m_y=2,m_z=2,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;

~az = (360*~time).collect{

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad,el1.degrad).theta.round(0.00001);

	};

~el = (360*~time).collect{

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad,el2.degrad).phi.round(0.00001);

	};

~magx = (360*~time).collect{

	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad,elx.degrad);

	mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;

//mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
//Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;

	mag_x=mag_x/(2.sqrt);
	};

~magy = (360*~time).collect{

	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad,ely.degrad);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

mag_y=mag_y/(2.sqrt);
	};

~magz = (360*~time).collect{

	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad,elz.degrad);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z=mag_z/(2.sqrt);
	};

)

////////////////////////az

(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[0,0,1],r3=[0,0,1];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));

~az_x=(360*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta;
};

~az_y=(360*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta;
};

~az_z=(360*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta;
};

)

///////////////////////el
(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r=[0,0,1];
var v1=Quaternion(0,r.[0],r.[1],r.[2]),v2=Quaternion(0,r.[0],r.[1],r.[2]),v3=Quaternion(0,r.[0],r.[1],r.[2]);
var angle=(360-(360/1.6180339887499));

~el_x=(360*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi;
};

~el_y=(360*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi;
};

~el_z=(360*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi;
};

)
/////////////////notes and durs

(
var dur=1,ph1,ph2,ph3,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0,sph1,sph2,sph3,n1,n2,n3,mult=12;
var mag1,mag2,mag3;

~phase2 = (360*~time).collect{
	ph1=~magx.[pl1];
	pl1=pl1+1;
	ph1=(ph1/dur).round(1/32);
	};

~phase3 = (360*~time).collect{
	ph2=~magy.[pl2];
	pl2=pl2+1;
	ph2=(ph2/dur).round(1/32);
	};

~phase4 = (360*~time).collect{
	ph3=~magz.[pl3];
	pl3=pl3+1;
	ph3=(ph3/dur).round((1/32));
	};

~n2 = 100.collect{
	mag1=~magx[pl4];
	sph1=Spherical(mag1,~az_x.[pl4],~el_x.[pl4]).x;
	//sph1=~magx.[pl4];
	pl4=pl4+1;
	n1=(sph1*mult).round(1);
	};

~n3 = 100.collect{
	mag2=~magy[pl5];
	sph2=Spherical(mag2,~az_y.[pl5],~el_y.[pl5]).y;
	//sph2=~magy.[pl5];
	pl5=pl5+1;
	n2=(sph2*mult).round(1);
	};

~n4 = 100.collect{
	mag3=~magz[pl6];
	sph3=Spherical(mag3,~az_z.[pl6],~el_z.[pl6]).z;
	//sph3=~magz.[pl6];
	pl6=pl6+1;
	n3=(sph3*mult).round(1);
	};

)

)
s.record(numChannels:4)