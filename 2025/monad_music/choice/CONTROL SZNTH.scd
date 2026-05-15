 (
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
Buffer.freeAll;
////////////////////////////////////speaker setup///other

	/*~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);*/


///////////////////////////////////////////////////////arrays

//////////////////////////////////////////////////basis
	////no0
	///Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])
	(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~azz=[];~ell=[];~durr=[];

		361.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(4,(azx.degrad),(elx.degrad))).x.round(1/8);

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(4,(azy.degrad),(ely.degrad))).y.round(1/8);

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(4,(azz.degrad),(elz.degrad))).z.round(1/8);

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))).phi.round(0.00001);

	};

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~azz=~azz++azimuth;~ell=~ell++elevation;

				12.do{ num=num+1; ~durr=~durr++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;
);

	////////////list
	({
		var n=1.neg;
		~list11=(360*12+1).collect{
		n=n+1;
		}
		}.value
	);

		({
		var n=1.neg;
		~list22=(360*12).collect{
		n=n+1;
		}
		}.value
	);

			({
		var n=0; ~listt=[];
		(360*12*10+1).do{ n=n+(10.reciprocal);
			~listt=~listt++~list11.[n];
	}}.value);

~listt=~listt.scramble;

/////synths////

		~controlBus_coordinate = Bus.control(s, 1);
			~controlBus_ripple = Bus.control(s, 1);


		(
SynthDef.new(\ocontrol, {
				arg lfo,spread=1,decay=8,cell=1,rot_angle=0,lfo2,mh=0,maxrange=1,freq=1,pl1=1,pl2=1,amp=1;
	var amp1,amp2,amp3,dist,harm;
	var ton1,ton2,ton3,sph,sph8;
	var pitch1,pitch2,pitch3,env,sig,n1,n2,n3;
	var magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;
	var m=3,mq=2,startloc,osc1,osc2,osc3,sphere;
	var mod_angle,mod_angle1,mod_angle2;
	var mag,q1,q2,ripple=0.01;
	var axis,i,j,k,coordinatesx,coordinatesy,coordinatesz,v,v1,qsphe;
	var ii,iii,jj,jjj,kk,kkk,axis1,axis2,axis3,v2,v3,mod_anglez;

	sph=Spherical(1,Select.kr(pl1,~azz),Select.kr(pl1,~ell));
	sph8=Spherical(1,Select.kr(Select.kr(pl2+1,~listt),~azz),Select.kr(Select.kr(pl2+1,~listt),~ell));
	mod_angle=SinOsc.ar(lfo,0.degrad).range(90.neg.degrad,90.degrad);
	mod_angle1=SinOsc.ar(lfo,90.degrad).range(90.neg.degrad,90.degrad);
	mod_anglez=SinOsc.ar(lfo,45.degrad).range(90.neg.degrad,90.degrad);

q1=Quaternion(0,sph.x,sph.y,sph.z); q2=Quaternion(0,sph8.x,sph8.y,sph8.z);
dist=q1.distance(q2);

				env=EnvGen.ar(Env.new([1,1],[decay*dist]),doneAction:2,levelScale:amp);

					(
		magx=((Complex(cos(((sph.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),cos((((sph.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magy=((Complex(sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),sin(((sph.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magz=((Complex(cos(((sph.phi+mod_anglez).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),cos(((sph.phi).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

magqx=((((Complex(cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi)),
cos(((sph.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

 magqy=((((Complex(sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi)),
sin(((sph.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

				mag_x=magx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);

						startloc=Complex(sph.theta.linlin(pi.neg,pi,1.neg,1),sph.phi.linlin((pi/2).neg,(pi/2),1.neg,1)).theta;
				mod_angle2=SinOsc.ar(lfo2,startloc).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones
			//mod_angle2=LFNoise1.ar(lfo2).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones

harm=((Complex(cos(((sph.phi+mod_angle2).round(0.00001)*mh).wrap((pi/2).neg,(pi/2))),cos(((sph.phi).round(0.00001)*mh).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

sphere=Spherical(24*harm,Select.kr(pl1,~azz),Select.kr(pl1,~ell));

n1=(sphere.x).round(0.00000001);n2=(sphere.y).round(0.00000001);n3=(sphere.z).round(0.00000001);
ton1 = 2.pow(n1 / 12);ton2 = 2.pow(n2 / 12);ton3 = 2.pow(n3 / 12);
//amp1=(ton1.reciprocal).round(0.00000001);amp2=(ton2.reciprocal).round(0.00000001);amp3=(ton3.reciprocal).round(0.00000001);

mag=(Cartesian(mag_x,mag_y,mag_z).rho)+(Cartesian(mag_qx,mag_qy,mag_z).rho);

				 /*v=Quaternion(0,sph.x,sph.y,sph.z);/// vector as quaternion

				 coordinatesx=[1,0,0].normalizeSum.sqrt;
				 coordinatesy=[0,1,0].normalizeSum.sqrt;
				 coordinatesz=[0,0,1].normalizeSum.sqrt;

				 i=Quaternion(0, coordinatesx.[0], 0, 0);j=Quaternion(0, 0, coordinatesx.[1], 0);k=Quaternion(0, 0, 0, coordinatesx.[2]);
				 ii=Quaternion(0, coordinatesy.[0], 0, 0);jj=Quaternion(0, 0, coordinatesy.[1], 0);kk=Quaternion(0, 0, 0, coordinatesy.[2]);
				 iii=Quaternion(0, coordinatesz.[0], 0, 0);jjj=Quaternion(0, 0, coordinatesz.[1], 0);kkk=Quaternion(0, 0, 0, coordinatesz.[2]);

				 axis1=(((i+j+k)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real); ////rotation vector with angle of rotatio and ijk xyz normalized components
				 v1=axis1*v*axis1.conjugate;

				 axis2=(((ii+jj+kk)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real);
				 v2=axis2*v1*axis2.conjugate;

				 axis3=(((iii+jjj+kkk)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real);
				 v3=axis3*v2*axis3.conjugate;

				 qsphe=Cartesian(v3.b,v3.c,v3.d).asSpherical;*/

/*osc1=VBAP.ar(4,SinOsc.ar(pitch1,mul:amp1*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
osc2=VBAP.ar(4,SinOsc.ar(pitch2,mul:amp2*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
osc3=VBAP.ar(4,SinOsc.ar(pitch3,mul:amp3*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));*/
				ripple=LFNoise1.kr(0.1).abs;
				Out.kr(~controlBus_ripple.index,ripple);

				osc1=SinOsc.kr(freq,mul:mag.wrap(0,1),phase:startloc).range(maxrange.neg,maxrange).round(1).abs.poll;
//osc2=SinOsc.kr(ton2*0.0001,mul:1,phase:startloc).range(0,maxrange).round(1);
//osc3=SinOsc.kr(ton3*0.0001,mul:1,phase:startloc).range(0,maxrange).round(1);

//Out.kr(~controlBus_coordinate.index,osc3*env);
//Out.kr(~controlBus_coordinate.index,osc2*env);
Out.kr(~controlBus_coordinate.index,osc1*env);


}).add;
);

			/*({
		var angle=0;
		~angle=(360*12).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);
*/


//////////pattern


	~bb=Pdef(\2, Pbind(\instrument, \ocontrol,
			\dur,Pseq(~durr.abs*2,inf),
			\pl1,Pseq(~listt,inf),    ///////coordinate selection
			\pl2,Pseq(~list22,inf),
			\lfo,Pbrown(0.000001,0.001,1,inf), /////mag spherical harmonic oscillation
		\lfo2,Pbrown(1,2,0.01,inf), /////tone spherical harmonic oscillation
		//\cell,Pbrown(0.01,1/4,0.1,inf), ///////speed of 4dimensional oscillation
		//\rot_angle,Pseq(~angle,inf),
		\maxrange,Prand(~list22,inf),
			\freq,0.0000001,
		\spread,Pbrown(0.1,2,1,inf),  //////spherical harmonic width
		\decay,Pbrown(4,8,1,inf),
				\amp,Pseq(~r,inf);///l system

));
	TempoClock.default.tempo_(2);
			s.scope;
}
)

(
~bb.play;
);

s.record(numChannels:4);

