 (
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
Buffer.freeAll;
////////////////////////////////////speaker setup///other

	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);


///////////////////////////////////////////////////////arrays
///////l-system
	(
{
var dict = IdentityDictionary[\A -> "AB", \B -> "A"];
//These are the production rules of the L-system
var word = "A";
var string_temp = "";
var iter = 18;

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
	////no0
	///Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])
	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~az=[];~el=[];~dur=[];

		361.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(14,(azx.degrad),(elx.degrad))).x.round(1/32);

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(14,(azy.degrad),(ely.degrad))).y.round(1/32);

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(14,(azz.degrad),(elz.degrad))).z.round(1/32);

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))).phi.round(0.00001);

	};

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
);

	////////////list
	({
		var n=1.neg;
		~list1=(360*12+1).collect{
		n=n+1;
		}
		}.value
	);

		({
		var n=1.neg;
		~list2=(360*12*10).collect{
		n=n+1;
		}
		}.value
	);

	({
		var n=0; ~list=[];
		(360*12*10+1).do{ n=n+(10.reciprocal);
			~list=~list++~list1.[n];
	}}.value);
~list=~list.scramble;

/////synths////


		(
SynthDef.new(\ospace, {

			}).add;
);

			({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);

		({
		var n=1.neg;
		~listaz=(360*12+1).collect{
		n=n+1;
		}
		}.value

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);
	);

		({
		var n=1.neg;
		~listel=(360*12*10).collect{
		n=n+1;
		}
		}.value
	);

	({
		var n=0; ~list=[];
		(360*12*10+1).do{ n=n+(10.reciprocal);
			~list=~list++~list1.[n];
	}}.value);
~list=~list.scramble;

//////////pattern


		~aa=Pdef(\1, Pbind(\instrument, \ospace,
			\dur,Pseq(,inf),

));
	TempoClock.default.tempo_(2);


s.meter;s.freqscope;s.scope;
}
)

(
	~m=Buffer.alloc(s,2048);
			{
var signal,wt,env;

		env=Env([0,1,1,0],[50,100,50],[4,0,-4]);
		signal=env.asSignal(1024);
wt=signal.asWavetable;
		//signal.plot;
~m.loadCollection(wt);
		}.value;
);

(
~aa.play;
{Out.kr(0,Osc.ar(~m.bufnum,300.reciprocal,mul:1))}.play;
);

s.record(numChannels:4);