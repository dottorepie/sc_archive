
s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(60/30);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/9/studio projects/recordings final/339326__inspectorj__bird-whistling-a mono.wav");
~a.query;
~a.numFrames

///////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////animation with sound
(
var w,run = true, kapa, y, z,x=0,theta,x1=0,y1;
var ray1=400,ray=400;
var angle1=1,angle=1;
var a=2;
(
(
SynthDef.new(\id1, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=110,l=440;
	var sig;
	var env;
	var freq=1,audio=0,x=0,amp=1;

	//freq=n*6*f;
	    env=EnvGen.ar(Env.perc(a,4,pr/6,[-4,-4]),doneAction:2);
		24.do{
		sig=PanAz.ar(2,BLowPass.ar(FSinOsc.ar(f*6,mul:1/amp),l),LFSaw.ar(1/amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};


		Out.ar(0,audio*env);
	~a = Amplitude.ar(InFeedback.ar(0), 0.01, 0.25);
	~b = Pitch.kr(InFeedback.ar(0));
		~c= Amplitude.ar(InFeedback.ar(1), 0.01, 0.25);
	~d = Pitch.kr(InFeedback.ar(1));
	SendReply.ar(Impulse.ar(100), '/a', ~a);
	SendReply.ar(Impulse.ar(100), '/b', ~b);
	SendReply.ar(Impulse.ar(100), '/c', ~c);
	SendReply.ar(Impulse.ar(100), '/d', ~d);
}).add;
);
(
SynthDef.new(\id2, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/8,[-4,-4]),doneAction:2);
		24.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*8,mul:1/amp),LFSaw.ar(1/amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/9,[-4,-4]),doneAction:2);
		24.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*9,mul:1/amp),LFSaw.ar(1/amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,pr,pass=1,n=1,b=0,sp=10000,a=4,f=20,l=440;
	var sig,x=0,amp=1,audio=0;
	var env,freq;

	    env=EnvGen.ar(Env.perc(a,8,pr/12,[-4,-4]),doneAction:2);
		24.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*12,mul:1/amp),LFSaw.ar(1/amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)
);

(

( Pdef(\1, Pbind(\instrument, \id1,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.5,1,inf),
	\a,Pbrown(0.01,2,0.1,inf),
	\f,Prand([60/2,80/2,90/2,120/2],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\2, Pbind(\instrument, \id2,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pbrown(0.01,2,0.1,inf),
	\f,Prand([60/2,80/2,90/2,120/2],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\3, Pbind(\instrument, \id3,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pbrown(0.01,2,0.1,inf),
		\f,Prand([60/2,80/2,90/2,120/2],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

( Pdef(\4, Pbind(\instrument, \id4,
	\dur,Pbrown(1,8,2,inf),
	\l,Pbrown(440,1200,100,inf),
		\pr,Pexprand(0.5,1,inf),
		\a,Pbrown(0.01,2,0.1,inf),
	\f,Prand([60/2,80/2,90/2,120/2],inf),
	\n,Pbrown(1,4,1,inf);)).play(quant:1));

);
(OSCdef(\amp1, { |msg|
	~a = msg[3];
	defer { ~v.animate=true; };
}, '/a', s.addr));
(OSCdef(\pitch1, { |msg|
	~b = msg[3];
//	defer { ~v.refresh };
}, '/b', s.addr));
(OSCdef(\amp2, { |msg|
	~c = msg[3];
	//defer { ~v.refresh; };
}, '/c', s.addr));
(OSCdef(\pitch2, { |msg|
	~d = msg[3];
	//defer { ~v.refresh };
}, '/d', s.addr));


(
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
~v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	~p1=Point.new(0,400);
1000.do{
		Pen.width=0.1;
		Pen.line(~p1,Polar.new(ray*~a,angle*~b).asPoint);Pen.stroke;
		Color(red:1,green:1,blue:0,alpha:1).set;
		Pen.line(~p1,Polar.new(ray*~c,angle*~d).asPoint);Pen.stroke;
			Color(red:1,green:0,blue:1,alpha:1).set;
		Pen.rotate(pi/2);Pen.stroke;
			x=x+1;
		y=(x+1)/x;
			angle=angle*y;

			};


};
~t.drawFunc ={
	Pen.translate(300,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points



};

)
)

///////////////////////////////////

////////////////////////////////////////