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
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
(
//~controlBus_az = Bus.control(s, 1);
//~controlBus_el = Bus.control(s, 1);
//~controlBus_magx = Bus.control(s, 1);
//~controlBus_magy = Bus.control(s, 1);
//~controlBus_magz = Bus.control(s, 1);
~controlBus_angle  = Bus.control(s, 1);
);


(
var angle = 0;

~tempo=0.1;

~angleRoutine = Routine({
    loop {
        // Calculate the next angle
      angle = (angle + (360 - (360 / 1.6180339887499))).wrap(0, 360);
		"angle".postln;
		angle.postln;
				~controlBus_angle.set((angle/2).degrad);
		~tempo.wait;
    }
});
);

	(
	~time=16;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=4,m_z=3;
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

			mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
		 	cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
			2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

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
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
~t= Buffer.alloc(s,2048);
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
);
(
~lag=0.01;
SynthDef.new(\ospace1, {
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,pl=1,octave=2,mult=12,xr=1,yr=1,zr=1;
	var ton1,ton2,ton3;
	var fundamental=110;
	var freq,m=1,pitch1,pitch2,pitch3;
	var v0,v,v1,v2,v3,q;
	var pitch;
	var xyz,xyz_array;
	var n1,n2,n3;
	var sphere1,sphere2,sphere3;
	var sph1,sph2,sph3;

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


64.do{

	 v0=Quaternion(0,0.57735026918963,0.57735026918963,0.57735026918963);

	mag_o=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]);

	sph1=Spherical(mag_o.x,~az.[pl],~el.[pl]);
	sph2=Spherical(mag_o.y,~az.[pl],~el.[pl]);
	sph3=Spherical(mag_o.z,~az.[pl],~el.[pl]);
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),~az.[pl],~el.[pl]);

	xyz=Spherical(mult*mag_o.rho.round(0.00000001)/(2.sqrt),sphere.theta,sphere.phi);

v=Quaternion(0, xyz.x, xyz.y, xyz.z);
v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
v2=Quaternion(0, sph2.x, sph2.y, sph2.z);
v3=Quaternion(0, sph3.x, sph3.y, sph3.z);


				q=((v0*exp(Complex(0,1)*In.kr(~controlBus_angle).lag(~lag)).imag)+exp(Complex(0,1)*In.kr(~controlBus_angle).lag(~lag)).real);

	 v=q*v*q.conjugate;
	 v1=q*v1*q.conjugate;
	 v2=q*v2*q.conjugate;
	 v3=q*v3*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);
	sphere1=Cartesian(v1.b,v1.c,v1.d);
	sphere2=Cartesian(v2.b,v2.c,v2.d);
	sphere3=Cartesian(v3.b,v3.c,v3.d);


	n1=(pitch.x).round(0.00001); n2=(pitch.y).round(0.00001); n3=(pitch.z).round(0.00001);

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));


	    amp1=(ton1.reciprocal*octave.reciprocal*sphere1.rho).round(0.0000000000001);
		amp2=(ton2.reciprocal*octave.reciprocal*sphere2.rho).round(0.0000000000001);
		amp3=(ton3.reciprocal*octave.reciprocal*sphere3.rho).round(0.0000000000001);

	pitch1=(freq*ton1*sphere1.rho.reciprocal).round(0.0000000000001);
	pitch2=(freq*ton2*sphere2.rho.reciprocal).round(0.0000000000001);
	pitch3=(freq*ton3*sphere3.rho.reciprocal).round(0.0000000000001);

				phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;


osc1=VBAP.ar(4,
				//Osc.ar(~w1.bufnum,pitch1,mul:amp1,phase:phase+ph_x.theta),
				SinOsc.ar(pitch1+pl,mul:amp1*pl.reciprocal,phase:phase),
~b.bufnum,
sphere1.theta.raddeg,sphere1.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
				//Osc.ar(~w3.bufnum,pitch3,mul:amp3,phase:phase+ph_z.theta),
						SinOsc.ar(pitch2+pl,mul:amp2*pl.reciprocal,phase:phase),
~b.bufnum,
sphere2.theta.raddeg,sphere2.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
					//Osc.ar(~w3.bufnum,pitch3,mul:amp3,phase:phase+ph_z.theta),
						SinOsc.ar(pitch3+pl,mul:amp3*pl.reciprocal,phase:phase),
~b.bufnum,
sphere3.theta.raddeg,sphere3.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere3.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere3.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc3,mul:1)));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc2,mul:1)));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc1,mul:1)));

					pl=pl+1;
	}

}).add;
);
}
)


(
~angleRoutine.play;
Synth(\ospace1);
//s.record(numChannels:4)
)