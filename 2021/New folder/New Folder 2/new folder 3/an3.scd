(
var w,v,hexa_points,radius;
var x_axis,y_axis,z_axis,circle;
var	r1,r2,r3,r4,r5,r6;
var  c_side_1,c_side_2,c_side_3,c_side_4,c_side_5,c_side_6;
var	p1_c,p2_c,p3_c,p4_c,p5_c,p6_c;
var  p1,p2,p3,p4,p5,p6;
var run = true, kapa, y, z,x=0,theta;
var ray=100;
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
	~p1=Polar.new(200,pi).asPoint;
	~dur=1;
1000.do{
			~dur=~dur+1;
		~z=~dur/(~dur+1);
	~x=~z.cos; ~y=~z.sin;
			~c=Complex(~x,~y);
	~f = Complex(0,0).squared+~c;
			Pen.line(~p1,~f.asPoint);Pen.stroke;v.refresh;
		~f=(~f.squared)+~c;
			Pen.width=0.1;
		Pen.line(~p1,~f.asPoint);Pen.stroke;v.refresh;
			Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.rotate(pi/16);Pen.stroke;v.refresh;
			};

};
{ while { run } {v.background_(Color.black); v.refresh; (1/10).wait } }.fork(AppClock);
)