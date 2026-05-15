TempoClock.default.tempo_(120/120);

(
var w,v;
var run = true;
var partial=100,radius;
(
SynthDef.new(\id, {
	arg dur=1;
	var x=1,y=1,t,z=1;
	var k=0, sig,sig1,env,env1,s;
	var sum=0,sum1=0;
2.do{
		dur=dur+1;
		z=((dur+1)/z);
	x=z.cos.abs; y=z.sin.abs;
	k=Complex(x,y).abs;
	t=Complex(x,y).angle.abs;
	env=EnvGen.ar(Env.perc(2,8,0.05/y,[-4,-2]),doneAction:2);
	env1=EnvGen.ar(Env.perc(0.01,8,0.05/x,[-4,-2]),doneAction:2);

	sig=FSinOsc.ar(x*1000,mul:env1,iphase:x*pi);
sig1=FSinOsc.ar(y*1001,mul:env,iphase:y*pi);
sum1=sum1+sig1; sum=sum+sig;
	};
	~a = Amplitude.ar(sum*env1, 0.01, 0.25);
	~b = Amplitude.ar(sum1*env, 0.01, 0.25);
		SendReply.ar(Impulse.ar(100), '/a', ~a);
	SendReply.ar(Impulse.ar(100), '/b', ~b);
		Out.ar(0,Rotate2.ar(sum*env1,sum1*env,LFSaw.ar(t)));

}).add;
);

( Pdef(\1, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(1,7,1,inf),
			)).play(quant:1));

OSCdef(\amp1, { |msg|
	~a = msg[3];
	defer { ~v.refresh };
}, '/a', s.addr);

OSCdef(\amp2, { |msg|
	~b = msg[3];
	defer { ~v.refresh };
}, '/b', s.addr);

    Window.closeAll;
    w = Window("S",Rect( 600,100,2000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
	//~slider1= Slider(w,Rect(500,940,850,10)).action_({ arg obj; ~z = obj.value.linlin(0,1,1,3600); ~v.refresh;});
~v = UserView.new(w,Rect(50,100,1800,800)).background_(Color.black);
~v.drawFunc ={
	~a=~a*1000;~v.refresh;
	~b=~b*1000;~v.refresh;
	Pen.translate(900,400);
	(partial).do{
	//~x=~a.cos; ~y=~a.sin;
			~k=Polar.new(~a,2*pi).asPoint;~v.refresh;
		~t=Polar.new(~b,pi).asPoint;~v.refresh;
			Pen.width=0.1;
		Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.line(~k,~t);Pen.stroke;~v.refresh;
	//	Pen.line(~a,Polar.new(~z,~y).asPoint);Pen.stroke;~v.refresh;
		Pen.rotate(pi/(partial/2));Pen.stroke;~v.refresh;
			};
};
//{ while { run } {~v.background_(Color.black); ~v.refresh; (1/10).wait } }.fork(AppClock);
~v.background_(Color.black);~v.refresh;
)



//////////////////////////////////////////////////////////////
(
    ~i = Image.fromWindow(~v);
~i.dump;
~i.write("~/Desktop/my_image.png".standardizePath);
~i.free;
)
