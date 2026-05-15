(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
)
(
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle = 0;

~tempoaz=0.1;
~tempoel=0.1;
~tempox=0.1;
~tempoy=0.1;
~tempoz=0.1;


~az =  Routine({
		loop{
		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el1=(el1+(1)).wrap(90.neg,90);
		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);
	//	"az".postln;
	//	sph1.postln;
		~controlBus_az.set(sph1);
	pl1=pl1+1;
	~tempoaz.wait;
}});

~el = Routine({
		loop{
		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el2=(el2+(1)).wrap(90.neg,90);
	sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);
		//	"el".postln;
	//	sph2.postln;
		~controlBus_el.set(sph2);
		pl2=pl2+1;
		~tempoel.wait;
}});

~magx = Routine({
		loop{
	az3=(az3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el3=(el3+(1)).wrap(90.neg,90);
	sph3=Spherical(1,(az3.degrad),(el3.degrad));	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
		mag_x=mag_x/(2.sqrt);
	//			"magx".postln;
	//	mag_x.postln;
		~controlBus_magx.set(mag_x);
		pl3=pl3+1;
		~tempox.wait;
}});

~magy = Routine({
		loop{
	az4=(az4+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el4=(el4+(1)).wrap(90.neg,90);
	sph4=Spherical(1,(az4.degrad),(el4.degrad));
	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
		mag_y=mag_y/(2.sqrt);
		//		"magy".postln;
	//	mag_y.postln;
		~controlBus_magy.set(mag_y);
			pl4=pl4+1;
		~tempoy.wait;
}});

~magz = Routine({
		loop{
pl5=pl5+1;
	az5=(az5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el5=(el5+(1)).wrap(90.neg,90);
		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
		mag_z=mag_z/(2.sqrt);
	//			"magz".postln;
	//	mag_z.postln;
		~controlBus_magz.set(mag_z);
				pl5=pl5+1;
		~tempoz.wait;
}});

)

(
~az.play;
~el.play;
~magx.play;
~magy.play;
~magz.play;
);

(

var data;
var az=0,el=0;
var m=600,sph,mag;
var run = true;
 var magX, magY ,magZ;
var generateData;
var r;
var ot=0.degrad;


//~angleRoutine1.play;
//~t.play;
//Synth(\ospace1);
//s.record(numChannels:4);
generateData =[[0,0,0]];

 w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;

 ~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
 a = ScatterView3d(~v, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
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
  r= Routine({loop{

	      az = ~controlBus_az.getSynchronous;    // Read from control buses
         el =  ~controlBus_el.getSynchronous;
mag=Cartesian(~controlBus_magx.getSynchronous, ~controlBus_magy.getSynchronous,~controlBus_magz.getSynchronous).rho/(2.sqrt);

	generateData =generateData++[ Spherical(mag*400,az,el).asCartesian.asArray];
	data = generateData.value; // Regenerate data
	//data.postln;
 	a.data = data;            // Update ScatterView3d
0.1.wait
}});
r.play;

 ~v.animate;
 ~v.drawFunc ={
 	Pen.translate(400,400);
          // Update ScatterView3d
		a.rot(ot,ot,ot);
    ~v.refresh;

		ot=ot+1.degrad;
 };
 { while { run } {~v.refresh; (0.05).wait } }.fork(AppClock);

)
(
~angleRoutine1.play;
~t.play;
)


(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
~controlBus_rotation_x = Bus.control(s, 1);
~controlBus_rotation_y = Bus.control(s, 1);
~controlBus_rotation_z = Bus.control(s, 1);
);

(

 // Initialize angle
var rotation,angle=(360-(360/1.6180339887499))/2,axis=Quaternion(0,0,0,1),sph,az=0,el=0,v,sph_axis,xx,yy,zz;

~tempo2=1;
~angleRoutine1 = Routine({

    loop {
			sph=Spherical(1,(az),(el));
		v=Quaternion(0, sph.x, sph.y, sph.z);
		rotation=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v=rotation*v*rotation.conjugate;
		az=Cartesian(v.b,v.c,v.d).theta.round(0.000001);
		el=Cartesian(v.b,v.c,v.d).phi.round(0.000001);
		sph_axis=Cartesian(v.b,v.c,v.d);
		xx=sph_axis.x;
		yy=sph_axis.y;
		zz=sph_axis.z;
			~controlBus_rotation_x.set(xx);
		~controlBus_rotation_y.set(yy);
		~controlBus_rotation_z.set(zz);
		(~tempo2).wait;
    };

});
);

(
var  sph1,m_x=1,m_y=1,m_z=1,n=0,rotation1;
var az1=0,el1=0,mag,mag_x,mag_y,mag_z,v1,sph_axis;
var angle=0;

~tempo=0.1;


~t =  Routine({
		loop{
		sph_axis=Quaternion(0,~controlBus_rotation_x.getSynchronous,~controlBus_rotation_y.getSynchronous,~controlBus_rotation_z.getSynchronous);
	sph1=Spherical(1,pi/2,0);
			v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
			rotation1=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(n/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(n/12)).mod(2pi)).real);
			v1=rotation1*v1*rotation1.conjugate;
			az1 = Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
			el1 =Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
		n=(n+1).mod(13);

	sph1=Spherical(1,(az1),(el1));

mag_x=(Complex(cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;
		/* mag_x=(Complex(cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph1.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph1.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;*/
		mag_x=mag_x/(2.sqrt);
mag_y=(Complex(sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph1.rho;
//		mag_y=(Complex(sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph1.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph1.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph1.rho;
		mag_y=mag_y/(2.sqrt);
	if(
m_z.even,
mag_z=Complex(cos((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph1.rho,
mag_z=Complex(sin((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph1.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph1.rho
	);
		mag_z=mag_z/(2.sqrt);


		~controlBus_az.set(sph1.theta.round(0.00001));
		~controlBus_el.set(sph1.phi.round(0.00001));
	~controlBus_magx.set(mag_x);
		~controlBus_magy.set(mag_y);
		~controlBus_magz.set(mag_z);
	~tempo.wait;
}});

);

