(
s.waitForBoot({
	var w,v;
var run = true;
var partial=2000;
m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

SynthDef.new(\id, {
	arg dur=1;
	var t,env1;
	var k=0; var sig,sig1,env,s;

	~x=dur.cos.abs; ~y=dur.sin.abs;
	k=Complex(~x,~y).abs;
	t=Complex(~x,~y).angle;
	env=EnvGen.ar(Env.perc(1,4,k/~y,[-4,-2]),doneAction:2);
		env1=EnvGen.ar(Env.perc(1,4,k/~x,[-4,-2]),doneAction:2);
	sig=FSinOsc.ar(~x*880,mul:env1,iphase:~x*pi);
sig1=FSinOsc.ar(~y*881,mul:env,iphase:~y*pi);

		Out.kr(0,~x);// impulse argument tells how often to update the display
		Out.kr(0,~y);
	Out.ar(0,Rotate2.ar(sig*env,sig1*env,t));
}).add;


  Window.closeAll;
    w = Window("S",Rect( 600,100,2000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
~v = UserView.new(w,Rect(50,100,1800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(900,400);

	(partial).do{
	///~x=~z.cos; ~y=~z.sin;
			~k=Polar.new(In.kr(0)*400,2pi).asPoint;~v.refresh;
		~a=Polar.new(In.kr(1)*400,2pi).asPoint;~v.refresh;
			Pen.width=0.1;
		Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.line(~k,~a);Pen.stroke;~v.refresh;
		Pen.rotate(pi/(partial/2));Pen.stroke;~v.refresh;
			};
};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/10).wait } }.fork(AppClock);
//~v.background_(Color.black);~v.refresh;

	 Pdef(\1, Pbind(\instrument, \id,
	//\dur,5;
	\dur,Pbrown(4,5,9/8,inf),
			)).play

});
)