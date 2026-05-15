(
var w,v,hexa_points,radius;
var run = true;
var angle=1;
var a=1,r=0;
var partial=1000;
///////0/////////////////////////////////////////////////////////////////////////////////////////////////
    Window.closeAll;
    w = Window("S",Rect( 600,100,2000,1000),scroll:false).front.alwaysOnTop_(true);
    w.alpha = 1;  w.view.background = Color.black;
	~slider1= Slider(w,Rect(500,940,850,10)).action_({ arg obj; ~x = obj.value.linlin(0,1,1,3600); ~v.refresh;});
~slider2= Slider(w,Rect(500,950,850,10)).action_({ arg obj; ~y = obj.value.linlin(0,1,1,360); ~v.refresh;});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////view
~v = UserView.new(w,Rect(50,100,1800,800)).background_(Color.black);
~v.drawFunc ={
	Pen.translate(900,400);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////lines
	(partial).do{
		~k=Polar.new(~x,pi/~y).asComplex.abs;~v.refresh;
		~a=Polar.new(~x,pi/~y).asComplex.angle;~v.refresh;
			//	~k=Complex(~x,~y).abs;
           //    ~a=Complex(~x,~y).angle;
			~z=(((~k)+~a))/(~k);
		~angle=Complex(~z,~k).angle;
		~radius=Complex(~z,~k).abs;
			Pen.width=0.5;
		Color(red:1,green:1,blue:1,alpha:1).set;
		Pen.line(~p1,Polar.new(~radius,~angle).asPoint);Pen.stroke;~v.refresh;
		Pen.rotate(pi/(partial/2));Pen.stroke;~v.refresh;
			};
////////////////////////////////////////////////////////////////////////////////
};
//{ while { run } {v.background_(Color.black); v.refresh; (1/10).wait } }.fork(AppClock);
~v.background_(Color.black);~v.refresh;
)



(
    ~i = Image.fromWindow(~v);
~i.dump;
~i.write("~/Desktop/my_image.png".standardizePath);
~i.free;
)

