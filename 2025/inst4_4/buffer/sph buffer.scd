(
(
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);

//////////////////////////////////////////////////basis
(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;


~az=[];~el=[];~magx=[];~magy=[];~magz=[];

		360.do{
azimuth=(13).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
			el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(13);

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(13).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(13);

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

magnitudex=(13).collect{

			az3 = (angle+(360*2.pow(pl3/12))).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ (180*2.pow(pl3/12))).wrap(90.neg,90);
		pl3=(pl3+1).mod(13);
	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

};

magnitudey=(13).collect{

			az4 = (angle+(360*2.pow(pl4/12))).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+(180*2.pow(pl4/12))).wrap(90.neg,90);
		pl4=(pl4+1).mod(13);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
};

magnitudez=(13).collect{

			az5 = (angle+(360*2.pow(pl5/12))).wrap(180.neg,180);  // Increment azimuth
			el5 = (angle+(180*2.pow(pl5/12))).wrap(90.neg,90);
		pl5=(pl5+1).mod(13);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez};
}.value;
(
~magx=(~magx).round(0.000000001)/(2.sqrt);
			~magy=(~magy).round(0.000000001)/(2.sqrt);
			~magz=(~magz).round(0.000000001)/(2.sqrt);
 );
)

Buffer.freeAll

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/zoom/buffer/wind1(mesimeri  sto balkoni).WAV",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/PROJECT  FILES/recordings/zoom/buffer/wind2(piano).WAV",channels:1);

s.record(numChannels:4);


(
~m=Pseq(~k,1).asStream;
~f=Pseq(~k,1).asStream;
~synths = [];
x = {
    var newSynth;
    newSynth =Synth(\obin_++(~m.next)); // Create a new Synth
    ~synths = ~synths.add(newSynth); // Add it to the array
    newSynth.postln; // Print the Synth to confirm
};
)
x.value; // Call x to create a new Synth
~synths.[~f.next].free

(
({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	);


~seed = 12345.rand;
(
//~d=Pxrand(~k,512).asStream;
thisThread.randSeed = ~seed;~d=~k.scramble;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=0;
    var in1,in2,chainx,chainy;
	var chainxx,chainyy;
	var bank,frames=1024;
	var samplerate=44100;
	var az,el,amp1,amp2,sig1,sig2;
	var env;

//env=EnvGen.ar(Env([0,1,1,0],[0,~dur,0]));

			in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2)
			in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 0, doneAction:2)
		az=~az.[i+1];
		el=~el.[i+1];

//amp=Cartesian(~magx[i+1],~magy.[i+1],~magz.[i+1]);
			amp1=Cartesian(~magx[i+1],0,~magz.[i+1]);
			amp2=Cartesian(0,~magy.[i+1],~magz.[i+1]);


	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);
			b=~d.[i];

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
				[magnitude*(amp1.rho),phase]
}, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|magnitude, phase, bin|
				[magnitude*(amp2.rho),phase]
}, frombin: b, tobin: b, zeroothers: 1);

			sig1=IFFT(chainxx);
			sig2=IFFT(chainyy);

	Out.ar(0,VBAP.ar(4,sig1,~b.bufnum,az.raddeg,el.raddeg));
	Out.ar(0,VBAP.ar(4,sig2,~b.bufnum,az.raddeg,el.raddeg));
			chainx.clear;chainy.clear;

}).add;
);
}
)
)