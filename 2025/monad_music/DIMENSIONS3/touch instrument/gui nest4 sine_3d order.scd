(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*2;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(1);
s.options.memSize = 8192*4*2;
s.options.blockSize = 64*2;
s.options.maxNodes = 1024 * 4;
s.options.sampleRate= 44100;
);

s.waitForBoot{

Buffer.freeAll;

////////////////////////////////////speaker setup///other

	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);



	////no0
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
var ellipsis=[1,1,1];
var spread=1;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];

		360.do{


azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};


};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;


}.value;
);


/////synth////
	(
		(
SynthDef.new(\ospace, {
	arg gain=1, lfo_amp=1, azimuth, elevation, spread=1, ripple=1,amount=1;
	var amp1,amp2,amp3,octave=1,multiplier=64,center=1800;////343speed of sound/1800hz= 0.1905 aproximate head diameter
	var osc4,osc5,osc6,osc7,osc8,osc9,amp4,amp5,amp6,amp7,amp8,amp9;
	var pitch4,pitch5,pitch6,pitch7,pitch8,pitch9;
	var ton1,ton2,ton3,sph3,sph4,sph5,sph6,sph7;
	var freq1,freq2,freq3,pitch1,pitch2,pitch3,env,sig,n1,n2,n3;
	var magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;
	var ratio1,ratio2,ratio3,m=3,mq=2,phase,osc1,osc2,osc3,sphere;
	var scale,nn=29.neg,nnn=15.neg,scale_coo;
	var ampx,ampy,ampz,mod_angle,mod_angle1;
	var ellipsis=[1,1,1],mag,magxx;
	var waveSpeed = 1, waveFreq = 4, theta,phi,wave,t,scalar;
	var fundamental;
	var freq,mod_angle0,amp=5;

waveFreq=amount.lag(0.01);
t=SinOsc.kr(ripple.lag(0.01)).range(1, 100);
mod_angle=SinOsc.ar(lfo_amp.lag(0.01),0.degrad,mul:1).range(90.neg.degrad,90.degrad);
mod_angle1=SinOsc.ar(lfo_amp.lag(0.01),90.degrad,mul:1).range(90.neg.degrad,90.degrad);

		sph3=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
		sph4=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
		sph5=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
					sph6=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));
		sph7=Spherical(1,azimuth.lag(0.01),elevation.lag(0.01));

(
magx=((Complex(cos(((sph3.theta+mod_angle).round(0.00001)*m).wrap(pi.neg,pi)),
						cos((((sph3.theta+mod_angle).round(0.00001)*m)).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
	(Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
						cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magy=((Complex(sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi)),
						sin(((sph4.theta+mod_angle1).round(0.00001)*m).wrap(pi.neg,pi))).rho/(2.sqrt)).pow(spread)*
		(Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
						cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread);
				);

magz=((Complex(cos(((sph5.phi+mod_angle).round(0.00001)*m).wrap((pi/2).neg,(pi/2))),
						cos(((sph5.phi+mod_angle1).round(0.00001)*m).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

magqx=((((Complex(cos(((sph5.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi)),
cos(((sph5.theta.round(0.00001)+mod_angle)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph5.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph5.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph5.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph5.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

 magqy=((((Complex(sin(((sph6.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi)),
sin(((sph6.theta.round(0.00001)+mod_angle1)*mq).wrap(pi.neg,pi))))*
(Complex(sin((sph6.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2))),
sin((sph6.phi.round(0.00001)*(mq-1)).wrap((pi/2).neg,(pi/2)))))*
(Complex(cos((sph6.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),
cos((sph6.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))))))).rho/(2.sqrt)).pow(spread);

 theta = azimuth.lag(0.01).degrad;
  phi = elevation.lag(0.01).degrad;
	 wave = amp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
  magxx=  magx * wave;

				mag_x=magxx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);
scale=57.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};

fundamental=(center);

freq=(fundamental*octave);

sphere=Spherical(28,azimuth.lag(0.01),elevation.lag(0.01));

n1=(sphere.x).round(0.00000001); n2=(sphere.y).round(0.00000001); n3=(sphere.z).round(0.00000005);

//ton1=n1.abs;ton2=n2.abs;ton3=n3.abs;
//ton1=2.pow(n1.round(1)/12);ton2=2.pow(n2.round(1)/12);ton3=2.pow(n3.round(1)/12);

ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);

ton1 = 2.pow(Select.kr(ratio1.linlin(28.neg, 28, 0, 56), scale) / 12);
ton2 = 2.pow(Select.kr(ratio2.linlin(28.neg, 28, 0, 56), scale) / 12);
ton3 = 2.pow(Select.kr(ratio3.linlin(28.neg, 28, 0, 56), scale) / 12);

	amp1=(ton1.reciprocal*octave.reciprocal).round(0.00000001);
	amp2=(ton2.reciprocal*octave.reciprocal).round(0.00000001);
	amp3=(ton3.reciprocal*octave.reciprocal).round(0.00000001);

	pitch1=(freq*ton1).round(0.0000001);pitch2=(freq*ton2).round(0.0000001);pitch3=(freq*ton3).round(0.0000001);
		mag=(Cartesian(mag_x,mag_y,mag_z).rho/(2.sqrt))+(Cartesian(mag_qx,mag_qy,mag_z).rho/(2.sqrt));

osc1=VBAP.ar(4,SinOsc.ar(pitch1+mag_x,mul:amp1*mag,phase:0),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);
osc2=VBAP.ar(4,SinOsc.ar(pitch2+mag_y,mul:amp2*mag,phase:0),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg);
osc3=VBAP.ar(4,SinOsc.ar(pitch3+mag_z,mul:amp3*mag,phase:0),~b.bufnum,sphere.theta.raddeg,sphere.phi.raddeg
		);

				Out.ar(0,LeakDC.ar(osc3,mul:gain*0.01));
					Out.ar(0,LeakDC.ar(osc2,mul:gain*0.01));
					Out.ar(0,LeakDC.ar(osc1,mul:gain*0.01));

}).add;
);
);


(

Window.closeAll;
w=Window.new("gui",Rect.new(100,100,800,600)).front.alwaysOnTop_(true);

~aa = Slider.new(w.view,Rect.new(20,20,500,30));

~bb = Slider.new(w.view,Rect.new(20,60,500,30));

~cc = Slider2D.new(w.view,Rect.new(60,280,600,300));


~ee = Slider.new(w.view,Rect.new(20,140,500,30));

~ff = Slider.new(w.view,Rect.new(20,180,500,30));

~gg = Slider.new(w.view,Rect.new(20,220,500,30));

~on = Button(w,Rect(10,500,30,30)).states_([
			["off",Color.black,Color.gray],["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\ospace,[
	\gain,~aa.value,
	\lfo_amp,~bb.value.linlin(0,1,0.01,20).round(1/32),
	\spread,~ee.value.linlin(0,1,1,20),
	\ripple,~ff.value.linlin(0,1,0.0001,0.5),
	\amount,~gg.value.linlin(0,1,1,100).round(1),
\elevation,~cc.x.linlin(0,1,180.neg.degrad,180.degrad),
	\azimuth,~cc.y.linlin(0,1,90.neg.degrad,90.degrad)]).register},
		{~synth.free}
)});
(
a = StaticText(w, Rect(530,20,200, 20));
a.string = "gain";
b = StaticText(w, Rect(530,60,200, 20));
b.string = "spherical harmonic amp lfo";
d = StaticText(w, Rect(530,140,200, 20));
d.string = "spherical harmonic width";
e = StaticText(w, Rect(530,180,200, 20));
e.string = "ripple speed";
f = StaticText(w, Rect(530,220,200, 20));
f.string = "ripple waves";
g = StaticText(w, Rect(670,400,100, 70));
g.string = "3d tone coordinate (x_azimuth,
y_elevation)";
);

(
~aa.value_(1).action_({
	arg obj;
					var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain,gain)});
});
);
(
~bb.value_(1).action_({
	arg obj;
			var lfo_amp;
	lfo_amp=obj.value.linlin(0,1,0.01,20).round(1/32);
				lfo_amp.value.postln;
		if(~synth.isPlaying,{~synth.set(\lfo_amp,lfo_amp)});
});
);
(
~cc.action_({
	arg obj;
			var az,el;
	az=obj.x.linlin(0,1,180.neg.degrad,180.degrad);
	el=obj.y.linlin(0,1,90.neg.degrad,90.degrad);
			if(~synth.isPlaying,{~synth.set(\azimuth,az,\elevation,el)});
});
);
(
~ee.action_({
	arg obj;
			var spread;
			spread=obj.value.linlin(0,1,1,20);
				spread.value.postln;
if(~synth.isPlaying,{~synth.set(\spread,spread)});
});
);
	(
~ff.action_({
	arg obj;
			var ripple;
			ripple=obj.value.linlin(0,1,0.0001,0.5);
				ripple.value.postln;
if(~synth.isPlaying,{~synth.set(\ripple,ripple)});
});
);
			(
~gg.action_({
	arg obj;
			var amount;
				amount=obj.value.linlin(0,1,1,100).round(1);
				amount.value.postln;
if(~synth.isPlaying,{~synth.set(\amount,amount)});
});
);
	);
	//s.meter;
}
)

