(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=10;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*4*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
s.meter;
	s.freqscope;
	s.scope;
~t= Buffer.alloc(s,2048);
//~controlBus_mx = Bus.control(s, 1);
//~controlBus_my = Bus.control(s, 1);

////////////////////////////////////speaker setup///other
/*(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],[0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
	// )*/
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


// 16
	// ~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],
	// 	[0, 0], [45, 0], [90, 0], [135, 0],[180.neg,0], [135.neg, 0], [90.neg, 0],[45.neg, 0],
	// [0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
	// //0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
	// ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
//)

///////////////////////////////////////////////////////arrays
///////l-system
	(
{
var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//These are the production rules of the L-system
var word = "A";
var string_temp = "";
var iter = 18;

//These are diction for the mapping of the alphabet to "artistic" parameters: degrees in a scale, beat occurrence, etc.

var dictnotes = IdentityDictionary[\A -> 0, \B -> 1];
 ~r=[];

//This iteration generates the system recursively

iter.do({

word.asArray.do({|i|
    string_temp = string_temp ++ dict[i.asSymbol];
});

word = string_temp;
	string_temp = "";
});

word.postln;

//Here we map the final system to the parameters as above

word.do({|i| ~r = ~r ++ dictnotes[i.asSymbol];});

~r.postln;
}.value
);


//////////////////////////////////////////////////basis

	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];~dur=[];

		360.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

					sphx=Spherical(1,(azx.degrad),(elx.degrad)).x.round(0.000000001).abs;

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=Spherical(1,(azy.degrad),(ely.degrad)).y.round(0.000000001).abs;

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=Spherical(1,(azz.degrad),(elz.degrad)).z.round(0.000000001).abs;

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;
				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;

);
~dur=~dur*2;



/////synths////
	(
		(
SynthDef.new(\ospace0, {
	arg amp=1,pl1=1;
	var sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=4,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3,rq1,rq2,rq3;
	var mag,magx,magy,magz,mag_x,mag_y,mag_z;
				var sig,rq;
					var ratio1,ratio2,ratio3;
	var scale,nn=25.neg;
					var osc11,osc22,osc33,sig1;

				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				//env=EnvGen.ar(Env.perc(0.025,decay,amp),doneAction:2,levelScale:1 );
				env=EnvGen.kr(Env.sine(decay,amp),doneAction:2,levelScale:0.05);

//fundamental=(12*6);
				scale=49.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(12*64);
freq=(fundamental*octave);

sphere=Spherical(24,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

		ton1 = 2.pow(Select.kr(ratio1.linlin(24.neg, 24, 0, 48), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(24.neg, 24, 0, 48), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(24.neg, 24, 0, 48), scale) / 12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				//sig= InFeedback.ar(4,1);
				sig1=In.kr(9);
				//rq=MouseX.kr(0.000001,1);
		/*	rq1=0.1;
				rq2=0.1;
				rq3=0.1;*/
				rq1=In.kr(0);
				rq2=In.kr(1);
				rq3=In.kr(2);
				/*	rq1=MouseX.kr(0.0000001,0.1);
				rq2=MouseX.kr(0.0000001,0.1);
				rq3=MouseX.kr(0.0000001,0.1);
*/

osc1=BPF.kr(sig1, pitch1, rq1, mul: amp1 * (rq1.sqrt.reciprocal));

osc2=BPF.kr(sig1,pitch2,rq2,mul:amp2* (rq2.sqrt.reciprocal));

osc3=BPF.kr(sig1,pitch3,rq3,mul:amp3* (rq3.sqrt.reciprocal));

				Out.kr(3,Lag.kr((ZeroCrossing.kr(osc1)*env),0.1));
					Out.kr(4,Lag.kr((ZeroCrossing.kr(osc2)*env),0.1));
							Out.kr(5,Lag.kr((ZeroCrossing.kr(osc3)*env),0.1));

}).add;
);
(
SynthDef.new(\ospace1, {
	arg amp=1,pl1=1;
	var sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=4,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3,rq1,rq2,rq3;
	var mag,magx,magy,magz,mag_x,mag_y,mag_z;
				var sig,rq;
					var ratio1,ratio2,ratio3;
	var scale,nn=25.neg;
				var ampx,ampy,ampz,mod_angle,mod_angle;

					m_x=In.kr(3).lag(0.1);
	m_y=In.kr(4).lag(0.1);
	m_z=In.kr(5).lag(0.1);

							mod_angle=SinOsc.ar(lfo_amp.lag(0.1),0.degrad,mul:1).range(90.neg.degrad,90.degrad);
			mod_angle1=SinOsc.ar(lfo_amp.lag(0.1),90.degrad,mul:1).range(90.neg.degrad,90.degrad);

				sph3=Spherical(ampx,Select.kr(pl1,~az),Select.kr(pl1,~el));
					sph4=Spherical(ampy,Select.kr(pl1,~az),Select.kr(pl1,~el));
		sph5=Spherical(ampz,Select.kr(pl1,~az),Select.kr(pl1,~el));

(

			mag_x=(
					mag_x=(Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis
/*
		(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

						);

mag_y=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),
		sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
						);

mag_z=(Complex(cos(((sph5.phi+mod_angle0).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph5.phi+mod_angle0).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho

						);
//mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				magx=mag_x.value;
				magy= mag_y.value;
				magz=mag_z.value;
				);
				//magx.poll;
				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				//env=EnvGen.ar(Env.perc(0.025,decay,amp),doneAction:2,levelScale:1 );
				env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:10);

//fundamental=(12*6);
				scale=49.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(12*64);
freq=(fundamental*octave);

sphere=Spherical(24,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

		ton1 = 2.pow(Select.kr(ratio1.linlin(24.neg, 24, 0, 48), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(24.neg, 24, 0, 48), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(24.neg, 24, 0, 48), scale) / 12);

amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				sig= InFeedback.ar(4,1);
				//rq=MouseX.kr(0.000001,1);
		/*	rq1=0.1;
				rq2=0.1;
				rq3=0.1;*/
				rq1=In.kr(0);
				rq2=In.kr(1);
				rq3=In.kr(2);
				/*	rq1=MouseX.kr(0.0000001,0.1);
				rq2=MouseX.kr(0.0000001,0.1);
				rq3=MouseX.kr(0.0000001,0.1);
*/

osc1=VBAP.ar(4,
					BPF.ar(sig, pitch1, rq1, mul: amp1 * magx* (rq1.sqrt.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
		);

osc2=VBAP.ar(4,
					BPF.ar(sig,pitch2,rq2,mul:amp2*magy* (rq2.sqrt.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg

		);

osc3=VBAP.ar(4,
						BPF.ar(sig,pitch3,rq3,mul:amp3*magz* (rq3.sqrt.reciprocal)),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:env));
	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
				Out.ar(0,LeakDC.ar(osc2,mul:env));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
				Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);

);

////////////list
	({
		var n=1.neg;
		~list1=(360*13).collect{
		n=n+1;
		}
		}.value
	);
	~list1=~list1.scramble;
///pattern
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace0,
			//\dur,Pseq(~dur,1),
			\dur,1,
			\pl1,Pseq(~list1,inf),
			\amp,1;
));
		~ab=Pdef(\2, Pbind(\instrument, \ospace1,
			//\dur,Pseq(~dur,1),
			\dur,1,
			\pl1,Pseq(~list1,inf),
			\amp,1;
));

);

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/My Movie 1 audio.wav",channels:0);
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/My Movie 1 audio.wav",channels:1);
	TempoClock.default.tempo_(1);

	~m=Buffer.alloc(s,2048);
			{
var signal,wt,env;

	//	env=Env([0.0001,0.0001,0.05,0.1,0.1,0.05,0.0001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		env=Env([0.0001,0.0001,0.001,0.1,0.1,0.001,0.0001,0.0001],[40,30,20,10,20,30,40],[0,12,-4,0,4,-12,0]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		//signal.plot;
~m.loadCollection(wt);
		}.value;

(
~synth=(
SynthDef.new(\obuff, {
	arg buffer=0;
	var sig1,sig2,env,gain=1;

			//env= EnvGen.ar(Env.sine(10),doneAction:2);

			sig1=PlayBuf.kr(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
			//sig2=PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 1, doneAction:2);


			Out.ar(4,sig1*gain);
				Out.kr(9,sig1*gain);
			//	Out.ar(5,sig2*gain);
				Out.kr(0,Osc.kr(~m.bufnum,0.01,phase:0.degrad));
				Out.kr(1,Osc.kr(~m.bufnum,0.01,phase:10.degrad));
				Out.kr(2,Osc.kr(~m.bufnum,0.01,phase:20.degrad));
	//Out.kr(0, (ZeroCrossing.ar(sig1)*0.008));



}).add;
);
);

}
)

Buffer.freeAll;


TempoClock.default.tempo_(1);


Scale.directory;

(
	Synth(\obuff);
~aa.play;
~ab.play;
//~aaa.play;
);

s.record(numChannels:4);


///sp freeze
~c3 = Buffer.readChannel(s,,channels:0 );

(
~fftsize=8192;
~hop=0.25;
~win=0;
~f={Buffer.alloc(s,~c1.duration.calcPVRecSize(~fftsize,~hop))}!2;
)
(
{
	var sig,chain,localbuf;
	sig=PlayBuf.ar(2, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0,doneAction:2);
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
