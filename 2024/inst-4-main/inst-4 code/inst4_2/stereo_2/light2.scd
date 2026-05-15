(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*64;
s.options.blockSize = 64*8;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
);

s.waitForBoot{
(
~b= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
);
{
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
	}.value;


(
~time=2;
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

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	phase1=(Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho).round(0.0001);

};

	~posR=(720*~time).collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
	phase2=(Complex(sin(phase2.round(0.0001)*m),sin(phase2.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase2.round(0.0001)*m),cos(phase2.round(0.0001)*m)).rho).round(0.0001).neg;
};

}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=1,pl1=0,pl2=0;

~magL1 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR1 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL2 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR2 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=3,pl1=0,pl2=0;

~magL3 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR3 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=4,pl1=0,pl2=0;

~magL4 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR4 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=5,pl1=0,pl2=0;

~magL5 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR5 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
	pl2=pl2+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	mag1=Complex(sin(phase1.round(0.0001)*m),sin(phase1.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase1.round(0.0001)*m),cos(phase1.round(0.0001)*m)).rho.round(0.0001);
	};
}.value;

{
var phase,angle=0,mag,phase1,angle1=0,mag1,m=6,pl1=0,pl2=0;

~magL6 = (720*~time).collect{

	phase=exp(Complex(0,1)*(angle.degrad*~j.[pl1]).wrap(2pi.neg,2pi)).theta;
	pl1=pl1+1;
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	mag=Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001)*Complex(cos(phase.round(0.0001)*m),cos(phase.round(0.0001)*m)).rho.round(0.0001);
	};

~magR6 = (720*~time).collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl2]).wrap(2pi.neg,2pi)).theta;
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

{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=12;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/2,1,1,1/2];

~dur1 = (45*~time).collect{
	ph1=(Complex(~magL.[pl1],~magR.[pl1]).rho/(2.sqrt)).round(0.0000000001);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/256);
	t1=ph1*index1;

	};

}.value;
);


////////////////////osc

(
SynthDef.new(\ostereo,
{
arg decay=6,speed=1,octave=1,pl1=0,angle_r=0,gain=1,pl2=0;
var signal1,signal2,env,amp1,amp2,pl=0,nx,ny,mult=12;
var pos1,pos2,phase1,phase2,mag,fundamental=55,freq,pitch1,pitch2;
var amp,phase,c1,c2;

fundamental=fundamental*speed.reciprocal;
		freq=fundamental*octave;
env=EnvGen.ar(Env.sine(decay,0.1),doneAction:2);


		pos1=Select.kr(pl1,~posL)/(2.sqrt);
		pos2=Select.kr(pl1,~posR)/(2.sqrt);
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mag=Complex(Select.kr(pl1,Select.kr(pl2,~magx)),Select.kr(pl1,Select.kr(pl2,~magy)));

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

				c1=Polar(mag.real,mag.theta);
				c2=Polar(mag.imag,mag.theta);

				nx=exp(Complex(0,1)*((angle_r*c1.theta)).wrap(2pi.neg,2pi)).real*mult;
			    ny=exp(Complex(0,1)*((angle_r*c2.theta)).wrap(2pi.neg,2pi)).imag*mult;
				//nx=c1.x*mult;
				//ny=c1.y*mult;

		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);

				phase=if(pl2%2==0,0.degrad,90.degrad);

		amp1=octave.reciprocal*speed*pitch1.reciprocal;
		amp2=octave.reciprocal*speed*pitch2.reciprocal;

				signal1=(Osc.ar(~b.bufnum,freq*pitch1,SinOsc.ar(c1.rho,phase,c1.theta.abs),amp1));
				signal2=(Osc.ar(~b.bufnum,freq*pitch2,SinOsc.ar(c2.rho,phase,c2.theta.abs),amp2));

				Out.ar(0,Pan2.ar(LeakDC.ar(signal1),pos1,env));
				Out.ar(0,Pan2.ar(LeakDC.ar(signal2),pos2,env));

}).add;
);
	({
		var n=1.neg;
		~list=(720*~time).collect{
		n=n+1;
		}
		}.value
	);
		({
		var angle=0;
		~angle=(45*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value
	);
(
a=Pdef(\1, Pbind(\instrument, \ostereo,
	\dur,Pseq(~dur1.mirror,inf),
\angle_r,Pseq(~angle.mirror,inf),
	\pl1,Pxrand(~list,inf),
	\pl2,Pbrown(0,11,inf),
		\octave,Prand([1,2,4],inf),
	\decay,Pbrown(4,8,1,inf),
	\speed,Prand([1,3/4,2/3,1/2],inf);
));
	);
TempoClock.default.tempo_(2);
/////with tempo 1 and ~time 1 overall duration of a is 2.08 min


//a.play;


SerialPort.devices;
~port = SerialPort.new("/dev/cu.usbserial-210",9600);


	}
)


