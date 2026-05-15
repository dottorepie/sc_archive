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
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,spha,sphb,sphc,sphd,sphe;
var angle=0,sph;
var  seed1 = 123,seed2=123,seed3=123,seed4=123,seed5=123,seed=123;
var azimuth,elevation,magnitudex,magnitudey,magnitudez,magg;
	var xyz1,xyz2,xyz3,xyz4,xyz5;



	~az=[];~el=[];~magx=[];~magy=[];~magz=[];~mag=[];
360.do{

azimuth=(13).collect{
thisThread.randSeed = seed1;
			seed1=seed1+1;

		xyz1=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		spha=Cartesian(xyz1.[0]*([1.neg,1].choose),xyz1.[1]*([1.neg,1].choose),xyz1.[2]*([1.neg,1].choose));
			az1=(angle.degrad+spha.theta).wrap(pi.neg,pi);
			el1=(angle.degrad+spha.phi).wrap((pi/2).neg,(pi/2));
		sph1=Spherical(1,(az1),(el1)).theta.round(0.00001);
	};

elevation=(13).collect{
thisThread.randSeed = seed2;

			seed2=seed2+1;

			xyz2=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphb=Cartesian(xyz2.[0]*([1.neg,1].choose),xyz2.[1]*([1.neg,1].choose),xyz2.[2]*([1.neg,1].choose));
az2=(angle.degrad+sphb.theta).wrap(pi.neg,pi);
			el2=(angle.degrad+sphb.phi).wrap((pi/2).neg,(pi/2));
		sph2=Spherical(1,(az2),(el2)).phi.round(0.00001);

	};

magnitudex=(13).collect{
thisThread.randSeed = seed3;

			seed3=seed3+1;

			xyz3=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphc=Cartesian(xyz3.[0]*([1.neg,1].choose),xyz3.[1]*([1.neg,1].choose),xyz3.[2]*([1.neg,1].choose));
			az3=(angle.degrad+sphc.theta).wrap(pi.neg,pi);
			el3=(angle.degrad+sphc.phi).wrap((pi/2).neg,(pi/2));
		sph3=Spherical(1,(az3),(el3));

	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
};

magnitudey=(13).collect{
					thisThread.randSeed = seed4;

			seed4=seed4+1;

			xyz4=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphd=Cartesian(xyz4.[0]*([1.neg,1].choose),xyz4.[1]*([1.neg,1].choose),xyz4.[2]*([1.neg,1].choose));
			az4=(angle.degrad+sphd.theta).wrap(pi.neg,pi);
			el4=(angle.degrad+sphd.phi).wrap((pi/2).neg,(pi/2));
	sph4=Spherical(1,(az4),(el4));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(13).collect{
					thisThread.randSeed = seed5;

			seed5=seed5+1;

			xyz5=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphe=Cartesian(xyz5.[0]*([1.neg,1].choose),xyz5.[1]*([1.neg,1].choose),xyz5.[2]*([1.neg,1].choose));
			az5=(angle.degrad+sphe.theta).wrap(pi.neg,pi);
			el5=(angle.degrad+sphe.phi).wrap((pi/2).neg,(pi/2));
	sph5=Spherical(1,(az5),(el5));
if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;~mag=~mag++mag};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
);

//////////////////////////////////////////////////////// durs

	///binary basis

	(
{
var angle1=0, angle2=0,value1,value2,n1=0,n2=0,re,im,angle=0;
			~real=[];~imag=[];

			(360).do {
  re=12.collect{
					n1=(n1+1);
					angle1 = (angle + (n1*(pi/12))).wrap(0,2pi);
					//angle1 = (angle + (pi/2)*2.pow(n1/12)).wrap(0,2pi);
		//n1=(n1+1).mod(13);
					value1=exp(Complex(0,1)*angle1).real.abs.round(0.00001);};
  im=12.collect{
					n2=(n2+1);
					angle2 = (angle + (n2*(pi/12))).wrap(0,2pi);
					//angle2 = (angle + (pi/2)*2.pow(n2/12)).wrap(0,2pi);
		//n2=(n2+1).mod(13);
		value2=exp(Complex(0,1)*angle2).imag.abs.round(0.00001);};

				~real=~real++re; ~imag=~imag++im; n1=0;n2=0;
				angle = (angle + (360-(360/1.6180339887499))).wrap(0, 360);
			};
}.value
);

	(
{
var dur=1,ph1,pl1=0,sph;
///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
//rythm=[1,1/1,1,1,1/1];

~dur1 = (360*12).collect{
			//ph1=Cartesian(~magx.[pl1],~magy.[pl1],~magz.[pl1]).rho/(2.sqrt);
			//ph1=~magz.[pl1];
			//sph=Spherical(ph1,~az.[pl1],~el.[pl1]).x.abs;
			sph=~real.[pl1];
	//index1=rythm.wrapAt(pl7);
	//pl7=pl7+1;
	pl1=pl1+1;
	//ph1=(ph1*dur).round(1/256);
	//t1=ph1*index1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	{
var dur=1,ph1,pl1=0,sph;
///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
//rythm=[1,1/1,1,1,1/1];

~dur2 = (360*12).collect{
			//ph1=Cartesian(~magx.[pl1],~magy.[pl1],~magz.[pl1]).rho/(2.sqrt);
			//ph1=~magz.[pl1];
			//sph=Spherical(ph1,~az.[pl1],~el.[pl1]).x.abs;
			sph=~imag.[pl1];
	//index1=rythm.wrapAt(pl7);
	//pl7=pl7+1;
	pl1=pl1+1;
	//ph1=(ph1*dur).round(1/256);
	//t1=ph1*index1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	);
//////////////dur randomization

{	var seed = 1000.rand;
thisThread.randSeed = seed; ~duration_x1 = ~dur1.scramble;
thisThread.randSeed = seed; ~duration_y1 = ~dur2.scramble;	}.value;


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
	arg mult1=1,mult2=1,mult3=1,amp=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,amp1,amp2,amp3,decay=5,pl2=0,envp,octave=4;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3;
	var mag;

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

mag=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));
				//mag=Cartesian(0, Select.kr(pl1,~magx),0);
				//env=EnvGen.ar(Env.adsr(0.05,0.5,0.5,decay),gate,doneAction:2,levelScale:0.1);
				env=EnvGen.ar(Env.perc(0.02,decay,amp),doneAction:2,levelScale:1/4);

fundamental=(55);
freq=(fundamental*octave);

sphere=Spherical(1,Select.kr(pl1,~az),Select.kr(pl1,~el));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

ton1=n1.abs.linlin(0,1,1,2)*mult1;
ton2=n2.abs.linlin(0,1,1,2)*mult2;
ton3=n3.abs.linlin(0,1,1,2)*mult3;

ton1=n1.abs*mult1;ton2=n2.abs*mult2;ton3=n3.abs*mult3;


amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);pitch3=(freq*ton3).round(0.0000001);

				//phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;

					///%2==0 simulates .even


osc1=VBAP.ar(4,
					SinOsc.ar(pitch1,mul:amp1*mag.rho.round(0.00000001),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
						SinOsc.ar(pitch2,mul:amp2*mag.rho.round(0.00000001),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1/2,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1/4,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
					SinOsc.ar(pitch3,mul:amp3*mag.rho.round(0.00000001),phase:0),
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
		~list1=(360*13).collect{
		n=n+1;
		}
		}.value
	);

//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
		\dur,Pseq(~dur1,1),
			//\dur,1,
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,13,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
				\mult3,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
));

~aaa=Pdef(\9, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur2,1),
			//\dur,1,
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,13,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
				\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
				\mult3,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
			\amp,1;
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
