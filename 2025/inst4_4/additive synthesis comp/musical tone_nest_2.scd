(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

~t= Buffer.alloc(s,2048);


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
var iter = 16;

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

magnitudex=(12).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

magnitudey=(12).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
				el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even

};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
);
~dur=~dur+1;

		//////////////////////wavetable
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;

		//////notes
	({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle1=~angle/2;
	);
/////synths////
	(
(
SynthDef.new(\ospace1, {
	arg mult1=1,mult2=1,mult3=1,amp=1,pl1=1,n1=0,n2=0,n3=0;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=6,pl2=0,envp,octave=6;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var mag,magx,magy,magz;
	var xyz,sph,cart;

			// var wrappedOut1 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut2 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var wrappedOut3 = { |busArray, signalArray|
			// 	[busArray, signalArray].flop.do { |pair|
			// Out.ar(pair[0], pair[1])}};
			// var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

//mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				magx=Cartesian(Select.kr(pl1,~magx), 0,0);
				magy=Cartesian(0, Select.kr(pl1,~magy),0);
				magz=Cartesian(0, 0,Select.kr(pl1,~magz));

				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				env=EnvGen.ar(Env.perc(0.02,decay,amp),doneAction:2,levelScale:2);
				//env=EnvGen.ar(Env.sine(decay,amp),doneAction:2,levelScale:1);
fundamental=(72);
freq=(fundamental*octave);

sphere=Spherical(1,Select.kr(pl1,~az),Select.kr(pl1,~el));

//n2=(n1+5);n3=(n1+7);
				xyz=[n1,n2,n3].normalizeSum.sqrt;
				cart=Cartesian(xyz[0],xyz[1],xyz[2]);
				sph=Spherical(32,cart.theta,cart.phi);

				ton1=2.pow(sph.x/12);ton2=2.pow(sph.y/12);ton3=2.pow(sph.z/12);


amp1=(ton1.reciprocal*octave.reciprocal*mult1.reciprocal).round(0.00000001);
amp2=(ton2.reciprocal*octave.reciprocal*mult2.reciprocal).round(0.00000001);
amp3=(ton3.reciprocal*octave.reciprocal*mult3.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);

				//phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;

					///%2==0 simulates .even


osc1=VBAP.ar(4,
					SinOsc.ar(pitch1,mul:amp1*magx.rho.round(0.00000001),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
						SinOsc.ar(pitch2,mul:amp2*magy.rho.round(0.00000001),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
					SinOsc.ar(pitch3,mul:amp3*magz.rho.round(0.00000001),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
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
		~list1=(360*8*13).collect{
		n=n+1;
		}
		}.value
	);
//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,1),
			//\dur,1,
			\pl1,Pbrown(0,4320,12,inf),
			\n1,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
				\n2,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
				\n3,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		\mult1,Prand([1,2],inf),
				\mult2,Prand([1,2],inf),
				\mult3,Prand([1,2],inf),
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
));
		~aaa=Pdef(\2, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,1),
			//\dur,1,
			\pl1,Pbrown(0,4320,12,inf),
			\n1,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
				\n2,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
				\n3,
			Pseq([
				Prand(
				[PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),
				PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor),PdegreeToKey(Pseq(Array.rand(3,0,7),1),Scale.minor)]
				,1)
			],inf),
			//\pl1,Pseq(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		\mult1,Prand([2,4],inf),
				\mult2,Prand([2,4],inf),
				\mult3,Prand([2,4],inf),
			\amp,Pseq(~r,inf);///l system
			//\amp,1;
));

	);
	TempoClock.default.tempo_(2/1);



}
)


(
~aa.play;
~aaa.play;
);

s.record(numChannels:4);
Scale.directory;