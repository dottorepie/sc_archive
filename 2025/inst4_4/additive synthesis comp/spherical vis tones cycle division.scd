


////////////////////////////////////////////static visualizer (rotated fixed pitches via golden ratio quaternion)


(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=1,m_y=1,m_z=1;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;


~az=[];~el=[];~magx=[];~magy=[];~magz=[];

		360.do{
azimuth=(12).collect{

		/*az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)*/

pl1=(pl1+1);
			az1 = (angle+((360/12)*pl1)).wrap(180.neg,180);  // Increment azimuth
			el1 = (angle+((180/12)*pl1)).wrap(90.neg,90);

		/*	az1 = (0+(90*pl1)).wrap(180.neg,180);
		el1 = (45*pl1).wrap(90.neg,90);
		pl1=(pl1+1).mod(25);*/

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

elevation=(12).collect{

		/*	az2 = (az2 + 3);  // Increment azimuth
        if (az2 > 180) { az2 = az2 - 360 };  // Wrap to [-180, 180)
        if (az2 <= -180) { az2 = az2 + 360 };  // Wrap to [-180, 180)

        el2 = (el2 + 3);  // Increment elevation
        if (el2 > 90) { el2 = el2 - 180 };  // Wrap to [-90, 90)
        if (el2 <= -90) { el2 = el2 + 180 };  // Wrap to [-90, 90)*/
pl2=(pl2+1);
				az2 = (angle+((360/12)*pl2)).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+((180/12)*pl2)).wrap(90.neg,90);
		/*	az2 = (0+(90*pl2)).wrap(180.neg,180);
		el2 = (45*pl2).wrap(90.neg,90);
		pl2=(pl2+1).mod(25);*/


		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

magnitudex=(12).collect{
		/*az3 = (az3 + 3);  // Increment azimuth
        if (az3 > 180) { az3 = az3 - 360 };  // Wrap to [-180, 180)
        if (az3 <= -180) { az3 = az3 + 360 };  // Wrap to [-180, 180)

        el3 = (el3 + 3);  // Increment elevation
        if (el3 > 90) { el3 = el3 - 180 };  // Wrap to [-90, 90)
        if (el3 <= -90) { el3 = el3 + 180 };  // Wrap to [-90, 90)*/
pl3=(pl3+1);
			az3 = (angle+((360/12)*pl3)).wrap(180.neg,180);  // Increment azimuth
			el3 = (angle+ ((180/12)*pl3)).wrap(90.neg,90);

		/*	az3 = (0+(90*pl3)).wrap(180.neg,180);
		el3 = (45*pl3).wrap(90.neg,90);
		pl3=(pl3+1).mod(25);*/

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

magnitudey=(12).collect{
		/*az4 = (az4 + 3);  // Increment azimuth
        if (az4 > 180) { az4 = az4 - 360 };  // Wrap to [-180, 180)
        if (az4 <= -180) { az4 = az4 + 360 };  // Wrap to [-180, 180)

        el4 = (el4 + 3);  // Increment elevation
        if (el4 > 90) { el4 = el4 - 180 };  // Wrap to [-90, 90)
        if (el4 <= -90) { el4 = el4 + 180 };  // Wrap to [-90, 90)
*/pl4=(pl4+1);

			az4 = (angle+((360/12)*pl4)).wrap(180.neg,180);  // Increment azimuth
			el4 = (angle+((180/12)*pl4)).wrap(90.neg,90);

		/*	az4 = (0+(90*pl4)).wrap(180.neg,180);
		el4 = (45*pl4).wrap(90.neg,90);
		pl4=(pl4+1).mod(25);*/

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(12).collect{
		/*az5 = (az5 + 3);  // Increment azimuth
        if (az5 > 180) { az5 = az5 - 360 };  // Wrap to [-180, 180)
        if (az5 <= -180) { az5 = az5 + 360 };  // Wrap to [-180, 180)

        el5 = (el5 + 3);  // Increment elevation
        if (el5 > 90) { el5 = el5 - 180 };  // Wrap to [-90, 90)
        if (el5 <= -90) { el5 = el5 + 180 };  // Wrap to [-90, 90)*/
pl5=(pl5+1);
			az5 = (angle+((360/12)*pl5)).wrap(180.neg,180);  // Increment azimuth
			el5 = (angle+((180/12)*pl5)).wrap(90.neg,90);
			//
			// az5 = (0+(90*pl5)).wrap(180.neg,180);
			// el5 = (45*pl5).wrap(90.neg,90);
			// pl5=(pl5+1).mod(25);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};
		pl1=0;pl2=0;pl3=0;pl4=0;pl5=0;
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
)

/////////////////////////////////visualizer
(
var data;
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(12).collect{

	az=~az.[pl].round(0.000001);
	el=~el.[pl].round(0.000001);
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;
		sph=Spherical(mag*800,az,el).asCartesian.asArray;
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





//////////////////////////////////////////////////////////////////////animation

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad;
var run = true;
var ot=0.degrad;

data = (360*12).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
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

		ot=ot+1.degrad;

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/1000).wait } }.fork(AppClock);

)
///////////////////////////////////////////rotation via quaternion

(
{
var m_x=1,m_y=1,m_z=1 ,az=0,el=0,sph_axis;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var axis=Quaternion(0,0,0,1);
var angle=(360-(360/1.6180339887499))/2;
var sph1,sph2,sph3,sph4,sph5,sph;
var rotation,v,v1,v2,v3,v4,v5;
var rotation1,rotation2,rotation3,rotation4,rotation5;

~az=[];~el=[];~magx=[];~magy=[];~magz=[];

 360.do{
		/*sph=Spherical(1,(az),(el));
		v=Quaternion(0, sph.x.round(0.000001), sph.y.round(0.000001), sph.z.round(0.000001));
		rotation=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v=rotation*v*rotation.conjugate;
		az=Cartesian(v.b,v.c,v.d).theta.round(0.000001);
		el=Cartesian(v.b,v.c,v.d).phi.round(0.000001);
		sph_axis=Quaternion(0,v.b,v.c,v.d);
		angle=(360-(360/1.6180339887499))/2;*/
		az=(az+(1)).wrap(180.neg,180);
	el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);
sph=Spherical(1,az.degrad,el.degrad);
	sph_axis=Quaternion(0,sph.x,sph.y,sph.z);

azimuth=(4).collect{

			pl1=(pl1+1);
			sph1=Cartesian(0,0,1);
			v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
			rotation1=((sph_axis*exp(Complex(0,1)*((pi/4)*pl1)).imag)+exp(Complex(0,1)*((pi/4)*pl1)).real);
		//	rotation1=(cos(((pi/12)*pl1).mod(2pi))+(sin(((pi/12)*pl1).mod(2pi))*sph_axis));
			v1=rotation1*v1*rotation1.conjugate;
			az1 = Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
			el1 =Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
			sph1=Spherical(1,az1,el1).theta.round(0.000001);
	};

elevation=(4).collect{

			pl2=(pl2+1);
		sph2=Cartesian(0,0,1);
			v2=Quaternion(0, sph2.x, sph2.y, sph2.z);
			rotation2=((sph_axis*exp(Complex(0,1)*((pi/4)*pl2)).imag)+exp(Complex(0,1)*((pi/4)*pl2)).real);
			v2=rotation2*v2*rotation2.conjugate;
			az2 = Cartesian(v2.b,v2.c,v2.d).theta.round(0.000001);
			el2 =Cartesian(v2.b,v2.c,v2.d).phi.round(0.000001);
			sph2=Spherical(1,az2,el2).phi.round(0.000001);
	};

magnitudex=(4).collect{

			pl3=(pl3+1);
			sph3=Cartesian(0,0,1);
			v3=Quaternion(0, sph3.x, sph3.y, sph3.z);
			rotation3=((sph_axis*exp(Complex(0,1)*((pi/4)*pl3)).imag)+exp(Complex(0,1)*((pi/4)*pl3)).real);
			v3=rotation3*v3*rotation3.conjugate;
			az3 = Cartesian(v3.b,v3.c,v3.d).theta.round(0.000001);
			el3 =Cartesian(v3.b,v3.c,v3.d).phi.round(0.000001);
			sph3=Spherical(1,az3,el3);
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
};
magnitudey=(4).collect{

			pl4=(pl4+1);
			sph4=Cartesian(0,0,1);
			v4=Quaternion(0, sph4.x, sph4.y, sph4.z);
			rotation4=((sph_axis*exp(Complex(0,1)*((pi/4)*pl4)).imag)+exp(Complex(0,1)*((pi/4)*pl4)).real);
			v4=rotation4*v4*rotation4.conjugate;
			az4 = Cartesian(v4.b,v4.c,v4.d).theta.round(0.000001);
			el4 =Cartesian(v4.b,v4.c,v4.d).phi.round(0.000001);
			sph4=Spherical(1,az4,el4);

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};
magnitudez=(4).collect{

			pl5=(pl5+1);
			sph5=Cartesian(0,0,1);
			v5=Quaternion(0, sph5.x, sph5.y, sph5.z);
			rotation5=((sph_axis*exp(Complex(0,1)*((pi/4)*pl5)).imag)+exp(Complex(0,1)*((pi/4)*pl5)).real);
			v5=rotation5*v5*rotation5.conjugate;
			az5 = Cartesian(v5.b,v5.c,v5.d).theta.round(0.000001);
			el5 =Cartesian(v5.b,v5.c,v5.d).phi.round(0.000001);
			sph5=Spherical(1,az5,el5);

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};
		~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;
		pl1=0;pl2=0;pl3=0;pl4=0;pl5=0;
	};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
)

/////////////////////////////////visualizer
(
var data;
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(360*4).collect{

	az=~az.[pl].round(0.000001);
	el=~el.[pl].round(0.000001);
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;
		sph=Spherical(mag*800,az,el).asCartesian.asArray;
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





//////////////////////////////////////////////////////////////////////animation

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad;
var run = true;
var ot=0.degrad;

data = (360*12).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
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

		ot=ot+1.degrad;

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/1000).wait } }.fork(AppClock);

)
