(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
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

	/////octahedron
	/*~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);*/

// 16
	// ~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],
	// 	[0, 0], [45, 0], [90, 0], [135, 0],[180.neg,0], [135.neg, 0], [90.neg, 0],[45.neg, 0],
	// [0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
	// //0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
	// ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
//)

///////////////////////////////////////////////////////arrays
///////fractal

//////////////////////////////////////////////////basis
{
var m_x=3,m_y=2,m_z=3,az=0,el=0,sph_axis;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var axis=Quaternion(0,0,0,1);
var angle=(360-(360/1.6180339887499))/2;
var sph1,sph2,sph3,sph4,sph5,sph;
var rotation,v,v1,v2,v3,v4,v5;
var rotation1,rotation2,rotation3,rotation4,rotation5;


~az=[0];~el=[0];~magx=[0];~magy=[0];~magz=[0];

 360.do{
		sph=Spherical(1,(az),(el));
		v=Quaternion(0, sph.x, sph.y, sph.z);
		rotation=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v=rotation*v*rotation.conjugate;
		az=Cartesian(v.b,v.c,v.d).theta.round(0.000001);
		el=Cartesian(v.b,v.c,v.d).phi.round(0.000001);
		sph_axis=Quaternion(0,v.b,v.c,v.d);
		angle=(360-(360/1.6180339887499))/2;

azimuth=(12).collect{

			sph1=Spherical(1,pi/2,0);
			v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
			rotation1=((sph_axis*exp(Complex(0,1)*(2pi*2.pow(pl1/12)).mod(2pi)).imag)+exp(Complex(0,1)*(2pi*2.pow(pl1/12)).mod(2pi)).real);
			v1=rotation1*v1*rotation1.conjugate;
			az1 = Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
			el1 =Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
		pl1=(pl1+1).mod(12);
			sph1=Spherical(1,az1,el1).theta.round(0.000001);
	};

elevation=(12).collect{

		sph2=Spherical(1,pi/2,0);
			v2=Quaternion(0, sph2.x, sph2.y, sph2.z);
			rotation2=((sph_axis*exp(Complex(0,1)*(2pi*2.pow(pl2/12)).mod(2pi)).imag)+exp(Complex(0,1)*(2pi*2.pow(pl2/12)).mod(2pi)).real);
			v2=rotation2*v2*rotation2.conjugate;
			az2 = Cartesian(v2.b,v2.c,v2.d).theta.round(0.000001);
			el2 =Cartesian(v2.b,v2.c,v2.d).phi.round(0.000001);
		pl2=(pl2+1).mod(12);
			sph2=Spherical(1,az2,el2).phi.round(0.000001);
	};

magnitudex=(12).collect{

			sph3=Spherical(1,pi/2,0);
			v3=Quaternion(0, sph3.x, sph3.y, sph3.z);
			rotation3=((sph_axis*exp(Complex(0,1)*(2pi*2.pow(pl3/12)).mod(2pi)).imag)+exp(Complex(0,1)*(2pi*2.pow(pl3/12)).mod(2pi)).real);
			v3=rotation3*v3*rotation3.conjugate;
			az3 = Cartesian(v3.b,v3.c,v3.d).theta.round(0.000001);
			el3 =Cartesian(v3.b,v3.c,v3.d).phi.round(0.000001);
		pl3=(pl3+1).mod(12);
			sph3=Spherical(1,az3,el3);
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
};
magnitudey=(12).collect{

			sph4=Spherical(1,pi/2,0);
			v4=Quaternion(0, sph4.x, sph4.y, sph4.z);
			rotation4=((sph_axis*exp(Complex(0,1)*(2pi*2.pow(pl4/12)).mod(2pi)).imag)+exp(Complex(0,1)*(2pi*2.pow(pl4/12)).mod(2pi)).real);
			v4=rotation4*v4*rotation4.conjugate;
			az4 = Cartesian(v4.b,v4.c,v4.d).theta.round(0.000001);
			el4 =Cartesian(v4.b,v4.c,v4.d).phi.round(0.000001);
		pl4=(pl4+1).mod(12);
			sph4=Spherical(1,az4,el4);

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};
magnitudez=(12).collect{

			sph5=Spherical(1,pi/2,0);
			v5=Quaternion(0, sph5.x, sph5.y, sph5.z);
			rotation5=((sph_axis*exp(Complex(0,1)*(2pi*2.pow(pl5/12)).mod(2pi)).imag)+exp(Complex(0,1)*(2pi*2.pow(pl5/12)).mod(2pi)).real);
			v5=rotation5*v5*rotation5.conjugate;
			az5 = Cartesian(v5.b,v5.c,v5.d).theta.round(0.000001);
			el5 =Cartesian(v5.b,v5.c,v5.d).phi.round(0.000001);
		pl5=(pl5+1).mod(12);
			sph5=Spherical(1,az5,el5);

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};
		~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez
	};
}.value;
(
			~magx=(~magx).round(0.0000001)/(2.sqrt);
			~magy=(~magy).round(0.0000001)/(2.sqrt);
			~magz=(~magz).round(0.0000001)/(2.sqrt);
 );

////////////////////////////////////////////////////////notes and durs
{
var dur=2,ph1,pl1=1;
///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
//rythm=[1,1/1,1,1,1/1];

~dur = (360*12).collect{
			ph1=Cartesian(~magx.[pl1],~magy.[pl1],~magz.[pl1]).rho/(2.sqrt);
	//index1=rythm.wrapAt(pl7);
	//pl7=pl7+1;
	pl1=pl1+1;
	//ph1=(ph1*dur).round(1/256);
	//t1=ph1*index1;
	ph1=(ph1*dur).round(1/256);

	};

}.value;
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
SynthDef.new(\ospace1, {
	arg mult=12,gate=1,pl1=1;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,decay=0.04444,pl2=0,envp,octave=1;
	var ton1,ton2,ton3;
	var fundamental;
	var freq,pitch1,pitch2,pitch3,env;
	var pitch;
	var n1,n2,n3;
	var sphere1,sphere2,sphere3;
	var xyz;

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

				env=EnvGen.ar(Env.adsr(0.1,0.5,0.5,4),gate:gate,doneAction:2,levelScale:0.5);

fundamental=(440);
freq=(fundamental*octave);

		mag_o=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));

	//sphere1=Spherical(mag_o.x,Select.kr(pl1,~az),Select.kr(pl1,~el));
	//sphere2=Spherical(mag_o.y,Select.kr(pl1,~az),Select.kr(pl1,~el));
	//sphere3=Spherical(mag_o.z,Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere=Spherical(mag_o.rho.round(0.00001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(sphere.rho,sphere.theta,sphere.phi);

	n1=(xyz.x).round(0.00001); n2=(xyz.y).round(0.00001); n3=(xyz.z).round(0.00001);

ton1=n1.abs.linlin(0,1,1,2*mult);
ton2=n2.abs.linlin(0,1,1,2*mult);
ton3=n3.abs.linlin(0,1,1,2*mult);


	    amp1=(ton1.reciprocal*octave.reciprocal).round(0.00001);
		amp2=(ton2.reciprocal*octave.reciprocal).round(0.00001);
		amp3=(ton3.reciprocal*octave.reciprocal).round(0.00001);

	pitch1=(freq*ton1).round(0.0001);
	pitch2=(freq*ton2).round(0.0001);
	pitch3=(freq*ton3).round(0.0001);

				//phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;

					///%2==0 simulates .even

					//envp=EnvGen.ar(Env.adsr(0.1,0.5,1/2,8,1),gate:gate);


osc1=VBAP.ar(4,
				SinOsc.ar(pitch1,mul:amp1*In.kr(~controlBus_magx).lag(0.1),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
						SinOsc.ar(pitch2,mul:amp2*In.kr(~controlBus_magy).lag(0.1),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
						SinOsc.ar(pitch3,mul:amp3*In.kr(~controlBus_magz).lag(0.1),phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere3.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere3.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:env));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);

////////////list
	({
		var n=1;
		~list1=(360*12).collect{
		n=n+1;
		}
		}.value
	);

//////////pattern for mobius strib of sequential or parallel play of directions
(
~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur,inf),
			\pl1,Prand(~list1,inf),
		//\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			\mult,Prand([1,2,4],inf),
			\gate,Pseq([1,0,1,1,0,1,0,1,1,0,1,1,1,0],inf),///l system
));
	);
	TempoClock.default.tempo_(2/1);


}
)

~aa.play;
			~t.play;
~angleRoutine1.play;
s.record(numChannels:4);

(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
)
(

 // Initialize angle
var rotation=0;

~tempo=0.5;
~tempo2=(~tempo*12);
~angleRoutine1 = Routine({

    loop {
		rotation.postln;
			~controlBus_rotation.set(rotation);
		rotation=(rotation+(360-(360/1.6180339887499))).wrap(0,360);
		rotation.postln;
		(~tempo2).wait;
    };

});
)
(
var  sph1,m_x=3,m_y=4,m_z=3,n=0;
var az1=0,el1=0,mag,mag_x,mag_y,mag_z;
var angle=0;

~t =  Routine({
		loop{

	/*			az1 = (0+(90*2.pow(n/12))).wrap(180.neg,180);
		el1 = (45*2.pow(n/12)).wrap(90.neg,90);

		n =24.rand;*/

		az1=(~controlBus_rotation.getSynchronous+(360*2.pow(n/12))).wrap(180.neg,180);
		el1=(180*2.pow(n/12)).wrap(90.neg,90);

	/*	az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)
*/
					n =12.rand;

	sph1=Spherical(1,(az1.degrad),(el1.degrad));

mag_x=(Complex(cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;
		/* mag_x=(Complex(cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph1.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;*/
		mag_x=mag_x/(2.sqrt);
mag_y=(Complex(sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph1.rho;
//		mag_y=(Complex(sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph1.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;
		mag_y=mag_y/(2.sqrt);
	if(
m_z.even,
mag_z=Complex(cos((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph1.rho,
mag_z=Complex(sin((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph1.rho
	);
		mag_z=mag_z/(2.sqrt);

		~controlBus_az.set(sph1.theta.round(0.00001));
		~controlBus_el.set(sph1.phi.round(0.00001));
	~controlBus_magx.set(mag_x);
		~controlBus_magy.set(mag_y);
		~controlBus_magz.set(mag_z);
	~tempo.wait;
}});

)