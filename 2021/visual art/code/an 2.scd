(
var w,v,hexa_points,radius;
var x_axis,y_axis,z_axis,circle;
var	r1,r2,r3,r4,r5,r6;
var  c_side_1,c_side_2,c_side_3,c_side_4,c_side_5,c_side_6;
var	p1_c,p2_c,p3_c,p4_c,p5_c,p6_c;
var  p1,p2,p3,p4,p5,p6;
var run = true, kapa, y, z,x=0,theta;
var ray=300;
var angle1=1,angle2=0;
var a=2;
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	~p1=Polar.new(100,pi).asPoint;
	~p2=Polar.new(100,pi/2).asPoint;
1000.do{
			x=x+1;
		y=((x**a)+a)/x;
		~k = Complex(x,y).angle;
			Pen.width=0.1;
			angle1=angle1+(~k**a);
		Pen.line(~p1,Polar.new(ray,angle1).asPoint);Pen.stroke;v.refresh;
			Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.rotate(pi/6);Pen.stroke;v.refresh;
			};
		Pen.width=1;
//	Color(red:0,green:1,blue:1,alpha:1).set;
	///////////////////////////////////////laterals
//	Pen.line(0@60,0@(-60));Pen.stroke;v.refresh;
//	Pen.line(-56@38,-56@(-38));Pen.stroke;v.refresh;
//	Pen.line(83@29,83@(-29));Pen.stroke;v.refresh;
//	////////////////////////////////////////horizontals
//    Pen.line(-56@38,0@(60));Pen.stroke;v.refresh;
//	Pen.line(-56@(-38),0@(-60));Pen.stroke;v.refresh;
//	Pen.line(83@29,0@(60));Pen.stroke;v.refresh;
//	Pen.line(83@(-29),0@(-60));Pen.stroke;v.refresh;
//	1000.do{
//			x=x+1;
//		y=((x**a)+a)/x;
//		~l = Complex(x,y).angle;
//			Pen.width=0.1;
//			angle1=angle1+(~l**a);
//		Pen.line(~p2,Polar.new(60,angle1).asPoint);Pen.stroke;v.refresh;
//			Color(red:1,green:1,blue:1,alpha:1).set;
//		Pen.rotate(pi/5);Pen.stroke;v.refresh;
//		};
};
{ while { run } {v.background_(Color.black); v.refresh; (1/10).wait } }.fork(AppClock);
)

~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az = vel.linlin(4,86,100,500)}, 71, 0);

MIDIClient.init;
MIDIIn.connectAll;
(
var w,v,hexa_points,radius;
var x_axis,y_axis,z_axis,circle;
var	r1,r2,r3,r4,r5,r6;
var  c_side_1,c_side_2,c_side_3,c_side_4,c_side_5,c_side_6;
var	p1_c,p2_c,p3_c,p4_c,p5_c,p6_c;
var  p1,p2,p3,p4,p5,p6;
var run = true, kapa, y, z,x=0,theta;
var ray=100;
var angle1=1,angle2=1,angle3=1,angle4=1;
var a=6;
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	~p1=Polar.new(600,pi).asPoint;
	~p2=Polar.new(800,pi).asPoint;
	~p3=Polar.new(900,pi).asPoint;
	~p4=Polar.new(1200,pi).asPoint;
1000.do{
			x=x+1;
		y=((x**a)+a)/x;
		~k = Complex(x,y).angle;
			Pen.width=0.1;
			angle1=angle1+(~k**6);
		angle2=angle1+(~k**8);
		angle3=angle1+(~k**9);
		angle4=angle1+(~k**12);
		Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.line(~p1,Polar.new(ray,angle1).asPoint);Pen.stroke;v.refresh;
		Pen.rotate(pi/6);Pen.stroke;v.refresh;
		Pen.line(~p2,Polar.new(ray,angle2).asPoint);Pen.stroke;v.refresh;
		Pen.rotate(pi/8);Pen.stroke;v.refresh;
		Pen.line(~p3,Polar.new(ray,angle3).asPoint);Pen.stroke;v.refresh;
		Pen.rotate(pi/9);Pen.stroke;v.refresh;
		Pen.line(~p4,Polar.new(ray,angle4).asPoint);Pen.stroke;v.refresh;
		Pen.rotate(pi/12);Pen.stroke;v.refresh;
			};
		Pen.width=1;

};
{ while { run } {v.background_(Color.black); v.refresh; (1/10).wait } }.fork(AppClock);
)

~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az = vel.linlin(4,86,100,500)}, 71, 0);

MIDIClient.init;
MIDIIn.connectAll;
