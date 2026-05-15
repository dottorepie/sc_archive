(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*64;
s.options.blockSize = 64/1;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
)


Buffer.freeAll
////////////////////buffers
(
~l = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav",channels:0 );
~r = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/piece of my heart Intermission.wav",channels:1);
)


(
~time=32;
////////fractal
{
var c,cc,angle=0,c_real,c_imag,z;
var c1,cc1,angle1=0,c_real1,c_imag1,z1;

~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real.round(0.000001),c_imag.round(0.000001));
 };
z=Complex(0,0);

~j = (2*720*~time).collect{
	cc=~c.[4];
	z=z.pow(2)+cc;
	z.theta.round(0.0000000000001);

};

~k = 5.collect{
 	c_real1=exp(Complex(0,1)*angle1.degrad).real;
	c_imag1=exp(Complex(0,1)*angle1.degrad).imag;
 	angle1=(angle1+45).wrap(0,360);
 	c1=Complex(c_real1.round(0.000001),c_imag1.round(0.000001));
 };
z1=Complex(0,0);

~h = (2*720*~time).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

		}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (720*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad*~h.[pl1]).wrap(pi.neg,pi),(el1.degrad*~j.[pl1]).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (720*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad*~h.[pl2]).wrap(pi.neg,pi),(el2.degrad*~j.[pl2]).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};
}.value;
/*{
var phase1,phase2,angle1=0,angle2=0,m=3,pl1=0,pl2=0;

~posL=(720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;*/
{
var phase1,phase2,pl1=1.neg,pl2=1.neg;

~posL=(720*~time).collect{

	pl1=pl1+1;
	phase1=exp(Complex(0,1)*(~az.[pl1])).real.round(0.000001);

};

~posR=(720*~time).collect{

	pl2=pl2+1;
	phase2=exp(Complex(0,1)*(~el.[pl1])).imag.round(0.000001);
};

}.value
{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=Complex(exp(Complex(0,1)*(~az.[pl1])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl1])).imag.round(0.000001)).theta;

	pl1=pl1+1;

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR = (720*~time).collect{

	phase1=Complex(exp(Complex(0,1)*(~az.[pl2])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl2])).imag.round(0.000001)).theta;
	pl2=pl2+1;

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
}.value;


);

//////////////synth
/*(
SynthDef.new(\ostereobuf,
	{
arg pl1=0;
var signal1,signal2,env1,env2,pl=1,bank2=4,pl2=0,bank1=90;
var pos1,pos2,phase1,phase2,ph1,ph2;
var in1,in2, chainx,chainy,b=0;
var chainxx,chainyy,mg;
var frames=(1024*1);

	 in1 = PlayBuf.ar(1, ~l.bufnum, BufRateScale.kr(~l.bufnum,), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~r.bufnum, BufRateScale.kr(~r.bufnum,), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

bank2.do{
			bank1.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mg=Complex(Select.kr(pl1,~magx.[pl2]),Select.kr(pl1,~magy.[pl2]));
	//mg=Complex(Select.kr(pl,Select.kr(pl2,~magx)),Select.kr(pl,Select.kr(pl2,~magy)));
		//	mg=Complex(~magx.[pl2].[pl],~magy.[pl2].[pl]);

/*ph1=exp(Complex(0,1)*(Complex(mg.real,0).theta)).theta;
ph2=exp(Complex(0,1)*(Complex(0,mg.imag).theta)).theta;*/

			ph1=exp(Complex(0,1)*(2pi*mg.real).mod(2pi)).theta;
		ph2=exp(Complex(0,1)*(2pi*mg.imag).mod(2pi)).theta;

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx),pos1);
		signal2=Pan2.ar(IFFT(chainyy),pos2);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
		Out.ar(0,signal2);
		};
	pl2=pl2+1;
		}
}).add

)*/

(
SynthDef.new(\ostereobuf,
	{
arg pl1=0;
var signal1,signal2,env1,env2,pl=1,bank2=360,pl2=0,bank1=90;
var pos1,pos2,phase1,phase2,ph1,ph2;
var in1,in2, chainx,chainy,b=0,pos,p;
var chainxx,chainyy,mg;
var frames=(1024*1);

	 in1 = PlayBuf.ar(1, ~l.bufnum, BufRateScale.kr(~l.bufnum,), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~r.bufnum, BufRateScale.kr(~r.bufnum,), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

bank2.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		//	p=Point(pos1,pos2).theta;
			pos=Point(pos1,pos2).rho;
		mg=Complex(~magL.[pl],~magR.[pl]);
	//mg=Complex(Select.kr(pl,Select.kr(pl2,~magx)),Select.kr(pl,Select.kr(pl2,~magy)));
		//	mg=Complex(~magx.[pl2].[pl],~magy.[pl2].[pl]);
			///pos=Polar(mg.rho/(2.sqrt),p);

/*ph1=exp(Complex(0,1)*(Complex(mg.real,0).theta)).theta;
ph2=exp(Complex(0,1)*(Complex(0,mg.imag).theta)).theta;*/

		ph1=Complex(exp(Complex(0,1)*(~az.[pl])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001)).theta;
		ph2=Complex(exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001),exp(Complex(0,1)*(~az.[pl])).real.round(0.000001)).theta;

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho), exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho), exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx),pos);
		signal2=Pan2.ar(IFFT(chainyy),pos.neg);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
		Out.ar(0,signal2);
		};
}).add

)

~synth1=Synth(\ostereobuf);
(
MIDIClient.init;
MIDIIn.connectAll;


		(
MIDIdef.cc(\midi4,{ |val, num, chan, src|
		var set;
		~set=val.linlin(0,127,0,720*~time).round(1);
	//[val, num, chan, src].postln;
		set=val.linlin(0,127,0,720*~time).round(1);
		set.postln;
		~synth1.set(\pl1,set);
},25);
	);
	);



