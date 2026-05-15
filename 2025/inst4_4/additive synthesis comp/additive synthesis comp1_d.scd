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
var  sph1,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,mag,mag_x,mag_y,mag_z;
var angle = 0;

~tempo=0.01;


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
~lag=0.05;
SynthDef.new(\ospace1, {
	var phase,osc1,osc2,osc3,sphere,mag_o,pl=1,octave=1,mult=24,xr=1,yr=1,zr=1;
	var fundamental=110;
	var freq,m=1;
	var v0,v,v6,q1,q2,q3,q4,q5,axis;
	var xyz,xyz_array;
	var sphere1,sphere2,sphere3;
	var angle;
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


 amp1=(sphere1.rho*octave.reciprocal).round(0.00001);amp2=(sphere2.rho*octave.reciprocal).round(0.00001);amp3=(sphere3.rho*octave.reciprocal).round(0.00001);

pitch1=(freq*sphere1.rho.reciprocal).round(0.00001);pitch2=(freq*sphere2.rho.reciprocal).round(0.00001);pitch3=(freq*sphere3.rho.reciprocal).round(0.00001);


phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;


osc1=VBAP.ar(4,
//SinOsc.ar(pitchx1,mul:ampx1,phase:phase)+SinOsc.ar(pitchx2,mul:ampx2,phase:phase)+SinOsc.ar(ampx3,mul:ampx3,phase:phase),
				SinOsc.ar(freq*6,mul:amp1*6.reciprocal,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
//SinOsc.ar(pitchy1,mul:ampy1,phase:phase)+SinOsc.ar(pitchy2,mul:ampy2,phase:phase)+SinOsc.ar(ampy3,mul:ampy3,phase:phase),
				SinOsc.ar(freq*8,mul:amp2*8.reciprocal,phase:0),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
//SinOsc.ar(pitchz1,mul:ampz1,phase:phase)+SinOsc.ar(pitchz2,mul:ampz2,phase:phase)+SinOsc.ar(ampz3,mul:ampz3,phase:phase),
				SinOsc.ar(freq*9,mul:amp3*9.reciprocal,phase:0),
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