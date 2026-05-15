(
s.options.numWireBufs = 1024*2*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024*2 * 64;
s.waitForBoot
)

Buffer.freeAll
/////wavetables
Buffer.freeAll
(
~t= Buffer.alloc(s,2048);
)

(
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);
// .
wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
)

//////////phase shift
~c1 = Buffer.readChannel(s,,channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)


////////////////buffers
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/YouTube_BnlnKt5eRu8.mp3",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/YouTube_BnlnKt5eRu8.mp3",channels:1 );
~c3 = Buffer.readChannel(s,,channels:0 );
~c4 = Buffer.readChannel(s,,channels:1 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
//~c7 = Buffer.readChannel(s,,channels:0 );
//~c8 = Buffer.readChannel(s,,channels:1 );
//~c9 = Buffer.readChannel(s,,channels:0 );
//~c10 = Buffer.readChannel(s,,channels:1 );
//~c11 = Buffer.readChannel(s,,channels:0 );
//~c12 = Buffer.readChannel(s,,channels:1 );
//~c13 = Buffer.readChannel(s,,channels:0 );
//~c14 = Buffer.readChannel(s,,channels:1 );
//~c15 = Buffer.readChannel(s,,channels:0 );
//~c16 = Buffer.readChannel(s,,channels:1 );
)

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
///1= about 15:30 min in normal*reverse sequence
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

~j = (360*~time).collect{
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

~h = (360*~time).collect{
	c=~k.[4].round(0.00001);
	z=z.pow(2)+c;
	z.theta.round(0.000001);

}

)
(
/////////////////sph
(
var  sph1,sph2,m_x=3,m_y=1,m_z=2,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;
var pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (360*~time).collect{
pl1=pl1+1;
		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.00001);

	};

~el = (360*~time).collect{
pl2=pl2+1;
		az2=(az2+(1)).wrap(90.neg,90);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.00001);

	};

~magx = (360*~time).collect{
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

~magy = (360*~time).collect{
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

~magz = (360*~time).collect{
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

////////////////////////az

(
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));
var harm1,harn2,harm3;

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
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
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

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi;
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

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi;
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

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi;
};

)
/////////////////notes and durs

(
var dur=4,ph1,ph2,ph3,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0,sph1,sph2,sph3,n1,n2,n3,mult=10;
var mag1,mag2,mag3,rythm,index1,index2,index3,pl7=0,pl8=0,pl9=0,t1,t2,t3;

rythm=[2,1,1];

~phase2 = (360*~time).collect{
	ph1=~magx.[pl1]/(2.sqrt);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/256);
	t1=ph1+index1;

	};

~phase3 = (360*~time).collect{
	ph2=~magy.[pl2]/(2.sqrt);
	index2=rythm.wrapAt(pl8);
	pl8=pl8+1;
	pl2=pl2+1;
	ph2=(ph2*dur).round(1/256);
	t2=ph2+index2;
	};

~phase4 = (360*~time).collect{
	ph3=~magz.[pl3]/(2.sqrt);
	index3=rythm.wrapAt(pl9);
	pl9=pl9+1;
	pl3=pl3+1;
	ph3=(ph3*dur).round((1/256));
	t3=ph3+index3;
	};

~n2 = (360*~time).collect{
	mag1=Cartesian(~magx[pl4]/(2.sqrt),~magy[pl4]/(2.sqrt),~magz[pl4]/(2.sqrt)).rho/(2.sqrt);
	sph1=Spherical(mag1*mult,~az.[pl4],~el.[pl4]).x;
	pl4=pl4+1;
	n1=(sph1).round(1);
	};

~n3 = (360*~time).collect{
	mag2=Cartesian(~magx[pl5]/(2.sqrt),~magy[pl5]/(2.sqrt),~magz[pl5]/(2.sqrt)).rho/(2.sqrt);
	sph2=Spherical(mag2*mult,~az.[pl5],~el.[pl5]).y;
	pl5=pl5+1;
	n2=(sph2).round(1);
	};

~n4 = (360*~time).collect{
	mag3=Cartesian(~magx[pl6]/(2.sqrt),~magy[pl6]/(2.sqrt),~magz[pl6]/(2.sqrt)).rho/(2.sqrt);
	sph3=Spherical(mag3*mult,~az.[pl6],~el.[pl6]).z;
	pl6=pl6+1;
	n3=(sph3).round(1);
	};

);

(
~az_x=~az_x.scramble;
~az_y=~az_y.scramble;
~az_z=~az_z.scramble;
~el_x=~el_x.scramble;
~el_y=~el_y.scramble;
~el_z=~el_z.scramble;
)

)


(
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0;
	var chainxx,chainyy,pl=0,amp1,amp2,phase,angle=0;
	var angle1=0,angle2=90;
	var phase1,phase2;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024*2), in1);
	chainy = FFT(LocalBuf(1024*2), in2);

   360.do{
		phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
			phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		az1=~az_x.[pl];
		el1=~el_x.[pl];
		az2=~az_x.neg.[pl];
		el2=~el_x.neg.[pl];
		amp1=(Cartesian(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt),~magz.[pl]/(2.sqrt)).rho/(2.sqrt));
		amp2=(Cartesian(~magx.reverse.[pl]/(2.sqrt),~magy.reverse.[pl]/(2.sqrt),~magz.reverse.[pl]/(2.sqrt)).rho/(2.sqrt));

   chainxx = chainx.pvcollect(1024*2, {|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+SinOsc.ar(amp1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024*2, {|mag, phase, index| [mag*amp2, exp(Complex(0,1)*(phase+SinOsc.ar(amp2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,amp1.reciprocal,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp1.reciprocal,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,amp2.reciprocal,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp2.reciprocal,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		pl=pl+1;
	}
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0;
	var chainxx,chainyy,pl=0,amp1,amp2,phase,angle=0;
	var angle1=0,angle2=90;
	var phase1,phase2;

    in1 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024*2), in1);
	chainy = FFT(LocalBuf(1024*2), in2);

   360.do{
		phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
			phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		az1=~az_y.[pl];
		el1=~el_y.[pl];
		az2=~az_y.neg.[pl];
		el2=~el_y.neg.[pl];
		amp1=(Cartesian(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt),~magz.[pl]/(2.sqrt)).rho/(2.sqrt));
		amp2=(Cartesian(~magx.reverse.[pl]/(2.sqrt),~magy.reverse.[pl]/(2.sqrt),~magz.reverse.[pl]/(2.sqrt)).rho/(2.sqrt));

   chainxx = chainx.pvcollect(1024*2, {|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+SinOsc.ar(amp1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024*2, {|mag, phase, index| [mag*amp2, exp(Complex(0,1)*(phase+SinOsc.ar(amp2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,amp1,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp1,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,amp2,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp2,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		pl=pl+1;
	}
}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0;
	var chainxx,chainyy,pl=0,amp1,amp2,phase,angle=0;
	var angle1=0,angle2=90;
	var phase1,phase2;

    in1 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024*2), in1);
	chainy = FFT(LocalBuf(1024*2), in2);

   360.do{
		phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
			phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		az1=~az_z.[pl];
		el1=~el_z.[pl];
		az2=~az_z.neg.[pl];
		el2=~el_z.neg.[pl];
		amp1=(Cartesian(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt),~magz.[pl]/(2.sqrt)).rho/(2.sqrt));
		amp2=(Cartesian(~magx.reverse.[pl]/(2.sqrt),~magy.reverse.[pl]/(2.sqrt),~magz.reverse.[pl]/(2.sqrt)).rho/(2.sqrt));

   chainxx = chainx.pvcollect(1024*2, {|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+SinOsc.ar(amp1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024*2, {|mag, phase, index| [mag*amp2, exp(Complex(0,1)*(phase+SinOsc.ar(amp2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,amp1,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp1,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,amp2,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp2,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		pl=pl+1;
	}
}).add;
);
);

(
Synth(\o1);
s.record(numChannels:4)
Synth(\o2);
s.record(numChannels:4)
Synth(\o3);
)
////exp(Complex(0,1)*(phase+SinOsc.ar(mg,phase1))).theta
//////////////////////////////////////IN

(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0;
	var chainxx,chainyy,pl=0,amp1,amp2,phase,angle=0;
	var angle1=0,angle2=90;
	var phase1,phase2;

	in1 = SoundIn.ar(0);
	 in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(1024*2), in1);
	chainy = FFT(LocalBuf(1024*2), in2);

   360.do{
		phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
			phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		az1=~az_x.[pl];
		el1=~el_x.[pl];
		az2=~az_x.neg.[pl];
		el2=~el_x.neg.[pl];
		amp1=(Cartesian(~magx.[pl]/(2.sqrt),~magy.[pl]/(2.sqrt),~magz.[pl]/(2.sqrt)).rho/(2.sqrt));
		amp2=(Cartesian(~magx.reverse.[pl]/(2.sqrt),~magy.reverse.[pl]/(2.sqrt),~magz.reverse.[pl]/(2.sqrt)).rho/(2.sqrt));

   chainxx = chainx.pvcollect(1024*2, {|mag, phase, index| [mag*amp1, exp(Complex(0,1)*(phase+SinOsc.ar(amp1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024*2, {|mag, phase, index| [mag*amp2, exp(Complex(0,1)*(phase+SinOsc.ar(amp2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,
		Osc.ar(~t,amp1.reciprocal,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp1.reciprocal,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,
		Osc.ar(~t,amp2.reciprocal,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
			Osc.ar(~t,amp2.reciprocal,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		pl=pl+1;
	}
}).add;
)


Synth(\o1);
s.record(numChannels:4)