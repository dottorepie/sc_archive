(
var w,v,hexa_points,radius;
var x_axis,y_axis,z_axis,circle;
var	r1,r2,r3,r4,r5,r6;
var  c_side_1,c_side_2,c_side_3,c_side_4,c_side_5,c_side_6;
var	p1_c,p2_c,p3_c,p4_c,p5_c,p6_c;
var  p1,p2,p3,p4,p5,p6;
var run = true, kapa, y, z,x=0,theta;
var ray2=100,ray1=100;
var angle1=1,angle2=0;
var a=3;
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
	env=EnvGen.ar(Env.perc(0.01,8,0.05/y,[-4,-2]),doneAction:2);
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
~slider1 = Slider(w, Rect(200,900,600,10)).action_({ arg obj;~brightness = obj.value.linlin(0,1,0.01,1);v.refresh;});
v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	~p1=Polar.new(300,2pi).asPoint;
	//	~p2=Polar.new(100,pi/2).asPoint;
	//~p3=Polar.new(200,pi).asPoint;
100.do{
			x=x+1;
		y=(x.squared+a)/x.squared;
			kapa = Complex(x,y).abs;
			z= (kapa+a)/kapa;
			r=Complex(z,kapa).abs;

		3.do{
			Pen.width=0.5;
			angle1=angle1+r;
			Color(red:1,green:1,blue:1,alpha:~brightness).set;
			Pen.line(~p1,Polar.new((~a*10000),angle1).asPoint);Pen.stroke;v.refresh;
			//Pen.line(~p2,Polar.new((r*ray1),theta+angle1).asPoint);Pen.stroke;v.refresh;
			//Pen.line(~p3,Polar.new((r*ray2),theta+angle2).asPoint);Pen.stroke;v.refresh;
			Pen.rotate(pi/a);
			};
			//   10.do{
		//	Pen.width=r;
		//	Color(red:0,green:0,blue:0,alpha:~brightness).set;
       //      Pen.line(~p1,~p2);Pen.stroke;v.refresh;
		//	 Pen.line(~p2,~p3);Pen.stroke;v.refresh;
			//Pen.addRect(Rect(~p1,~p2,ray1,ray2));Pen.stroke;v.refresh;
			//	Pen.rotate(pi/factor);
			//	};

};
};
{ while { run } {v.background_(Color.black); v.refresh; 0.0001.wait } }.fork(AppClock)
)