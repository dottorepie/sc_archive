(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*32;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
(
~b= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
)
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


(
~time=8;
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

{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=12;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/1,1,1,1/1];

~dur1 = (90*~time).collect{
	ph1=Complex(~magL.[pl1],~magR.[pl1]).rho/(2.sqrt).round(0.0000000001);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/32);
	t1=ph1*index1;

	};

}.value;

)
(
SynthDef.new(\ostereo1,
{
		arg decay=8,speed=1,pl1=0,angle_r=0,gate=1;
var signal1,signal2,env,m=2,freq1,freq2,amp1,amp2,pl=1,nx,ny,octave=8,phase;
var pos1,pos2,phase1,phase2,ph,mag,fundamental=440,freq,pitch1,pitch2,mult=20;
var chainx,chainy,amp,rq=1,cutt,f,pl2=0,bank1=90,pos;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

		var out1 = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
		var out2 = NamedControl.kr(\out2, [0, 1]);  // multiple buses!

fundamental=fundamental*speed.reciprocal;
		freq=fundamental*octave;

bank1.do{

		pos1=~posR.[pl];
		pos2=~posL.[pl];
			pos=Complex(pos1,pos2).rho;
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
				//mag=Complex(Select.kr(pl1,~magR),Select.kr(pl1,~magL));
			mag=Complex(~magL.[pl],~magR.[pl]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

				//nx=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).real*mult;
				//ny=exp(Complex(0,1)*((angle_r*mag.theta)).wrap(2pi.neg,2pi)).imag*mult;

			nx=exp(Complex(0,1)*(~az.[pl]*angle_r)).real*mult;
			ny=exp(Complex(0,1)*(~el.[pl]*angle_r)).imag*mult;


		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);
			//pitch1=pitch1.round(1);
		//	pitch2=pitch2.round(1);


		ph=Complex(exp(Complex(0,1)*(~az.[pl])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001)).theta;

			amp1=octave.reciprocal*speed*pitch1.reciprocal;
		amp2=octave.reciprocal*speed*pitch2.reciprocal;
		f=freq;
//phase=if(pl2%2==0,0.degrad,90.degrad);
env=EnvGen.ar(Env.adsr(0.01,0.5,0.5,decay),gate:gate,doneAction:2,levelScale:0.01);

				signal1=SinOsc.ar(f*pitch1,ph,amp1);
				signal2=SinOsc.ar(f*pitch2,ph,amp2);
	//m=m+1;

		wrappedOut1.value(out1,Pan2.ar(LeakDC.ar(signal1),pos,env));
		wrappedOut2.value(out2,Pan2.ar(LeakDC.ar(signal2),pos.neg,env));

					pl=pl+1;
}
}).add;
);

)

(
	({
		var n=1.neg;
		~list=(720*~time).collect{
		n=n+1;
		}
		}.value
	);

	({
		var angle=0;
		~angle=(90*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value
	);
);
(
a=Pdef(\1, Pbind(\instrument, \ostereo1,
	\dur,Pseq(~dur1,1),
\angle_r,Pseq(~angle,inf),
	\gate,Pseq([1,0,1,1,0,1,0,1,1,0,1,1,1,0],inf),
	//\pl1,Pseq(~list,inf),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\decay,Pbrown(2,4,1,inf),
	//\speed,Prand([1,3/4,2/3,1/2],inf);
));

	);
TempoClock.default.tempo_(1/2);
/////with tempo 1 and ~time 1 overall duration of a is 2.08 min

	/////////////////////scales
Scale.directory;

(
Tdef.new(\h,{
//loop({
a.play;
//(120).wait;
//(120).wait;
//	})
})
)


//Tdef(\h).stop;
Tdef(\h).play;
//Tdef(\h).clear;
