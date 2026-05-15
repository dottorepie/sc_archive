(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
~b= Buffer.alloc(s,2048);

(
var env,sig,wt,angle=0,level,levels;

~levels=360.collect{

	level=exp(Complex(0,1)*angle).imag;
		angle=angle+1.degrad;
	levels=level.rrand(exp(Complex(0,1)*angle+((360-(360/1.6180339887499))/100).degrad).imag);
};
env = Env(~levels,[1]);
sig=env.asSignal(1024);
wt = sig.asWavetable;
~b.loadCollection(wt);
sig.plot;
)

////////fractal
(
~time=32;
////////fractal
		{
var signal,wt,m=0,amp;

~level=90.round(1).collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
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

}.value;
{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

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

)


////////////////////osc

(
{
var signal1,signal2,env1,env2,pl=0,m=1,fund=55,freq1,freq2,amp1,amp2;
var pos1,pos2,phase1,phase2,ph1,ph2,mag,octave=4;
var chainx,chainy,amp,rq=1,cutt,pos;

360.do{

		pos1=~posL.[pl]/(2.sqrt);
		pos2=~posR.[pl]/(2.sqrt);
		pos=Complex(pos1,pos2).rho;
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mag=Complex(~magL.normalize(0,1).[pl],~magR.normalize(0,1).[pl]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.00001);


		ph1=exp(Complex(0,1)*(2pi*mag.real).mod(2pi)).theta;
		ph2=exp(Complex(0,1)*(2pi*mag.imag).mod(2pi)).theta;

		amp1=m.reciprocal;
		amp2=m.reciprocal;
		freq1=fund*amp1.reciprocal;
		freq2=fund*amp2.reciprocal;
		cutt=mag.rho/(2.sqrt);
		rq=cutt/1;
//env1=EnvGen.ar(Env.sine(45,0.1),doneAction:2);
//env2=EnvGen.ar(Env.sine(45,0.1),doneAction:2);

	//	signal1=BPF.ar(Osc.ar(~b.bufnum,freq1,ph1,amp1),fund*cutt.reciprocal,rq,1/rq.sqrt);
	//	signal2=BPF.ar(Osc.ar(~b.bufnum,freq1,ph2,amp2),fund*cutt.reciprocal,rq,1/rq.sqrt);


	signal1=Osc.ar(~b.bufnum,freq1,ph1,amp1);
	signal2=Osc.ar(~b.bufnum,freq1,ph2,amp2);
	m=m+1;

pl=pl+1;

		Out.ar(0,Pan2.ar(LeakDC.ar(signal1),pos,mag.rho/(2.sqrt)));
		Out.ar(0,Pan2.ar(LeakDC.ar(signal2),pos.neg,mag.rho/(2.sqrt)));

}
}.play;
//s.record
)

