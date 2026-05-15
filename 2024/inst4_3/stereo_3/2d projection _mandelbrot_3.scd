(
		~time=32;
{
var c,cc,angle=0,c_real,c_imag,z;
var c1,cc1,angle1=0,c_real1,c_imag1,z1;

~c = 5.collect{
 	c_real=exp(Complex(0,1)*angle.degrad).real;
	c_imag=exp(Complex(0,1)*angle.degrad).imag;
 	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
 	c=Complex(c_real.round(0.000001),c_imag.round(0.000001));
 };
z=Complex(0,0);

~j = (2*720*~time).collect{
	cc=~c.[4];
	z=z.pow(2)+cc;
	z.theta.round(0.0000000000001);

};

~k = 5.collect{
 	c_real1=exp(Complex(0,1)*angle1.degrad).real;
	c_imag1=exp(Complex(0,1)*angle1.degrad).imag;
 	angle1=(angle1+45).wrap(0,360);
 	c1=Complex(c_real1.round(0.000001),c_imag1.round(0.000001));
 };
z1=Complex(0,0);

~h = (2*720*~time).collect{
	cc1=~k.[4].round(0.0000000000001);
	z1=z1.pow(2)+cc1;
	z1.theta.round(0.0000000000001);

}

		}.value;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (720*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad*~h.[pl1]).wrap(pi.neg,pi),(el1.degrad*~j.[pl1]).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (720*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad*~h.[pl2]).wrap(pi.neg,pi),(el2.degrad*~j.[pl2]).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};
}.value;

)



(
var phase1,phase2,pl1=1.neg,pl2=1.neg;

~posL=(720*~time).collect{

	pl1=pl1+1;
	phase1=exp(Complex(0,1)*(~az.[pl1])).real.round(0.000001);

};

~posR=(720*~time).collect{

	pl2=pl2+1;
	phase2=exp(Complex(0,1)*(~el.[pl1])).imag.round(0.000001);
};

)



/*(
var phase1,phase2,angle1=0,angle2=0,m=2,pl1=0,pl2=0;

~posL=1440.collect{

	phase1=exp(Complex(0,1)*(angle1.degrad*~j.[pl1])).theta;
	pl1=pl1+1;
	angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	phase1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

};

~posR=1440.collect{

	phase2=exp(Complex(0,1)*(angle2.degrad*~j.[pl2])).theta;
	pl2=pl2+1;
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

	phase2=(Complex(exp(Complex(0,1)*(phase2.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase2.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase2.round(0.0001)*m)).real,exp(Complex(0,1)*(phase2.round(0.0001)*m)).real).rho).round(0.0001).neg;
};

)*/
(
var phase,angle=0,mag,phase1,angle1=0,mag1,m=2,pl1=0,pl2=0;

~magL = (720*~time).collect{

	phase=Complex(exp(Complex(0,1)*(~az.[pl1])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl1])).imag.round(0.000001)).theta;

	pl1=pl1+1;

	mag=(Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase.round(0.0001)*m)).real,exp(Complex(0,1)*(phase.round(0.0001)*m)).real).rho).round(0.0001);

	};

~magR = (720*~time).collect{

	phase1=Complex(exp(Complex(0,1)*(~az.[pl2])).real.round(0.000001),exp(Complex(0,1)*(~el.[pl2])).imag.round(0.000001)).theta;
	pl2=pl2+1;

		mag1=(Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag,exp(Complex(0,1)*(phase1.round(0.0001)*m)).imag).rho.round(0.0001)
		*Complex(exp(Complex(0,1)*(phase1.round(0.0001)*m)).real,exp(Complex(0,1)*(phase1.round(0.0001)*m)).real).rho).round(0.0001);

	};
)


///////2d

(
var data;
var az=0,el=0,aa,bb,p,pos;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad,sph1;

data = (720*16).collect{


	aa=~posL.[pl];
	bb=~posR.[pl];

	p=Point(aa,bb).theta;
	mag=Complex(~magL.[pl]/(2.sqrt),~magR.[pl]/(2.sqrt)).rho/(2.sqrt);
	pl=pl+1;

	sph=Polar(mag*800,p);
	sph1=Cartesian(sph.x,sph.y,0).asArray;


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

