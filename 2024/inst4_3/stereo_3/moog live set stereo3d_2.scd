(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=2;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*32;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)



(
		~time=32;
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
//////////////////////////////////////////////////basis
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

)


////////////////////osc

(
SynthDef.new(\ostereo,
{
arg pl1=1;
var signal1,signal2,pl=0,in1,in2,chainx,chainxx,chainy,chainyy;
var pos1,pos2,ph1,ph2,mg,b=0;
var amp,bank=360,frames=1024,pos;

	in1 = SoundIn.ar(0);
		in2 = SoundIn.ar(0);

	chainx = FFT(LocalBuf(frames), in1);
		chainy = FFT(LocalBuf(frames), in2);


		bank.do{

		pos1=~posL.[pl]/(2.sqrt);
			pos2=~posR.[pl]/(2.sqrt);
			pos=Complex(pos1,pos2).rho;

			//mg=Complex(Select.kr(pl1,~magL),Select.kr(pl1,~magR));
				mg=Complex(~magL.[pl],~magR.[pl]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mg=mg.round(0.0000000001);


		ph1=Complex(exp(Complex(0,1)*(~az.[pl])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001)).theta+90.degrad;
		ph2=Complex(exp(Complex(0,1)*(~az.[pl])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001)).theta;


chainxx = chainx.pvcollect(frames, {|mag, phase, index| [mag*mg.real, exp(Complex(0,1)*(phase+ph1)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

chainyy = chainy.pvcollect(frames, {|mag, phase, index| [mag*mg.imag, exp(Complex(0,1)*(phase+ph2)).theta]; }, frombin: b, tobin: b, zeroothers: 1);

		signal1=Pan2.ar(IFFT(chainxx),pos);
			signal2=Pan2.ar(IFFT(chainyy),pos.neg);
b=b+1;
pl=pl+1;
		Out.ar(0,signal1);
			Out.ar(0,signal2);

}
}).add;
)

~synth1=Synth(\ostereo);
(
MIDIClient.init;
MIDIIn.connectAll;

	(
MIDIdef.cc(\midi1,{ |val, num, chan, src|
		var r;
	//[val, num, chan, src].postln;
	r=val.linlin(0,127,0,1440);
		r.postln;
		~synth1.set(\pl1,r);
},25);
	);


)
