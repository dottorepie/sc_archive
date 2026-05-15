(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*1;
s.options.maxNodes = 1024 * 16;
//s.options.sampleRate= 44100;
s.waitForBoot
);


/////wavetables
Buffer.freeAll;
(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
~controlBus_rotation_x = Bus.control(s, 1);
~controlBus_rotation_y = Bus.control(s, 1);
~controlBus_rotation_z = Bus.control(s, 1);
);

(

 // Initialize angle
var rotation,angle=(360-(360/1.6180339887499))/2,axis=Quaternion(0,0,0,1),sph,az=0,el=0,v,sph_axis,xx,yy,zz;

~tempo2=1;
~angleRoutine1 = Routine({

    loop {
			sph=Spherical(1,(az),(el));
		v=Quaternion(0, sph.x, sph.y, sph.z);
		rotation=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v=rotation*v*rotation.conjugate;
		az=Cartesian(v.b,v.c,v.d).theta.round(0.000001);
		el=Cartesian(v.b,v.c,v.d).phi.round(0.000001);
		sph_axis=Cartesian(v.b,v.c,v.d);
		xx=sph_axis.x;
		yy=sph_axis.y;
		zz=sph_axis.z;
			~controlBus_rotation_x.set(xx);
		~controlBus_rotation_y.set(yy);
		~controlBus_rotation_z.set(zz);
		(~tempo2).wait;
    };

});
);

(
var  sph1,m_x=1,m_y=1,m_z=1,n=0,rotation1;
var az1=0,el1=0,mag,mag_x,mag_y,mag_z,v1,sph_axis;
var angle=0;

~tempo=1/12;


~t =  Routine({
		loop{
		sph_axis=Quaternion(0,~controlBus_rotation_x.getSynchronous,~controlBus_rotation_y.getSynchronous,~controlBus_rotation_z.getSynchronous);
	sph1=Spherical(1,pi/2,0);
			v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
			rotation1=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(n/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(n/12)).mod(2pi)).real);
			v1=rotation1*v1*rotation1.conjugate;
			az1 = Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
			el1 =Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
		n=(n+1).mod(13);

	sph1=Spherical(1,(az1),(el1));

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

);
(
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
~lag=0.05;
SynthDef.new(\ospace1, {
	var phase,osc1,osc2,osc3,sphere,mag_o,pl=1,octave=2,mult=24,xr=1,yr=1,zr=1;
	var tonx1,tonx2,tonx3,tony1,tony2,tony3,tonz1,tonz2,tonz3;
	var fundamental=220;
	var freq,m=1;
	var ampx1,ampx2,ampx3,ampy1,ampy2,ampy3,ampz1,ampz2,ampz3;
	var pitchx1,pitchx2,pitchx3,pitchy1,pitchy2,pitchy3,pitchz1,pitchz2,pitchz3;
	var v0,v,v6,q1,q2,q3,q4,q5,axis;
	var xyz,xyz_array;
	var nx1,nx2,nx3,ny1,ny2,ny3,nz1,nz2,nz3;
	var sphere1,sphere2,sphere3;
	var sph1,sph2,sph3;
	var angle,sph,n1,n2,n3;
	var ton1,ton2,ton3;
	var amp1,amp2,amp3;
	var pitch1,pitch2,pitch3;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

freq=(fundamental*octave);

			mag_o=Cartesian(In.kr(~controlBus_magx).lag(~lag),In.kr(~controlBus_magy).lag(~lag),In.kr(~controlBus_magz).lag(~lag));

	sphere1=Spherical(mag_o.x,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere2=Spherical(mag_o.y,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere3=Spherical(mag_o.z,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));

		xyz=Spherical(sphere.rho,sphere.theta,sphere.phi);

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001); n3=(xyz.z).round(0.00000001);

ton1=n1.abs.linlin(0,1,1,2);
ton2=n2.abs.linlin(0,1,1,2);
ton3=n3.abs.linlin(0,1,1,2);


	    amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
		amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
		amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);
	pitch3=(freq*ton3).round(0.0000001);


				//phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;


osc1=VBAP.ar(4,
//SinOsc.ar(pitchx1,mul:ampx1,phase:phase)+SinOsc.ar(pitchx2,mul:ampx2,phase:phase)+SinOsc.ar(ampx3,mul:ampx3,phase:phase),
				SinOsc.ar(pitch1,mul:amp1,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
//SinOsc.ar(pitchy1,mul:ampy1,phase:phase)+SinOsc.ar(pitchy2,mul:ampy2,phase:phase)+SinOsc.ar(ampy3,mul:ampy3,phase:phase),
				SinOsc.ar(pitch2,mul:amp2,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
//SinOsc.ar(pitchz1,mul:ampz1,phase:phase)+SinOsc.ar(pitchz2,mul:ampz2,phase:phase)+SinOsc.ar(ampz3,mul:ampz3,phase:phase),
				SinOsc.ar(pitch3,mul:amp3,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere3.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere3.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:1));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:1));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:1));

}).add;
);



(
~angleRoutine1.play;
~t.play;
Synth(\ospace1);
//s.record(numChannels:4)
)