


(
var w,v,hexa_points,radius;
var x_axis,y_axis,z_axis,circle;
var	r1,r2,r3,r4,r5,r6;
var  c_side_1,c_side_2,c_side_3,c_side_4,c_side_5,c_side_6;
var	p1_c,p2_c,p3_c,p4_c,p5_c,p6_c;
var  p1,p2,p3,p4,p5,p6;
var run = true, kapa, y,y1, z,x=0,theta;
var ray=137.5, angle=ray.wrap(0,360);
var rad1=1,rad2=1;

///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(400,100,800,800),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
v.animate;
v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
	~p1=Polar.new(200,pi).asPoint;
1000.do{

			x=x+1;
		p1_c= (x+1)/x;

		ray=ray+137.5;
		angle=ray.wrap(0,360);
		y=exp(Complex(0,1)*angle);
		y1=exp(Complex(0,1)*angle);

			Pen.width=0.5;
			rad1=y.real*300;
		   rad2=y1.imag*300;

		Color(red:1,green:0.999.rand,blue:0.999.rand,alpha:0.999.rand).set;
		Pen.line(Polar.new(rad1*p1_c,y.theta).asPoint,Polar.new(rad2*p1_c,y1.theta).asPoint);
		Pen.rotate(pi/28);
		Pen.stroke;v.refresh;


			};

};
{ while { run } {v.background_(Color.black); v.refresh; (1/10).wait } }.fork(AppClock);
)