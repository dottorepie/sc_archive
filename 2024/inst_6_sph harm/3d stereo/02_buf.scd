(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 16;
s.waitForBoot
)


Buffer.freeAll
////////////////////buffers
(
~l = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/n-carkade/2001 - O Vothros Anoikse/N-Carkade - O Vothros Anoikse.mp3",channels:0 );
~r = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/band album library/n-carkade/2001 - O Vothros Anoikse/N-Carkade - O Vothros Anoikse.mp3",channels:1 );
)
/////////arrays
(
(
var phase,angle=0,phase1,angle1=90;

~phase1=1440.collect{

	phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	phase.round(0.0001)
};
~phase2=1440.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1.round(0.0001).neg
};

)

(
var phase1,phase2,angle1=0,angle2=0,m=2;

~posL=1440.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

~posR=1440.collect{

	phase2=exp(Complex(0,1)*angle2.degrad).theta;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

)

(
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2;

~magL = 1440.collect{

	phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = 1440.collect{

	phase1=exp(Complex(0,1)*angle1.degrad).theta;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
)
)


//////////////synth
(
{
var signal1,signal2,env1,env2,pl=89;
var pos1,pos2,phase1,phase2,ph1,ph2;
var in1,in2, chainx,chainy,b=0;
var chainxx,chainyy,mg,pie=2pi;
var frames=(1024*1);
var fund;
	fund=48000/256;

	 in1 = PlayBuf.ar(1, ~l.bufnum, BufRateScale.kr(~l), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~r.bufnum, BufRateScale.kr(~r), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

360.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		phase1=~phase1.[pl];
		phase2=~phase2.[pl];
		mg=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt)).rho/(2.sqrt);

		//env1=EnvGen.ar(Env([1,1],[360]),doneAction:2);
		//env2=EnvGen.ar(Env([1,1],[360]),doneAction:2);

chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*mg, exp(Complex(0,1)*(phase+SinOsc.ar(mg.reciprocal*fund,phase1))).theta]; }, frombin: b, tobin: b, zeroothers: 1);
chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*mg, exp(Complex(0,1)*(phase+SinOsc.ar(mg.reciprocal*fund,phase2))).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx),pos1);
		signal2=Pan2.ar(IFFT(chainyy),pos2);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
		Out.ar(0,signal2);

}
}.play;
//s.record;
)

