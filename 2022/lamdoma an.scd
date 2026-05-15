








(
var w,run = true, kapa, y1=1,x=0,y2=1;
var ray=1000;
var angle=1;
var a=1000;
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
~v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
		~p1=Polar.new(560,pi).asPoint;

1000.do{
		Pen.width=0.1;
		Pen.line(~p1,Polar.new(ray*y1,angle*y1).asPoint);Pen.stroke;
			Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.rotate(pi/100);Pen.stroke;
			x=x+1;
		y1=a/(x+a);
		y2=(x+a)/a;
			};

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/10).wait } }.fork(AppClock);
)

/////////////



(
var w,run = true, kapa, y1=1,x=0,y2=1;
var ray=1000;
var angle=1;
var a=1;
var an1=180,an2=180,pan1=an1.wrap(0,360),pan2=an2.wrap(0,360);
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
~v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
		~p1=Polar.new(400,pi).asPoint;

1000.do{
		Pen.width=0.1;
		Pen.line(Polar.new(pan2,pan2.degrad).asPoint,Polar.new(pan1,pan1.degrad).asPoint);Pen.stroke;
			//Pen.quadCurveTo(Point.new(pan1,pan2),Point.new(pan2,pan1));Pen.stroke;
			Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.rotate(pi/100);Pen.stroke;
			//Pen.line(Polar.new(pan1,pan1.degrad).asPoint,Polar.new(pan2,pan2.degrad).asPoint);Pen.stroke;
			//Pen.quadCurveTo(Point.new(pan1,pan2),Point.new(pan2,pan1));Pen.stroke;
			Color(red:1,green:1,blue:1,alpha:1).set;
		//Pen.rotate(pi/y1*1);Pen.stroke;
			x=x+1;
		y1=a/(x+a);
		y2=(x+a)/a;


		an1=an1-137.5;
		an2=an2+137.5;
		pan1=an1.wrap(0,360);
		pan2=an2.wrap(0,360);

			};

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/10).wait } }.fork(AppClock);
)

/////////////////////////////////////////////////////////////
(
var w,run = true, kapa, y1=1,x=0;
var ray=1000;
var angle=1;
var a=1;
var an=0,pan=an.wrap(0,360),pa=Complex.new(0,1);
///////0//////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect(600,100,1000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////waves_radius
~v = UserView.new(w,Rect(100,100,800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(400,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////points
		~p1=Polar.new(400,pi).asPoint;

10000.do{
		Pen.width=0.1;
		Pen.line(Point.new(pa.real*400,pa.imag*400),Polar.new(400,pa.theta).asPoint);Pen.stroke;
		//Pen.quadCurveTo(~p1,Polar.new(400*y,pa.theta).asPoint);Pen.stroke;
			Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.rotate(pi/100);Pen.stroke;
		//	Pen.line(Polar.new(pan1,pan1.degrad).asPoint,Polar.new(pan2,pan2.degrad).asPoint);Pen.stroke;
			//Pen.quadCurveTo(Point.new(pan1,pan2),Point.new(pan2,pan1));Pen.stroke;
			//Color(red:1,green:1,blue:1,alpha:1).set;
		//Pen.rotate(pi/y1*1);Pen.stroke;
			x=x+1;
		y=(x+a)/a;


		 an=an+137.5;
		pan=an.wrap(0,360);
		pa=exp(Complex.new(0,1)*pan);


			};

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/100).wait } }.fork(AppClock);
)







