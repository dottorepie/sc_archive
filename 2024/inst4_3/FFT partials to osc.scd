(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)

////////////////buffers
Buffer.freeAll
(
(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:2 );
~c4 = Buffer.readChannel(s,,channels:3 );
~c5 = Buffer.readChannel(s,,channels:4 );
~c6 = Buffer.readChannel(s,,channels:5 );
);
)
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav");

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/uni/ksyme:cmrc/askhsh3/5_fft alteration,octaves,reverb.wav",channels:0 );

~c1.numFrames/512
/////duration(seconds)=number of frames/samplerate

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst4/o fractal, rotation through array positions/SC_241210_200412.wav",channels:0 );

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav",channels:1 );

	({
		var angle=0;
		~angle=(720*8).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);

s.boot;

// Allocate buffers for magnitude and phase
~magBuffer = Buffer.alloc(s, 1024);  // For magnitude
~phaseBuffer = Buffer.alloc(s, 1024); // For phase

({
		var angle=0;
		~angle=(720).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	)
(exp(Complex(0,1)*~angle.[0]).real)

(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=1,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=2048;
	var samplerate=44100,mags,phases,complex;
	var sig1,sig2,m=0,p=16;
	var amplitude;


    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);

	bank2=512;

   bank2.do{

	//	amplitude=~angle.[b].degrad.linlin(0,2pi,1,2);

		amplitude=exp(Complex(0,1)*~angle.[b]).real.abs;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, index|

		//	mags=K2A.ar(magnitude);
		//phases=K2A.ar(phase);

//
		//	Out.kr(m,magnitude);
		//	Out.kr(p,phase);

		//	 BufWr.kr(magnitude, ~magBuffer.bufnum);  // Write magnitude to buffer
      //  BufWr.kr(phase, ~phaseBuffer.bufnum);  // Write phase to buffer

			[magnitude*amplitude,phase];

		}, frombin: b, tobin: b, zeroothers: 1);

		//complex=exp(Complex(0,1)*phases);

	//	mags = BufRd.kr(1, ~magBuffer.bufnum); // Use MouseX for bin selection
   // phases = BufRd.kr(1, ~phaseBuffer.bufnum);

	//	sig1=Pan2.ar(SinOsc.ar((samplerate/frames)*b,BufRd.kr(1,~phaseBuffer.bufnum),BufRd.kr(1, ~magBuffer.bufnum)*0.001),0);
	//	sig1=Pan2.ar(SinOsc.ar((samplerate/frames)*b,In.kr(p),In.kr(m)*0.1),0);
		//sig1=Pan2.ar(SinOsc.ar((samplerate/frames)*b,phases,mags*0.0001),0);
	//	sig2=Pan2.ar(SinOsc.ar((samplerate/frames)*b,0,mags*0.001),complex.imag);
	b=b+1;
	//	m=m+1;
	//	p=p+1;
		Out.ar(0,Pan2.ar(IFFT(chainxx),0));
		//Out.ar(0,Pan2.ar(IFFT(chainxx),complex.imag));
		//Out.ar(0,sig1*100);
	//	Out.ar(0,sig2);
		//chainxx.clear;
		};
}).add;
)

Synth(\o1);
s.record


(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=1,az1=0,az2=0,el1=0,el2=0,rpr=1;
	var chainxx,chainyy,pl1=0,pl2=0,pl=0,amp1,amp2,phase;
	var angle1=0,angle2=90;
	var phase1,phase2,bank1,bank2,frames=2048;
	var samplerate=44100,mags,phases,complex;
	var sig1,sig2,m=0,p=16;
	var amplitude1,amplitude2;


    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);

	bank2=512;

   bank2.do{

	//	amplitude=~angle.[b].degrad.linlin(0,2pi,1,2);

		amplitude1=exp(Complex(0,1)*~angle.[b]).real.abs;
		amplitude2=exp(Complex(0,1)*~angle.[b]).imag.abs;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, index|

			[magnitude*amplitude1,phase];

		}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainy.pvcollect(frames, {|magnitude, phase, index|

			[magnitude*amplitude2,phase];

		}, frombin: b, tobin: b, zeroothers: 1);


	b=b+1;

		Out.ar(0,IFFT(chainxx));
		Out.ar(1,IFFT(chainyy));

		};
}).add;
)


////////////////////////////individual bins with patttern

(
SynthDef.new(\obin, {

	var b=16;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024*2;
	var samplerate=44100;
	var env,k;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);
	//b=500.rand.postln;

	k=b;
	k.dump;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|

	//	if(bin == k,[magnitude,phase],[magnitude*0,phase*0]);
		[magnitude,phase]

}, frombin: k, tobin: k, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

	//	if(bin == k,[magnitude,phase+90.degrad],[magnitude*0,phase*0]);
		[magnitude,phase]

}, frombin: k, tobin: k, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*8);
		Out.ar(1,IFFT(chainyy)*8);
}).add;
)
Synth(\obin,[\b,16])
/////bin calc
(44100/(1024/4))*10

~time=4
/////////////////bin list
	({
		var n=1.neg;
	~list=(1024).collect{
		n=n+1;
		}
		}.value
	);
//////////////////pattern
(
~aa=Pdef(\1, Pbind(\instrument, \obin,
	\dur,Pseq([4],inf),
	\b,Pxrand(~list,inf)
));
	);

	TempoClock.default.tempo_(1/1);


~aa.play;
s.record(numChannels:4);
\\////////////////////////////////////multiple synths
(~c1.numFrames/512)*i
(
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env,k;

	in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:(~c1.numFrames/512)*i, loop: 0, doneAction:2);


	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);

			b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase+90.degrad]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*1);
		Out.ar(1,IFFT(chainyy)*1);
			chainx.clear;
			chainy.clear;

}).add;
);
}
)


Synth(\obin_++(511.rand))

Synth(\obin_10)

(var b=1.neg; 512.do{ b=511.xrand(b); Synth(\obin_++b)})

512.do{|i| Synth(\obin_++i);}

~dur=((~c1.numFrames/512)/44100)

(~c1.numFrames/512)*8



r=Routine{var b=1.neg; 512.do{ b=511.xrand(b);  Synth(\obin_++b).postln; (~dur).wait;}}
r.play
////////////////////////////////


~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/27 Δεκ, 22.08​.wav",channels:0 );

~dur=((~c1.numFrames/512)/44100)
~duration=(~c1.numFrames/44100)

({
		var n=0;
	~list=(512).collect{
		n=n+~dur;
		}
		}.value
	)

({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)

(
Synth(\bin);
s.record
)

(
SynthDef.new(\bin,{

	 var b=1.neg;
    var in1,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var env,dur;
	var m=1,x=1,n=0;

		in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
		chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);

	k=Pxrand(~k,512).asStream;
	512.do{

m=(x+1)/x;
dur=~list.[n];

x=x+1;
n=n+1;
		//env=EnvGen.ar(Env.new([1,1,0],[dur,0.01],\sine));
		///further modulations for presence of indivual bins can be achieved through further variations of the envelope
		//env=EnvGen.ar(Env.new([0,1,1,0],[dur/1,((~duration-(dur/1))/2),(~duration-((~duration-(dur/1))/2))],\sine));
			env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur/1,0.01,((~duration-(dur/1))/2),0.01,(~duration-((~duration-(dur/1))/2))],\sine));

b=k.next.postln;
			//b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude*env,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*env,phase+90.degrad]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx)*0.5);
		Out.ar(1,IFFT(chainyy)*0.5);

};

}).add;

)
////////////////////////////////////

(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=3;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)

(
Synth(\bin);
s.record(numChannels:3);
)

(
SynthDef.new(\bin,{

	 var b=1.neg;
    var in1,chainx,chainy,chainz;
	var chainxx,chainyy,chainzz;
	var bank,frames=1024;
	var samplerate=44100;
	var env,dur,ph;
	var m=1,x=1,n=0;
	var pos1,pos2,pos3;

		in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
		chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);
	chainz = FFT(LocalBuf(frames), in1);

	k=Pxrand(~k,512).asStream;

	512.do{



		ph=Complex(exp(Complex(0,1)*(~az.[n])).real.round(0.000001),exp(Complex(0,1)*(~el.[n])).imag.round(0.000001)).theta;

m=(x+1)/x;
dur=~list.[n];

		//env=EnvGen.ar(Env.new([1,1,0],[dur,0.01],\sine));
		///further modulations for presence of indivual bins can be achieved through further variations of the envelope
		env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur/1,0.01,((~duration-(dur/1))/2),0.01,(~duration-((~duration-(dur/1))/2))],\sine));
	//	env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur,0.01,dur/3,0.01,dur/3],\sine));

b=k.next.postln;
			//b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude*env*(~magx.[n]/(2.sqrt)),exp(Complex(0,1)*(phase+ph)).theta]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*env*(~magy.[n]/(2.sqrt)),exp(Complex(0,1)*(phase+ph)).theta]

}, frombin: b, tobin: b, zeroothers: 1);

chainzz = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*env*(~magz.[n]/(2.sqrt)),exp(Complex(0,1)*(phase+ph)).theta]

}, frombin: b, tobin: b, zeroothers: 1);

		pos1=Spherical(1,~az.[n],~el.[n]).x.linlin(1.neg,1,2pi.neg,2pi);
		pos2=Spherical(1,~az.[n],~el.[n]).y.linlin(1.neg,1,2pi.neg,2pi);
		pos3=Spherical(1,~az.[n],~el.[n]).z.linlin(1.neg,1,2pi.neg,2pi);

		Out.ar(0,PanAz.ar(3,IFFT(chainxx),pos:SinOsc.ar(1,phase:pos1),level:0.5));
		Out.ar(1,PanAz.ar(3,IFFT(chainyy),pos:SinOsc.ar(1,phase:pos2),level:0.5));
		Out.ar(2,PanAz.ar(3,IFFT(chainzz),pos:SinOsc.ar(1,phase:pos3),level:0.5));

x=x+1;
n=n+1;

};

}).add;

)



Synth(\bin);


(
SynthDef.new(\bin,{

	 var b=0;
    var in1,chainx,chainy,chainz;
	var chainxx,chainyy,chainzz;
	var bank,frames=1024;
	var samplerate=44100;
	var env,dur,ph;
	var m=1,x=1,n=0;
	var sph;
	var o;
	var p1,p2, p3;

		in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
		chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in1);
	chainz = FFT(LocalBuf(frames), in1);


	k=Pxrand(~k,512).asStream;

	512.do{


		o=Cartesian(~magy.[n],~magy.[n],~magy.[n]).rho/(2.sqrt);
		sph=Spherical(o*12,~az.[n],~el.[n]);
		p1=2.pow(sph.x/12);
		p2=2.pow(sph.y/12);
		p3=2.pow(sph.z/12);

//m=(x+1)/x;
//dur=~list.[n];

		//env=EnvGen.ar(Env.new([1,1,0],[dur,0.01],\sine));
		///further modulations for presence of indivual bins can be achieved through further variations of the envelope
	//	env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur/1,0.01,((~duration-(dur/1))/2),0.01,(~duration-((~duration-(dur/1))/2))],\sine));
	//	env=EnvGen.ar(Env.new([0,0,1,1,0,0],[dur,0.01,dur/3,0.01,dur/3],\sine));

b=k.next.postln;
			//b=511.xrand(b).postln;

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude*p1.reciprocal,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*p2.reciprocal,phase]

}, frombin: b, tobin: b, zeroothers: 1);

chainzz = chainx.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude*p3.reciprocal,phase]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(chainxx));
		Out.ar(1,IFFT(chainyy));
		Out.ar(2,IFFT(chainzz));

//x=x+1;
n=n+1;
		//b=b+1;

};

}).add;

)

~dur=((~c1.numFrames/512)/44100)
~duration=(~c1.numFrames/44100)

({
		var n=0;
	~list=(512).collect{
		n=n+~dur;
		}
		}.value
	)

({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)


	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (360*100).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (360*100).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad).wrap(pi.neg,pi),(el2.degrad).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};

~magx = (360*100).collect{
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

~magy = (360*100).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad).wrap(pi.neg,pi),(el4.degrad).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (360*100).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph5=Spherical(1,(az5.degrad).wrap(pi.neg,pi),(el5.degrad).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
)