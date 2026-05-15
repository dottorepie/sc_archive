(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

~t= Buffer.alloc(s,2048);


///////////////////////////////////////////////////////arrays
///////l-system
	(
{
var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//These are the production rules of the L-system
var word = "A";
var string_temp = "";
var iter = 16;

//These are diction for the mapping of the alphabet to "artistic" parameters: degrees in a scale, beat occurrence, etc.

var dictnotes = IdentityDictionary[\A -> 0, \B -> 1];
 ~r=[];

//This iteration generates the system recursively

iter.do({

word.asArray.do({|i|
    string_temp = string_temp ++ dict[i.asSymbol];
});

word = string_temp;
	string_temp = "";
});

word.postln;

//Here we map the final system to the parameters as above

word.do({|i| ~r = ~r ++ dictnotes[i.asSymbol];});

~r.postln;
}.value
);


//////////////////////////////////////////////////basis
	(
		{
var position,angle=0,mx=3,my=3,n=0,thita;
var pos,magx,magy;
var position1,position2,thita1,thita2,n1=0,n2=0,mag1,mag2;
~angle=[];~magx=[];~magy=[];

360.do{

pos= 13.collect{

		thita = angle.degrad + ((pi/4)*2.pow(n/12));
		n=(n+1).mod(13);
		n.postln;
	position=exp(Complex(0,1)*thita).theta;

};

magx = 13.collect{

        thita1 = angle.degrad + ((pi/4)*2.pow(n1/12));
		n1=(n1+1).mod(13);
	position1=exp(Complex(0,1)*thita1).theta;

	mag1=(Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position1.round(0.000001)*mx)).real,exp(Complex(0,1)*(position1.round(0.0001)*mx)).real).rho).round(0.0001);

	};

magy = 13.collect{

	    thita2 = angle.degrad + ((pi/4)*2.pow(n2/12));
		n2=(n2+1).mod(13);
	position2=exp(Complex(0,1)*thita2).theta;

		mag2=(Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).imag,exp(Complex(0,1)*(position2.round(0.0001)*my)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(position2.round(0.000001)*my)).real,exp(Complex(0,1)*(position2.round(0.0001)*my)).real).rho).round(0.0001);

	};
	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360); ~angle=~angle++pos;~magx=~magx++magx;~magy=~magy++magy;
	}
		}.value;
);

//////////////////////////////////////////////////////// durs

	///binary basis

	(
{
var angle1=0, angle2=0,value1,value2,n1=0,n2=0,re,im,angle=0;
			~real=[];~imag=[];

			(360).do {
  re=12.collect{
					n1=(n1+1);
					angle1 = (angle + (n1*(pi/12))).wrap(0,2pi);
					//angle1 = (angle + (pi/2)*2.pow(n1/12)).wrap(0,2pi);
		//n1=(n1+1).mod(13);
					value1=exp(Complex(0,1)*angle1).real.abs.round(0.00001);};
  im=12.collect{
					n2=(n2+1);
					angle2 = (angle + (n2*(pi/12))).wrap(0,2pi);
					//angle2 = (angle + (pi/2)*2.pow(n2/12)).wrap(0,2pi);
		//n2=(n2+1).mod(13);
		value2=exp(Complex(0,1)*angle2).imag.abs.round(0.00001);};

				~real=~real++re; ~imag=~imag++im; n1=0;n2=0;
				angle = (angle + (360-(360/1.6180339887499))).wrap(0, 360);
			};
}.value
);

	(
{
var dur=1,ph1,pl1=0,sph;


~dur1 = (360*12).collect{
			sph=~real.[pl1];
	pl1=pl1+1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	{
var dur=1,ph1,pl1=0,sph;

~dur2 = (360*12).collect{
			sph=~imag.[pl1];
	pl1=pl1+1;
	ph1=(sph+dur).round(1/32);

	};

}.value;
	);
//////////////dur randomization

{	var seed = 1000.rand;
thisThread.randSeed = seed; ~duration_x1 = ~dur1.scramble;
thisThread.randSeed = seed; ~duration_y1 = ~dur2.scramble;	}.value;


		//////////////////////wavetable
			(
{
		var angle=0;
		~angle=(720).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
	~phase=90.collect{~angle.[m].degrad};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
);



/////synths////
	(
(
SynthDef.new(\ospace1, {
	arg mult1=1,mult2=1,amp=1,pl1=1;
	var phase,osc1,osc2,sphere,mag_o,amp1,amp2,decay=7,octave=2;
	var ton1,ton2;
	var fundamental;
	var freq,pitch1,pitch2,env;
	var pitch;
	var n1,n2;
	var xyz;

				env=EnvGen.ar(Env.perc(0.01,decay,amp),doneAction:2,levelScale:4);

fundamental=(55);
freq=(fundamental*octave);

		mag_o=Complex(Select.kr(pl1,~magx), Select.kr(pl1,~magy));
				sphere=Polar(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~angle));

	xyz=Polar(sphere.rho,sphere.theta);

	n1=(xyz.x).round(0.00000001); n2=(xyz.y).round(0.00000001);

ton1=n1.abs.linlin(0,1,1,2*mult1);
ton2=n2.abs.linlin(0,1,1,2*mult2);

	    amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
		amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);
	pitch2=(freq*ton2).round(0.0000001);



osc1=Pan2.ar(SinOsc.ar(pitch1,mul:amp1,phase:0),exp(Complex(0,1)*sphere.theta).real);

osc2=Pan2.ar(SinOsc.ar(pitch2,mul:amp2,phase:0),exp(Complex(0,1)*sphere.theta).imag);

					Out.ar(0,LeakDC.ar(osc2,mul:env));

					Out.ar(0,LeakDC.ar(osc1,mul:env));

}).add;
);
);

////////////list
	({
		var n=1;
		~list1=(360*12).collect{
		n=n+1;
		}
		}.value
	);

	~dur=[1/2,1,1,1/3,1/2,1/5,1,1/2];

//////////pattern for mobius strib of sequential or parallel play of directions
	(

~aa=Pdef(\1, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur1,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,6,inf),
			\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
));

~aaa=Pdef(\9, Pbind(\instrument, \ospace1,
			\dur,Pseq(~dur2,1),
			//\dur,Pxrand(~dur,inf),
			//\pl1,Prand(~list1,inf),
			\pl1,Pbrown(0,4680,6,inf),
				\mult1,Prand([1,2,4,8],inf),
				\mult2,Prand([1,2,4,8],inf),
			//\amp,Pseq(~r,inf);///l system
));
	);
	TempoClock.default.tempo_(1/32);



}
)


(
~aa.play;
~aaa.play;
);
s.record(numChannels:2);
