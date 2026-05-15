(
r = Routine({
	loop({~magx.choose.yield })
});
r.randSeed = 1;
)
// using the routine to fill an array
Array.fill(2, r);

// setting the random generator seed back to our initial seed
r.randSeed = 1;

// causes this array to be identical
Array.fill(2, r);

(
var c,cc,angle=0,c_real,c_imag,z;
var c1,cc1,angle1=0,c_real1,c_imag1,z1;



~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real,c_imag);
 };
z=Complex(0,0);

~j = (360*200).collect{
	cc=~c.[4];
	z=z.pow(2)+cc;
	z.theta.round(0.0000000000001);

};

~k = 5.collect{
 	c_real1=exp(Complex(0,1)*angle1.degrad).real;
	c_imag1=exp(Complex(0,1)*angle1.degrad).imag;
 	angle1=(angle1+45).wrap(0,360);
 	c1=Complex(c_real,c_imag);
 };
z1=Complex(0,0);

~h = (360*200).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

)

(
var  sph1,sph2,sph3,sph4,sph5,m_x=1,m_y=1,m_z=1;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (360*100).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.00001);

	};

~el = (360*100).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.00001);

	};

~magx = (360*100).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);
	mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
	Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4

/*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
2).neg,(pi/2)))).rho*
Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
	*/
	///x axis   ambi/// for order0 for sphere phi*0 else torus, same in y
};

~magy = (360*100).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
/////y axis  ambi

//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (360*100).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
)

	///////////////////////////////////
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 )

(
var data;
var az=0,el=0;
var m=600,sph,pl=0,mag;
var r1,harm1,r2,harm2,rad;

data = (360*32).collect{

az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;

	sph=Spherical(mag*800,az,el).asCartesian.asArray;

};

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

/////////////////////////////////choas

(
var data;
var az=0,el=0,mag=0;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,r,d,m=1,rot,sph,pl=0,daz,del,harm,daz1;

r=[0,0,1];
v=Quaternion(0,r.[0],r.[1],r.[2]);
angle=(360-(360/1.6180339887499));

data = (360*10).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magx.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho;
	pl=pl+1;


	sph=Spherical(1,az,el).asCartesian;

	rot=[sph.x,sph.y,sph.z];

	i=Quaternion(0, rot.[0], 0, 0);
	j=Quaternion(0, 0, rot.[1], 0);
	k=Quaternion(0, 0, 0, rot.[2]);

q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	    v=q*v*q.conjugate;

	daz=Cartesian(v.b.round(0.0001),v.c.round(0.0001),v.d.round(0.0001)).theta;

	del=Cartesian(v.b.round(0.0001),v.c.round(0.0001),v.d.round(0.0001)).phi;

	harm=Spherical(mag,daz,del).asCartesian.asArray


};

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
