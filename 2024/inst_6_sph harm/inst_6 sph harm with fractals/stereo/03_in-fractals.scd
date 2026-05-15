(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=1;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


////////fractal
(
var c,angle=0,c_real,c_imag,z;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (1440*2).collect{
	c=~c.[4];
	z=z.pow(2)+c;
	z.theta.round(0.000001);
}

)

////////arrays
// (
// var phase,angle=0,phase1,angle1=90,pl1=0,pl2=0;
//
// ~phase1=1440.collect{
//
// 	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
// 	pl1=pl1=1;
// 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
// 	phase.round(0.0001)
// };
// ~phase2=1440.collect{
//
// 	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
// 	pl2=pl2=1;
// 	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
// 	phase1.round(0.0001)
// };
//
// )

(
var phase1,phase2,angle1=0,angle2=0,m=3,pl1=0,pl2=0;

~posL=1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

~posR=1440.collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

)

(
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL = 1440.collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1])).theta;
	pl1=pl1=1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = 1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2])).theta;
	pl2=pl2=1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
)


//////////////synth
(
{
var signal1,signal2,env1,env2,pl=0;
var pos1,pos2,phase1,phase2;
var in1,in2, chainx,chainy,b=0;
var chainxx,chainyy,mg,ph1,ph2;
var frames= 1024*2;

	in1 = SoundIn.ar(0);
	in2 =  SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
	chainy = FFT(LocalBuf(frames), in2);

360.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mg=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt));

		//env1=EnvGen.ar(Env([1,1],[360]),doneAction:2);
		//env2=EnvGen.ar(Env([1,1],[360]),doneAction:2);

ph1=exp(Complex(0,1)*(exp(Complex(0,1)*(mg.theta+90.degrad)).theta)).theta;
ph2=exp(Complex(0,1)*mg.theta).theta;

		chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);
		chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*(mg.rho/(2.sqrt)), exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);


		signal1=Pan2.ar(IFFT(chainxx),pos1);
		signal2=Pan2.ar(IFFT(chainyy),pos2);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
		Out.ar(0,signal2);

}
}.play
)






