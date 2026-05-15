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
//sig.plot;
	}.value;


(
~time=8;
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


);

		({
		var angle=0;
		~angle=(720*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value
	);

////////////////////osc

(
SynthDef.new(\light,
{
arg octave=2,angle_r=0,gain=0.1;
var signal1,signal2,env,amp1,amp2,pl=0,nx,ny,mult=12,m=1,pl1=0;
var pos1,pos2,phase1,phase2,mag,fundamental=110,freq,pitch1,pitch2;
var amp,phase,c1,c2,pos;

fundamental=fundamental*speed.reciprocal;
		freq=fundamental*octave;
(720).do{

		pos1=~posL.[pl1];
		pos2=~posR.[pl1];
					pos=Complex(pos1,pos2).rho;
		//phase1=~phase1.[pl];
		//phase2=~phase2.[pl];
		mag=Complex(~magL.[pl1],~magR.[pl1]);

		//ph1=SinOsc.ar(mag.reciprocal,phase1,mag);
		//ph2=SinOsc.ar(mag.reciprocal,phase2,mag);
		mag=mag.round(0.0000000001);

				c1=Polar(mag.real,mag.theta);
				c2=Polar(mag.imag,mag.theta);

				nx=Polar(mult*(mag.rho/2.sqrt),Select.kr(angle_r,~angle).degrad).x;
			    ny=Polar(mult*(mag.rho/2.sqrt),Select.kr(angle_r,~angle).degrad).y;
				//nx=c1.x*mult;
				//ny=c1.y*mult;

		pitch1=2.pow(nx/12);
		pitch2=2.pow(ny/12);


		phase=Complex(exp(Complex(0,1)*(~az.[pl])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl])).imag.round(0.000001)).theta;

		amp1=m.reciprocal*octave.reciprocal*pitch1.reciprocal;
		amp2=m.reciprocal*octave.reciprocal*pitch2.reciprocal;

				signal1=(Osc.ar(~b.bufnum,freq*pitch1*m,phase,amp1));
				signal2=(Osc.ar(~b.bufnum,freq*pitch2*m,phase,amp2));

				Out.ar(0,Pan2.ar(LeakDC.ar(signal1),pos,gain));
				Out.ar(0,Pan2.ar(LeakDC.ar(signal2),pos.neg,gain));

						pl1+pl1=1;
						m=m+1;
					}

}).add;
);

SerialPort.devices;
~port = SerialPort.new("/dev/cu.usbserial-1340",9600);

		(
~charArray = [];
~getValues = Routine.new({

	var ascii;
	{ascii = ~port.read.asAscii;
		if(ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});
		if(ascii == $a,{~val = ~charArray.collect(_.digit).convertDigits;
			~charArray =[];
		});
	}.loop;

}).play
);


(
		//1.wait;
~synth=Synth.new(\light, [\angle_r,45]);
(~control = Routine.new({
	{
				~synth.set(\angle_r,~val.linlin(100,1200,0,(720*~time)));
		0.01.wait;
	}.loop;
}).play;
	))

	}
)


