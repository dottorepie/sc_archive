
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=1;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


/////wavetables
Buffer.freeAll
(
~t= Buffer.alloc(s,2048);
)

(
var signal,wt,m=0,amp;

~level=360.collect{m=m+1;amp=m.reciprocal};
~phase=360.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
)
//////////////////arrays
(
~time=1;
(
var  sph1,sph2,m_x=2,m_y=3,m_z=4,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;

~az = (360*~time).collect{

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad,el1.degrad).theta.round(0.000000001);

	};

~el = (360*~time).collect{

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad,el2.degrad).phi.round(0.000000001);

	};

~magx = (360*~time).collect{

	azx=(azx+(1)).wrap(180.neg,180);

	elx=(elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphx=Spherical(rad,azx.degrad,elx.degrad);

	mag_x=(Complex(cos((sphx.theta.round(0.000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.000000001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sphx.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;

//mag_x=(Complex(cos((sphx.theta.round(0.000000001)*m_x).wrap(pi.neg,pi)),cos((sphx.theta.round(0.000000001)*m_x).wrap(pi.neg,pi))).rho*
//Complex(sin((sphx.phi.round(0.000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sphx.phi.round(0.000000001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphx.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2))),cos((sphx.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphx.rho;
	};

~magy = (360*~time).collect{

	azy=(azy+(1)).wrap(180.neg,180);

	ely=(ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphy=Spherical(rad,azy.degrad,ely.degrad);

	mag_y=(Complex(sin((sphy.theta.round(0.000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.000000001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sphy.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

//	mag_y=(Complex(sin((sphy.theta.round(0.000000001)*m_y).wrap(pi.neg,pi)),sin((sphy.theta.round(0.000000001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sphy.phi.round(0.000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sphy.phi.round(0.000000001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sphy.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2))),cos((sphy.phi.round(0.000000001)).wrap((pi/2).neg,(pi/2)))).rho)*sphy.rho;

	};

~magz = (360*~time).collect{

	azz=(azz+(1)).wrap(180.neg,180);

	elz=(elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sphz=Spherical(rad,azz.degrad,elz.degrad);

if(
m_z.even,
mag_z=Complex(cos((sphz.phi.round(0.000000001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sphz.phi.round(0.000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho,
mag_z=Complex(sin((sphz.phi.round(0.000000001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sphz.phi.round(0.000000001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sphz.rho
	);
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
(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[0,0,1],r3=[0,0,1];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
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

)
////////

(
var phase,angle=0,phase1,angle1=90;

~phase1=720.collect{

	phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round(0.000000001)
};
~phase2=720.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.000000001)
};

)
/////////////////synth
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
SynthDef.new(\o1, {
	var az1,el1,az2,el2,pl=0;
    var in1,in2,chainx,chainy,b=0;
	var chainxx,chainyy,phase1,phase2;

	in1 = SoundIn.ar(0,1);
	//in2 = SoundIn.ar(1);

	chainx = FFT(LocalBuf(2048), in1);
	//chainy = FFT(LocalBuf(2048), in2);

   360.do{

		az1=~az.[pl];
		el1=~el.[pl];
		phase1=~phase1.[pl];
	//	phase2=~phase2.[pl];
	//	az2=~az.reverse.[pl];
	//	el2=~el.reverse.[pl];

   chainxx = chainx.pvcollect(2048, {|mag, phase, index| [mag*(Cartesian(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt),~magz.[pl]/(2.sqrt)).rho/(2.sqrt)), exp(Complex(0,1)*(phase+SinOsc.ar(mg,phase1))).theta];},
frombin: b, tobin: b, zeroothers: 1);
 //  chainyy = chainy.pvcollect(2048, {|mag, phase, index| [mag, exp(Complex(0,1)*(phase+SinOsc.ar(mg,phase1))).theta];},
//frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
Osc.ar(~t.bufnum,1/2,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1/2,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90))
);
// Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
// 	Osc.ar(~t.bufnum,1/2,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
// 	Osc.ar(~t.bufnum,1/2,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90))
		//);

		pl=pl+1;
	}
}).add;
);


(
Synth(\o1);
s.record(numChannels:4)
)