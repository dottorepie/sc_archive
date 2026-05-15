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
~time=16;
////////fractal
{
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (720*~time).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

}.value;
{
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

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

}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR1 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR2 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR3 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=4,pl1=0,pl2=0;

~magL4 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR4 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=5,pl1=0,pl2=0;

~magL5 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR5 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=6,pl1=0,pl2=0;

~magL6 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR6 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

(
~magR=~magR/(2.sqrt);
~magL=~magL/(2.sqrt);
~magR1=~magR1/(2.sqrt);
~magL1=~magL1/(2.sqrt);
~magR2=~magR2/(2.sqrt);
~magL2=~magL2/(2.sqrt);
~magR3=~magR3/(2.sqrt);
~magL3=~magL3/(2.sqrt);
~magR4=~magR4/(2.sqrt);
~magL4=~magL4/(2.sqrt);
~magR5=~magR5/(2.sqrt);
~magL5=~magL5/(2.sqrt);
~magR6=~magR6/(2.sqrt);
~magL6=~magL6/(2.sqrt);
);

	(	~magx=[~magR1.round(0.0000000000001),~magR2.round(0.0000000000001),~magR3.round(0.0000000000001),~magR4.round(0.0000000000001),~magR5.round(0.0000000000001),~magR6.round(0.0000000000001)];
	~magy=[~magL1.round(0.0000000000001),~magL2.round(0.0000000000001),~magL3.round(0.0000000000001),~magL4.round(0.0000000000001),~magL5.round(0.0000000000001),~magL6.round(0.0000000000001)];
);

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
var in1,in2, chainx,chainy,b=0;
var chainxx,chainyy,mg;
var frames=(1024*1);

	 in1 = PlayBuf.ar(1, ~l.bufnum, BufRateScale.kr(~l.bufnum,), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~r.bufnum, BufRateScale.kr(~r.bufnum,), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

bank2.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mg=Complex(~magL.[pl],~magR.[pl]);
	//mg=Complex(Select.kr(pl,Select.kr(pl2,~magx)),Select.kr(pl,Select.kr(pl2,~magy)));
		//	mg=Complex(~magx.[pl2].[pl],~magy.[pl2].[pl]);

/*ph1=exp(Complex(0,1)*(Complex(mg.real,0).theta)).theta;
ph2=exp(Complex(0,1)*(Complex(0,mg.imag).theta)).theta;*/

		ph1=exp(Complex(0,1)*(Complex(mg.real,0).theta)).theta;
		ph2=exp(Complex(0,1)*(Complex(0,mg.imag).theta)).theta;

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx),pos1);
		signal2=Pan2.ar(IFFT(chainyy),pos2);
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



