
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

s.record(numChannels:1)

/////////////freeze

~c1 = Buffer.readChannel(s,,channels:[0,1] );

(
~fftsize=8192;
~hop=0.25;
~win=0;
~f={Buffer.alloc(s,~c1.duration.calcPVRecSize(~fftsize,~hop))}!2;
)
(
{
	var sig,chain,localbuf;
	sig=PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2);
	localbuf={LocalBuf.new(~fftsize)}!2;
	chain=FFT(localbuf,sig,~hop,~win);
	chain=PV_RecordBuf(chain,~f,run:1,hop:~hop,wintype:~win);
	0;
}.play;
)

(
x={
	var sig,chain,localbuf;
	localbuf={LocalBuf.new(~fftsize)}!2;
		chain=PV_PlayBuf(localbuf,~f,\rate.kr(1),loop:inf);
		sig=IFFT(chain,~win);
	}.play;
)

x.set(\rate,0);
x.set(\rate,1/1);
x.set(\rate,-2/3);
x.release(2);

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

//////////////////////////////arrays
(
~time=1;
///1= about 15:30 min in normal*reverse sequence
(
var  sph1,sph2,m_x=2,m_y=2,m_z=2,az1=0,el1=0,az2=0,el2=0,mag_x,mag_y,mag_z;
var azx=0,elx=0,azy=0,ely=0,azz=0,elz=0,sphx,sphy,sphz,rad=1;

~az = (360*~time).collect{

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad,el1.degrad).theta.round(0.00001);

	};

~el = (360*~time).collect{

		az2=(az2+(1)).wrap(90.neg,90);

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
var r1=[0,0,1],r2=[0,1,0],r3=[1,0,0];
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
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:0 );
~c4 = Buffer.readChannel(s,,channels:1 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
~c7 = Buffer.readChannel(s,,channels:0 );
~c8 = Buffer.readChannel(s,,channels:1 );
~c9 = Buffer.readChannel(s,,channels:0 );
~c10 = Buffer.readChannel(s,,channels:1 );
~c11 = Buffer.readChannel(s,,channels:0 );
~c12 = Buffer.readChannel(s,,channels:1 );
);

(
(
SynthDef.new(\o1, {
	arg n=1,decay=2,buffer1=0,buffer2=0,pl=0;
    var in1,in2, chainx,chainy,b=0,dex=0;
	var chainxx,chainyy,pitch,env1,env2;
	var phase1,phase2,mag_o1,mag_2,pl=0,sphere1,sphere2;
	var angle1=0,angle2=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);


	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   360.do{

phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

mag_o1=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);
mag_o2=Cartesian(Select.kr(pl,~magx.reverse)/(2.sqrt),Select.kr(pl,~magy.reverse)/(2.sqrt),Select.kr(pl,~magz.reverse)/(2.sqrt)).rho/(2.sqrt);

sphere1=Spherical(mag_o,Select.kr(pl,~az_z),Select.kr(pl,~el_z));
sphere2=Spherical(mag_o,Select.kr(pl,~az_z.neg),Select.kr(pl,~el_z.neg));

//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);
		env1=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
		env2=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);


  chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag*mag_o1, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag*mag_o2, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	pl=pl+1;
			wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	}
}).add;
);
(
SynthDef.new(\o2, {
	arg n=1,decay=2,buffer1=0,buffer2=0,pl=0;
    var in1,in2, chainx,chainy,b=0;
	var chainxx,chainyy,pitch,env1,env2;
	var phase1,phase2,mag_o1,mag_2,sphere1,sphere2;
	var angle1=0,angle2=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   360.do{

phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

mag_o1=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);
mag_o2=Cartesian(Select.kr(pl,~magx.reverse)/(2.sqrt),Select.kr(pl,~magy.reverse)/(2.sqrt),Select.kr(pl,~magz.reverse)/(2.sqrt)).rho/(2.sqrt);

sphere1=Spherical(mag_o,Select.kr(pl,~az_z),Select.kr(pl,~el_z));
sphere2=Spherical(mag_o,Select.kr(pl,~az_z.neg),Select.kr(pl,~el_z.neg));

//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);
		env1=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
		env2=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);


   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag*mag_o1, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag*mag_o2, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	pl=pl+1;
			wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	}
}).add;
);
(
SynthDef.new(\o3, {
	arg n=1,decay=2,buffer1=0,buffer2=0,pl=0;
    var in1,in2, chainx,chainy,b=0;
	var chainxx,chainyy,pitch,env1,env2;
	var phase1,phase2,mag_o1,mag_2,sphere1,sphere2;
	var angle1=0,angle2=90;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   360.do{

phase1=exp(Complex(0,1)*angle1.degrad).theta;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

phase2=exp(Complex(0,1)*angle2.degrad).theta;
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

mag_o1=Cartesian(Select.kr(pl,~magx)/(2.sqrt),Select.kr(pl,~magy)(2.sqrt),Select.kr(pl,~magz)/(2.sqrt)).rho/(2.sqrt);
mag_o2=Cartesian(Select.kr(pl,~magx.reverse)/(2.sqrt),Select.kr(pl,~magy.reverse)/(2.sqrt),Select.kr(pl,~magz.reverse)/(2.sqrt)).rho/(2.sqrt);

sphere1=Spherical(mag_o,Select.kr(pl,~az_z),Select.kr(pl,~el_z));
sphere2=Spherical(mag_o,Select.kr(pl,~az_z.neg),Select.kr(pl,~el_z.neg));

//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);
		env1=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o1);
		env2=EnvGen.ar(Env.sine(decay,pitch.reciprocal),doneAction:2,levelScale:mag_o2);


  chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag*mag_o1, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o1.reciprocal,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag*mag_o2, exp(Complex(0,1)*(phase+SinOsc.ar(mag_o2.reciprocal,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);


	b=b+1;
	pl=pl+1;
			wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,Osc.ar(~t.bufnum,sphere.rho,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),Osc.ar(~t.bufnum,sphere.rho,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));
	}
}).add;
);
)



Scale.directory

//////////pattern for mobius strib of sequential or parallel play of directions
(
b=Pdef(\2, Pbind(\instrument, \o1,
	\dur,Pseq(~phase2,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \o2,
	\dur,Pseq(~phase3,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \o3,
	\dur,Pseq(~phase4,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
e=Pdef(\22, Pbind(\instrument, \o1,
	\dur,Pseq(~phase2.reverse,1),
\n1,PdegreeToKey(Pseq(~n2.reverse,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
			\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \o2,
	\dur,Pseq(~phase3.reverse,1),
\n1,PdegreeToKey(Pseq(~n3.reverse,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
			\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \o3,
	\dur,Pseq(~phase4.reverse,1),
\n1,PdegreeToKey(Pseq(~n4.reverse,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\el2,Pseq(~el3,inf),
			\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
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

////////////////pattern for web of directions

(

~phase22=~phase2.reverse.mirror;
~n22=~n2.reverse.mirror;
~phase33=~phase3.reverse.mirror;
~n33=~n3.reverse.mirror;
~phase44=~phase4.reverse.mirror;
~n44=~n4.reverse.mirror;

~phase2=~phase2.mirror;
~n2=~n2.mirror;
~phase3=~phase3.mirror;
~n3=~n3.mirror;
~phase4=~phase4.mirror;
~n4=~n4.mirror;

)

(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Ppatlace([Pseq(~phase2.abs,1),Pseq(~phase22.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n2,inf),Pseq(~n22,inf)],inf),Scale.mixolydian),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Ppatlace([Pseq(~phase3.abs,1),Pseq(~phase33.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n3,inf),Pseq(~n33,inf)],inf),Scale.mixolydian),
\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Ppatlace([Pseq(~phase4.abs,1),Pseq(~phase44.abs,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n4,inf),Pseq(~n44,inf)],inf),Scale.mixolydian),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
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


/////////////////////////////////in one pattern
(

~phase22=~phase2.reverse.mirror;
~n22=~n2.reverse.mirror;
~phase33=~phase3.reverse.mirror;
~n33=~n3.reverse.mirror;
~phase44=~phase4.reverse.mirror;
~n44=~n4.reverse.mirror;

~phase2=~phase2.mirror;
~n2=~n2.mirror;
~phase3=~phase3.mirror;
~n3=~n3.mirror;
~phase4=~phase4.mirror;
~n4=~n4.mirror;

)
(
b=Pdef(\2, Pbind(\instrument, \o1,
	\dur,Pseq(~phase2,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \o2,
	\dur,Pseq(~phase3,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \o3,

	\dur,Pseq(~phase4,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
e=Pdef(\22, Pbind(\instrument, \o1,

	\dur,Pseq(~phase22,1),
\n1,PdegreeToKey(Pseq(~n22,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \o2,
	\dur,Pseq(~phase33,1),
\n1,PdegreeToKey(Pseq(~n33,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\pl,Prand(Array.fill(180,{arg i; i=i+1}),inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \o3,
	\dur,Pseq(~phase44,1),
\n1,PdegreeToKey(Pseq(~n44,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
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
