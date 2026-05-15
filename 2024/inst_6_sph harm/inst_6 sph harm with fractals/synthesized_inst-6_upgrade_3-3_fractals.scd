
////server setup
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/180);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

/////wavetables
Buffer.freeAll
(
(
~w= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
);

(
var env,sig,wt,angle=0,level,levels;

~levels=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+(45-(45/1.6180339887499)).degrad).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~w.loadCollection(wt);
sig.plot;
);

(
var signal,wt,m=0,amp;

~level=180.collect{m=m+2;amp=m.reciprocal};
~phase=180.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
)
)

////speaker setup
(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[45, 45], [135, 45], [135.neg, 45], [45.neg, 45],[45, 45.neg], [135, 45.neg], [135.neg, 45.neg], [45.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
)

/////////tetrahedron
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

//////////arrays
~time=1;
///1= about 15:30 min in normal+reverse sequence
///fractal
(
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (180*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);

}

)

(
var c,angle=0,c_real,c_imag,z;



~k = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+45).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~h = (180*~time).collect{
	c=~k.[4].round(0.00001);
	z=z.pow(2)+c;
	z.theta.round(0.000001);

}

)
//////////////////////basis

(
var  sph1,sph2,m_x=3,m_y=1,m_z=3,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (90*~time).collect{
pl1=pl1+1;
		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.00001);

	};

~el = (90*~time).collect{
pl2=pl2+1;
		az2=(az2+(1)).wrap(90.neg,90);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.00001);

	};

~magx = (90*~time).collect{
pl3=pl3+1;
	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad*~h.[pl3],elx.degrad*~j.[pl3]);

	/*mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	mag_x.round(0.00001);*/

	mag_x=(Complex(cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
Complex(cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;

	};

~magy = (90*~time).collect{
pl4=pl4+1;
	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad*~h.[pl4],ely.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;
mag_y.round(0.00001);
//	mag_y=(Complex(sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz = (90*~time).collect{
pl5=pl5+1;
	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad*~h.[pl5],elz.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
	mag_z.round(0.00001);
	};

)

////////////////////////az///randomizer-difuser

(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));
var harm1,harn2,harm3;

~az_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta.round(0.00001);
};

~az_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta.round(0.00001);
};

~az_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta.round(0.00001);
};

)

///////////////////////el
(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));

~el_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi.round(0.00001);
};

~el_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
v2=q2*v2*q2.conjugate;

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi.round(0.00001);
};

~el_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
v3=q3*v3*q3.conjugate;

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi.round(0.00001);
};

)
/////////////////notes and durs

(
var dur=4,ph1,ph2,ph3,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0,sph1,sph2,sph3,n1,n2,n3,mult=8;
var mag1,mag2,mag3,rythm,index1,index2,index3,pl7=0,pl8=0,pl9=0,t1,t2,t3;

////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/2,1,1,1/2];

~phase2 = (90*~time).collect{
	ph1=~magx.[pl1]/(2.sqrt);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/256);
	t1=ph1*index1;

	};

~phase3 = (90*~time).collect{
	ph2=~magy.[pl2]/(2.sqrt);
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/256);
	t2=ph2*index2;
	};

~phase4 = (90*~time).collect{
	ph3=~magz.[pl3]/(2.sqrt);
	index3=rythm.wrapAt(pl9);
	pl9=pl9+1;
	pl3=pl3+1;
	ph3=(ph3*dur).round((1/256));
	t3=ph3*index3;
	};

~n2 = (90*~time).collect{
	mag1=Cartesian(~magx[pl4]/(2.sqrt),~magy[pl4]/(2.sqrt),~magz[pl4]/(2.sqrt)).rho/(2.sqrt);
	sph1=Spherical(mag1*mult,~az.[pl4],~el.[pl4]).x;
	pl4=pl4+1;
	n1=(sph1).round(1);
	};

~n3 = (90*~time).collect{
	mag2=Cartesian(~magx[pl5]/(2.sqrt),~magy[pl5]/(2.sqrt),~magz[pl5]/(2.sqrt)).rho/(2.sqrt);
	sph2=Spherical(mag2*mult,~az.[pl5],~el.[pl5]).y;
	pl5=pl5+1;
	n2=(sph2).round(1);
	};

~n4 = (90*~time).collect{
	mag3=Cartesian(~magx[pl6]/(2.sqrt),~magy[pl6]/(2.sqrt),~magz[pl6]/(2.sqrt)).rho/(2.sqrt);
	sph3=Spherical(mag3*mult,~az.[pl6],~el.[pl6]).z;
	pl6=pl6+1;
	n3=(sph3).round(1);
	};

);

///////////////////////////wt envelope sine levels
(
var ang=0,level,levels,env,pl;
~levels=180.collect{ level=exp(Complex(0,1)*ang).imag; ang=ang+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*ang+((360/16)-((360/16)/1.6180339887499)).degrad).imag);};
//env=Env(~levels,[8/180]);env.plot;
)

////perc
(
var ang=0,level,levels,env,pl;
~levels=90.collect{ level=exp(Complex(0,1)*ang).real; ang=ang+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*ang+((360/16)-((360/16)/1.6180339887499)).degrad).real);};
//env=Env([0]++~levels,[8/180]);env.plot;
)


/////////////////////extra radomizer and reverser

(
~az_x=~az_x.scramble;
~az_y=~az_y.scramble;
~az_z=~az_z.scramble;
~el_x=~el_x.scramble;
~el_y=~el_y.scramble;
~el_z=~el_z.scramble;
)

(
~az_x=~az_x.mirror;
~az_y=~az_y.mirror;
~az_z=~az_z.mirror;
~el_x=~el_x.mirror;
~el_y=~el_y.mirror;
~el_z=~el_z.mirror;
)

(
~az=~az.mirror;
~el=~el.mirror;
~magx=~magx.mirror;
~magy=~magy.mirror;
~magy=~magy.mirror;
)

)

/////synths////for rotation axis a scrambled version of az and el in spherical wuth mag=1 to derive x,y,z for i,j,k, can be used
(
(
SynthDef.new(\ob, {
	arg  n1=1,cutt=440,decay=6,t=2,attack=0.02,az=0,el=0,mag=1,pl=0;
	var phase,octave=2,osc,sphere,mag_o,amp,ton,ph,plf=0;
	var freq,m=1,bank,pitch=1,fund=55, angle=360,rad,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=12;
ton=2.pow(n1/(2*6));
freq=(fund*octave);

bank.do{
		phase=exp(Complex(0,1)*(angle.degrad*Select.kr(plf,~j))).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

		mag_o=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)/(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);

		amp=m.reciprocal*phase.wrap(0,2pi).linlin(0,2pi,0,1)*ton.reciprocal;
		pitch=freq*amp.reciprocal;
		ph=m.reciprocal*phase*ton.reciprocal;

sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az_x),Select.kr(pl,~el_x));
//sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az),Select.kr(pl,~el));

env=EnvGen.ar(Env(~levels*mag_o.round(0.00001),[decay/180]),doneAction:2);

osc=VBAP.ar(4,
LeakDC.ar(Osc.ar(~w.bufnum,pitch,mul:amp,phase:ph)),
~b.bufnum,
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+2;
pl=pl+1;
plf=plf+1;
wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env),cutt))
//Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt));
	};
}).add;
);

(
SynthDef.new(\oc, {
	arg  n1=1,cutt=440,decay=6,t=2,attack=0.02,az=0,el=0,mag=1,pl=0;
	var phase,octave=2,osc,sphere,mag_o,amp,ton,ph,plf=0;
	var freq,m=1,bank,pitch=1,fund=55, angle=360,rad,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=12;
ton=2.pow(n1/(2*6));
freq=(fund*octave);

bank.do{
		phase=exp(Complex(0,1)*(angle.degrad*Select.kr(plf,~j))).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

		mag_o=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)/(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);

		amp=m.reciprocal*phase.wrap(0,2pi).linlin(0,2pi,0,1)*ton.reciprocal;
		pitch=freq*amp.reciprocal;
		ph=m.reciprocal*phase*ton.reciprocal;

sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az_y),Select.kr(pl,~el_y));
//sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az),Select.kr(pl,~el));


env=EnvGen.ar(Env(~levels*mag_o.round(0.00001),[decay/180]),doneAction:2);

osc=VBAP.ar(4,
LeakDC.ar(Osc.ar(~w.bufnum,pitch,mul:amp,phase:ph)),
~b.bufnum,
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+2;
pl=pl+1;
plf=plf+1;
wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env),cutt))
//Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt));
	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1,cutt=440,decay=6,t=2,attack=0.02,az=0,el=0,mag=1,pl=0;
	var phase,octave=2,osc,sphere,mag_o,amp,ton,ph,plf=0;
	var freq,m=1,bank,pitch=1,fund=55, angle=360,rad,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

bank=12;
ton=2.pow(n1/(2*6));
freq=(fund*octave);

bank.do{
		phase=exp(Complex(0,1)*(angle.degrad*Select.kr(plf,~j))).theta;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

		mag_o=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)/(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);

		amp=m.reciprocal*phase.wrap(0,2pi).linlin(0,2pi,0,1)*ton.reciprocal;
		pitch=freq*amp.reciprocal;
		ph=m.reciprocal*phase*ton.reciprocal;

sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az_z),Select.kr(pl,~el_z));
//sphere=Spherical(mag_o.round(0.00001),Select.kr(pl,~az),Select.kr(pl,~el));


env=EnvGen.ar(Env(~levels*mag_o.round(0.00001),[decay/180]),doneAction:2);

osc=VBAP.ar(4,
LeakDC.ar(Osc.ar(~w.bufnum,pitch,mul:amp,phase:ph)),
~b.bufnum,
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);
m=m+2;
pl=pl+1;
plf=plf+1;
wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc)*env),cutt))
//Out.ar(0,LPF.ar(LeakDC.ar((osc)*env*0.1),cutt));
	};
}).add;
)
)

Scale.directory


//////////pattern for mobius strib of sequential or parallel play of directions
(
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\pl,Pseq(Array.series(90*~time,0,1),inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Pseq(Array.series(90*~time,0,1),inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Pseq(Array.series(90*~time,0,1),inf),
	\decay,Pbrown(2,8,1,inf);
));
);

(
e=Pdef(\22, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.reverse,1),
\n1,PdegreeToKey(Pseq(~n2.reverse,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Pseq(Array.series(90*~time,0,1).reverse,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.reverse,1),
\n1,PdegreeToKey(Pseq(~n3.reverse,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Pseq(Array.series(90*~time,0,1).reverse,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.reverse,1),
\n1,PdegreeToKey(Pseq(~n4.reverse,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*6,55,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Pseq(Array.series(90*~time,0,1).reverse,inf),
	\decay,Pbrown(2,8,1,inf);
));
)
)

b.play;
//s.record(numChannels:4,duration:45)
c.play;
//s.record(numChannels:4,duration:45)
d.play;
//s.record(numChannels:4,duration:45)
e.play;
//s.record(numChannels:4,duration:45)
f.play;
s.record(numChannels:4,duration:60)
.

TempoClock.default.tempo_(120/120)

);

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
		e.play;
f.play;
g.play;
	(1).wait;

	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;

////////////////pattern for web of directions////////need correction
(
~phase2=~phase2.mirror;
~n2=~n2.mirror.mirror;
~phase3=~phase3.mirror
~n3=~n3.mirror;
~phase4=~phase4.mirror;
~n4=~n4.mirror;

~phase22=~phase2.reverse.mirror;
~n22=~n2.reverse.mirror;
~phase33=~phase3.reverse.mirror;
~n33=~n3.reverse.mirror;
~phase44=~phase4.reverse.mirror;
~n44=~n4++~n4.reverse.mirror;

~azz=~az.mirror;
~ell=~el.mirror;
~azzz=~az.reverse.mirror;
~azzz=~az.reverse.mirror;

~magxx=~magx.mirror;
~magyy=~magy.mirror;
~magzz=~magz.mirror;
~magxxx=~magx.reverse.mirror;
~magyyy=~magy.reverse.mirror;
~magzzz=~magz.reverse.mirror;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Ppatlace([Pseq(~phase2,1),Pseq(~phase22,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n2,inf),Pseq(~n22,inf)],inf),Scale.phrygian),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Ppatlace([Pseq(~phase3,1),Pseq(~phase33,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n3,inf),Pseq(~n33,inf)],inf),Scale.phrygian),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Ppatlace([Pseq(~phase4,1),Pseq(~phase44,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n4,inf),Pseq(~n44,inf)],inf),Scale.phrygian),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\decay,Pbrown(2,8,1,inf);
));
)


(
b.play;
//s.record(numChannels:4,duration:90)
c.play;
//s.record(numChannels:4,duration:90)
d.play;
//s.record(numChannels:4,duration:90)
e.play;
//s.record(numChannels:4,duration:90)
f.play;
//s.record(numChannels:4,duration:90)
g.play;
s.record(numChannels:4,duration:90)
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

~azz=~az.mirror;
~ell=~el.mirror;

~magxx=~magx.mirror;
~magyy=~magy.mirror;
~magzz=~magz.mirror;

~azzz=~az.reverse.mirror;
~elll=~el.reverse.mirror;

~magxxx=~magx.reverse.mirror;
~magyyy=~magy.reverse.mirror;
~magzzz=~magz.reverse.mirror;


)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,

	\dur,Pseq(~phase4,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
e=Pdef(\22, Pbind(\instrument, \ob,

	\dur,Pseq(~phase22,1),
\n1,PdegreeToKey(Pseq(~n22,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase33,1),
\n1,PdegreeToKey(Pseq(~n33,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase44,1),
\n1,PdegreeToKey(Pseq(~n44,inf),Scale.phrygian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
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