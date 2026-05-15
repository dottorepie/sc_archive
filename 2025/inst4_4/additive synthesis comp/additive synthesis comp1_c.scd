(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*1;
s.options.maxNodes = 1024 * 16;
//s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
);


(
var  sph1,m_x=3,m_y=4,m_z=3;
var az1=0,el1=0,mag,mag_x,mag_y,mag_z;
var angle = 0;

~tempo=0.1;


~o =  Routine({
		loop{
		az1=(az1+(1)).wrap(180.neg,180);
	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);
	sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2)));

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

		"az".postln;
		sph1.postln;
		~controlBus_az.set(sph1.theta.round(0.00001));
		~controlBus_el.set(sph1.phi.round(0.00001));
	~controlBus_magx.set(mag_x);
		~controlBus_magy.set(mag_y);
		~controlBus_magz.set(mag_z);
	~tempo.wait;
}});

)



(
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
	//	~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	//~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);

~t= Buffer.alloc(s,2048);
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
//signal.plot;
		}.value;
);
(
~lag=0.01;
SynthDef.new(\ospace1, {
	var phase,osc1,osc2,osc3,sphere,mag_o,pl=1,octave=4,mult=24,xr=1,yr=1,zr=1;
	var tonx1,tonx2,tonx3,tony1,tony2,tony3,tonz1,tonz2,tonz3;
	var fundamental=110;
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

			sph1=Spherical(sphere1.rho*mult,sphere.theta,sphere.phi);
			sph2=Spherical(sphere2.rho*mult,sphere.theta,sphere.phi);
			sph3=Spherical(sphere3.rho*mult,sphere.theta,sphere.phi);
			sph=Spherical(sphere.rho*mult,sphere.theta,sphere.phi);


			n1=(sph.x).round(0.00001); n2=(sph.y).round(0.00001); n3=(sph.z).round(0.00001);
	nx1=(sph1.x).round(0.00001); nx2=(sph1.y).round(0.00001); nx3=(sph1.z).round(0.00001);
	ny1=(sph2.x).round(0.00001); ny2=(sph2.y).round(0.00001); ny3=(sph2.z).round(0.00001);
	nz1=(sph3.x).round(0.00001); nz2=(sph3.y).round(0.00001); nz3=(sph3.z).round(0.00001);

			ton1=2.pow(n1/(2*6));ton2=2.pow(n2/(2*6));ton3=2.pow(n3/(2*6));
tonx1=2.pow(nx1/(2*6));tonx2=2.pow(nx2/(2*6));tonx3=2.pow(nx3/(2*6));
tony1=2.pow(ny1/(2*6));tony2=2.pow(ny2/(2*6));tony3=2.pow(ny3/(2*6));
tonz1=2.pow(nz1/(2*6));tonz2=2.pow(nz2/(2*6));tonz3=2.pow(nz3/(2*6));

 amp1=(ton1.reciprocal*octave.reciprocal).round(0.00001);amp2=(ton2.reciprocal*octave.reciprocal).round(0.00001);amp3=(ton3.reciprocal*octave.reciprocal).round(0.00001);
   ampx1=(tonx1.reciprocal*octave.reciprocal).round(0.00001);ampx2=(tonx2.reciprocal*octave.reciprocal).round(0.00001);ampx3=(tonx3.reciprocal*octave.reciprocal).round(0.00001);
   ampy1=(tony1.reciprocal*octave.reciprocal).round(0.00001);ampy2=(tony2.reciprocal*octave.reciprocal).round(0.00001);ampy3=(tony3.reciprocal*octave.reciprocal).round(0.00001);
   ampz1=(tonz1.reciprocal*octave.reciprocal).round(0.00001);ampz2=(tonz2.reciprocal*octave.reciprocal).round(0.00001);ampz3=(tonz3.reciprocal*octave.reciprocal).round(0.00001);

			pitch1=(freq*ton1).round(0.00001);pitch2=(freq*ton2).round(0.00001);pitch3=(freq*ton3).round(0.00001);
	pitchx1=(freq*tonx1).round(0.00001);pitchx2=(freq*tonx2).round(0.00001);pitchx3=(freq*tonx3).round(0.00001);
	pitchy1=(freq*tony1).round(0.00001);pitchy2=(freq*tony2).round(0.00001);pitchy3=(freq*tony3).round(0.00001);
	pitchz1=(freq*tonz1).round(0.00001);pitchz2=(freq*tonz2).round(0.00001);pitchz3=(freq*tonz3).round(0.00001);

				phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;


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
}
)


(
~o.play;
Synth(\ospace1);
//s.record(numChannels:4)
)