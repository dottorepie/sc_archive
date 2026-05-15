(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*128;
s.options.blockSize = 64*8;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

(

~t= Buffer.alloc(s,2048);
);

////////////////////////////////////speaker setup///other

	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


		~time=4;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=1,m_z=3;
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

		 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
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

	//////////////mag phase levels
	{
	 	var pl=1.neg;
		~mag_levels=(720*~time).collect{
			pl=pl+1;
			Cartesian(~magx.[pl], ~magy.[pl],~magz.[pl],).rho/(2.sqrt);
		};

	}.value;
		{
	 	var pl=1.neg;
		~phase_levels=(720*~time).collect{
			pl=pl+1;
			Complex(exp(Complex(0,1)*~az.[pl]).real.round(0.000001),exp(Complex(0,1)*~el.[pl]).imag.round(0.000001)).theta;

		};
	}.value;

	// Env(~phase_levels,[0.01]).plot;


/////synths////
(
SynthDef.new(\ospace1, {
	arg angle_rot1=0,angle_rot2=0,angle_rot3=0,angle_rot4=0,angle_rot5=0,mult=12,xr=1,yr=1,zr=1,gate=1,pl1=0;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,decay=0.04444,pl=0,octave=1,envp;
	var ton1,ton2,ton3,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=2000,fundamental1,fundamental2,fundamental3;
	var freq1,freq2,freq3,m=1,pitch1,pitch2,pitch3,env,cutt=440;
	var v0,v,v6,q1,q2,q3,q4,q5,axis;
	var pitch;
	var xyz,xyz_array;
	var n1,n2,n3;
	var sphere1,sphere2,sphere3;
	var env_mag,env_phase;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!


freq1=(48000/1024);

				//	envp=EnvGen.ar(Env.adsr(0.1,0.5,1/2,8,1),gate:gate);

360.do{
					 env_mag=EnvGen.ar(Env(~mag_levels.scramble,[1/2],\sine));
			 env_phase=EnvGen.ar(Env(~phase_levels.scramble,[1/2],\sine));

							mag_o=Cartesian(~magx.[pl], ~magy.[pl],~magz.[pl]);

			sphere1=Spherical(mag_o.x,~az.[pl],~el.[pl]);
	sphere2=Spherical(mag_o.y,~az.[pl],~el.[pl]);
	sphere3=Spherical(mag_o.z,~az.[pl],~el.[pl]);
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),~az.[pl],~el.[pl]);

osc1=VBAP.ar(4,
				SinOsc.ar(freq1*m,mul:m.reciprocal*env_mag,phase:env_phase),
~b.bufnum,
//sphere.theta.raddeg,sphere.phi.raddeg
Osc.ar(~t.bufnum,1,phase:sphere.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
Osc.ar(~t.bufnum,1,phase:sphere.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1));
								m=m+1;
				pl=pl+1
		}

}).add;
);

}
)
Synth(\ospace1)
