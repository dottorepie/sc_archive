(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=90.neg,az2=0,el2=90.neg,az3=0,el3=90.neg,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=90.neg,az5=0,el5=90.neg,az6=0,el6=90.neg,az7=0,el7=90.neg;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg,p1=0,p2=0;
var ellipsis=[1,1,1];
var spread=1,h=90.neg;

	~az=[];~el=[];~qx=[];~qy=[];

19.do{
azimuth=(19).collect{

		az1 = (p1).wrap(180.neg,180);  // Increment azimuth
				el1 = (h).wrap(90.neg,90);
p1=p1+20;
		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);
	};

elevation=(18).collect{

				az2 = (p2).wrap(180.neg,180);  // Increment elevation
			el2 = (h).wrap(90.neg,90);
p2=p2+20;
		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

////z axis   ambi..  sin for odd numbers, cos for even
	h=h+10;p1=0;p2=0;~az=~az++azimuth;~el=~el++elevation;	};

}.value;
)

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad;
var run = true;
var ot=0.degrad;

data = (19*18).collect{

	az=~az.[pl];
	el=~el.[pl];
	mag=1;
	//mag=(Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt))+(Cartesian(~qx.[pl],~qy.[pl],~magz.[pl]).rho/(2.sqrt));
	pl=pl+1;
		sph=Spherical(mag*600,az,el).asCartesian.asArray;



};

w = Window.new("3D Scatterplot", Rect(40,40, 800, 800)).front;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
a = ScatterView3d(~v, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

~v.animate;
~v.drawFunc ={
Pen.translate(400,400);

		a.rot(ot,ot,ot);
    ~v.refresh;

		ot=ot+0.5.degrad;

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/1000).wait } }.fork(AppClock);
)


(
var data;
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(360*8).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=
//(Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt))+
//	(Cartesian(~qx.[pl],~qy.[pl],~magz.[pl]).rho/(2.sqrt));
		Cartesian(~magx.[pl],~magy.[pl],0).rho;
	//	Cartesian(~qx.[pl],~qy.[pl],0).rho;
	pl=pl+1;
		sph=Spherical(mag*400,az,el).asCartesian.asArray;



};
data.postln;

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};

)

(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=0,az5=0,el5=0,az6=0,el6=0,az7=0,el7=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
	~dur=[];

durx=(360*8).collect{
			azx = (azx+1).wrap(180.neg,180);
				elx = (elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(360*8).collect{
		azy = (azy+1).wrap(180.neg,180);
			ely = (ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(360*8).collect{
			azz = (azz+1).wrap(180.neg,180);
				elz = (elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

~az=(360*8).collect{

			az1 = (az1+1).wrap(180.neg,180);
				el1 = (el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

~el=(360*8).collect{

				az2 = (az2+1).wrap(180.neg,180);
			el2 = (el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

~magx=(360*8).collect{

			az3 = (az3+1).wrap(180.neg,180);
			el3 = (el3+ (360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=(Spherical(1,(az3.degrad),(el3.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

	 mag_x=((Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
			(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

};

~magy=(360*8).collect{

			az4 = (az4+1).wrap(180.neg,180);
			el4 = (el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=(Spherical(1,(az4.degrad),(el4.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

		 mag_y=((Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		 (Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

};

	~qx=(360*8).collect{

			az5 = (az5+1).wrap(180.neg,180);
			el5 = (el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=(Spherical(1,(az5.degrad),(el5.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));


mag_qx=((((Complex(cos(((sph5.theta.round(0.00001))*mq).wrap(pi.neg,pi)),
cos(((sph5.theta.round(0.00001))*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph5.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph5.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph5.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph5.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);
	};

	~qy=(360*8).collect{

			az6 = (az6+1).wrap(180.neg,180);
			el6 = (el6+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph6=(Spherical(1,(az6.degrad),(el6.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

 mag_qy=((((Complex(sin(((sph6.theta.round(0.00001))*mq).wrap(pi.neg,pi)),
sin(((sph6.theta.round(0.00001))*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph6.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph6.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph6.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph6.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);
};

~magz=(360*8).collect{

			az7 = (az7+1).wrap(180.neg,180);
			el7 = (el7+(360-(360/1.6180339887499))).wrap(90.neg,90);

sph7=(Spherical(1,(az7.degrad),(el7.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2]));

if(
m_z.even,
mag_z=(Complex(cos((sph7.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph7.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread),
mag_z=(Complex(sin((sph7.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph7.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread)
	);
////z axis   ambi..  sin for odd numbers, cos for even

};

				360.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];}
}.value;
(
//~magx = ~magx.collect { |z| z / ~magx.maxItem };
//~magy = ~magy.collect { |z| z / ~magy.maxItem };
//~magz = ~magz.collect { |z| z / ~magz.maxItem };
 );
)