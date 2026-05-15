(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=2;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*64;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
)

////////////////buffers
Buffer.freeAll
(
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_250102_200153.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_250102_200153.wav",channels:1 );
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_250102_200153.wav",channels:2 );
~c4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_250102_200153.wav",channels:3 );
~c5 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst4/o fractal, rotation through array positions/SC_241210_200412.wav",channels:4 );
~c6 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst4/o fractal, rotation through array positions/SC_241210_200412.wav",channels:5 );
);
)
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav");

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/askhsh3/fft alteration with octave spread.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/askhsh3/fft alteration with octave spread.wav",channels:1 );
/////wavetables
(
~t= Buffer.alloc(s,2048);


{
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
}.value;
)

////speaker setup
(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[45, 45], [135, 45], [135.neg, 45], [45.neg, 45],[45, 45.neg], [135, 45.neg], [135.neg, 45.neg], [45.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
)
/////octahedron
(
	~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

//////////arrays
/////////tetrahedron
(
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);
		~time=32;

//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (720*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (720*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad).wrap(pi.neg,pi),(el2.degrad).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};

~magx = (720*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad).wrap(pi.neg,pi),(el3.degrad).wrap((pi/2).neg,(pi/2)));

			//mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
			2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

~magy = (720*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az3.degrad).wrap(pi.neg,pi),(el4.degrad).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (720*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph5=Spherical(1,((az5.degrad).wrap(pi.neg,pi)).wrap(pi.neg,pi),((el5.degrad).wrap((pi/2).neg,(pi/2))).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

)


(
SynthDef.new(\o_reverb, {
    var in1,in2,in3,in4,in5,in6,chaina,chainb,chainc,chaind,chaine,chainf, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=720,sig,chainaa,chainbb,chaincc,chaindd,chainee,chainff;
	var phase1,phase2,bank1,bank2,frames=1024,sig1,sig2,sig3,sig4,sig5,sig6;

 in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:0);
	 in3 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum), loop: 0, doneAction:0);
	 in4 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum), loop: 0, doneAction:0);
	// in5 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5.bufnum), loop: 0, doneAction:0);
	// in6 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6.bufnum), loop: 0, doneAction:0);
//	in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:2);

	chaina = FFT(LocalBuf(frames), in1);
	chainb = FFT(LocalBuf(frames), in2);
	chainc = FFT(LocalBuf(frames), in3);
	chaind = FFT(LocalBuf(frames), in4);
	//chaine = FFT(LocalBuf(frames), in5);
//	chainf = FFT(LocalBuf(frames), in6);
//	chainy = FFT(LocalBuf(frames), in2);

	//in1 =SoundIn.ar(0);
	// in2 = SoundIn.ar(0);

	//chainx = FFT(LocalBuf(frames), in1);
	//chainy = FFT(LocalBuf(frames), in2);

	bank1=360;

	bank1.do{

		az1=~az.[pl];
		el1=~el.[pl];
	//		az2=~az.reverse.[pl];
	//	el2=~el.reverse.[pl];
amp1=Cartesian(~magx[pl],~magy.[pl],~magz.[pl]);
//amp2=Cartesian(~magx.reverse.[pl],~magy.reverse.[pl],~magz.reverse.[pl]);

	//	phase1=Polar(amp1.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp1.theta.linlin(pi.neg,pi,2pi.neg,2pi));
	//phase2=Polar(amp2.phi.bilin(0,90.degrad.neg,90.degrad,1,0,0),amp2.theta.linlin(pi.neg,pi,2pi.neg,2pi));

phase1=Complex(exp(Complex(0,1)*(az1)).real.round(0.000001),exp(Complex(0,1)*(el1)).imag.round(0.000001)).theta;

chainaa = chaina.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
chainbb = chainb.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
chaincc = chainc.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
chaindd = chaind.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
//chainee = chaine.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
//chainff = chainf.pvcollect(frames, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

/*chainaa = chaina.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainbb = chainb.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chaincc = chainc.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chaindd = chaind.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainee = chaine.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainff = chainf.pvcollect(frames, {|mag, phase, index| [mag*amp1.rho/(2.sqrt), exp(Complex(0,1)*(phase+phase1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);*/


	b=b+1;

		//	Out.ar(0,VBAP.ar(6,IFFT(chainxx),~b.bufnum,
		//Osc.ar(~t,1,phase:az1.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
		//	Osc.ar(~t,1,phase:el1.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

	//	Out.ar(0,VBAP.ar(6,IFFT(chainyy),~b.bufnum,
	//	Osc.ar(~t,1,phase:az2.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
	//		Osc.ar(~t,1,phase:el2.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)));

		sig1=CombC.ar(IFFT(chainaa),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));
		sig2=CombC.ar(IFFT(chainbb),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));
		sig3=CombC.ar(IFFT(chaincc),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));
		sig4=CombC.ar(IFFT(chaindd),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));
		//sig5=CombC.ar(IFFT(chainee),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));
		//sig6=CombC.ar(IFFT(chainff),maxdelaytime:((amp1.rho/(2.sqrt))/10),delaytime:(amp1.rho/(2.sqrt))/10,decaytime:((amp1.rho/(2.sqrt))*10));


				Out.ar(0,LeakDC.ar(sig1));	Out.ar(1,LeakDC.ar(sig2));
		Out.ar(2,LeakDC.ar(sig3));	Out.ar(3,LeakDC.ar(sig4));
		//Out.ar(4,LeakDC.ar(sig5));	Out.ar(5,LeakDC.ar(sig6));

pl=pl+1;

		};
}).add;
)


Synth(\o_reverb);
s.record
s.record(numChannels:6);
s.record(numChannels:4);
