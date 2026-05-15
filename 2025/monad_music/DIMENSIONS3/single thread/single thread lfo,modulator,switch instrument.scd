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

	////bpf sources
//	~c1 = Buffer.readChannel(s,"/home/pett/Desktop/0.wav",channels:0 );
//	~c2 = Buffer.readChannel(s,"/home/pett/Desktop/1.wav",channels:0 );
////	~c3 = Buffer.readChannel(s,"/home/pett/Desktop/2.wav",channels:0 );
//	~c4 = Buffer.readChannel(s,"/home/pett/Desktop/3.wav",channels:0 );
//	~c5 = Buffer.readChannel(s,"/home/pett/Desktop/4.wav",channels:0 );

////////////////////////////////////speaker setup///other
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);

////wavetable
	~t= Buffer.alloc(s,2048);
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;

	/////angle
		({
		var angle=0;
		~angle=(361).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	);
//~az=MouseX.kr(pi.neg,pi);~el=MouseY.kr((pi/2).neg,(pi/2));
	///thread
(SynthDef.new(\ospace, {

					////controls
	arg	amp=1,az=0,el=0,lfo=0.1,spread=1,ripple=0.1,waveFreq=5,rotation=0,coo=0,cell=0.1,lamdoma2=1,lamdoma1=1,mh=1,lfo2=0.1,octave=1,switch1=0,switch2=0,switch3=0;
			//~buf=0;~rq=0.00001;
		var amp1,amp2,amp3,center=1800/2,pitch4,pitch5,pitch6,pitch7,pitch8,pitch9,dist,harm,rot_angle=Select.kr(rotation,~angle);
	var ton1,ton2,ton3,fundamental,sph,sph8,varamp=5,freq1,pitch1,pitch2,pitch3,env,n1,n2,n3,magx,magy,magz,mag_x,mag_y,mag_z,magqx,magqy,mag_qx,mag_qy;
	var ratio1,ratio2,ratio3,m=3,mq=2,phase,osc1,osc2,osc3,sphere,scale,nn=29.neg,nnn=15.neg,nnnn=15.neg,scale_coo,sig;
	var mod_angle,mod_angle1,mod_angle2,mod_anglez,mag,magxx,q1,q2,waveSpeed = 1, theta,phi,wave,t,scalar,l1,l2;
	var axis,i,j,k,coordinatesx,coordinatesy,coordinatesz,v,v1,qsphe,ii,iii,jj,jjj,kk,kkk,axis1,axis2,axis3,v2,v3;


///spheres and angles
	sph=Spherical(1,az,el);sph8=Spherical(1,(az+~angle.[0].degrad).wrap(pi.neg,pi),(el+~angle.[0].degrad).wrap((pi/2).neg,(pi/2)));
	mod_angle=SinOsc.ar(lfo,0.degrad).range(90.neg.degrad,90.degrad);
	mod_angle1=SinOsc.ar(lfo,90.degrad).range(90.neg.degrad,90.degrad);
	mod_anglez=SinOsc.ar(lfo,45.degrad).range(90.neg.degrad,90.degrad);

///distance
q1=Quaternion(0,sph.x,sph.y,sph.z); q2=Quaternion(0,sph8.x,sph8.y,sph8.z);
dist=q1.distance(q2);

			//env=EnvGen.ar(Env.perc(dist.lag(0.1),decay*dist.lag(0.1),amp),doneAction:2,levelScale:0.01);

///scales
//scale=57.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
scale_coo=Select.kr(switch1,
				[29.collect{nnn=nnn+1;Scale.major.performDegreeToKey(nnn,12)},29.collect{nnnn=nnnn+1;Scale.minor.performDegreeToKey(nnnn,12)}]);
scalar=2.pow(Select.kr(coo.linlin(14.neg, 14, 0, 28), scale_coo) / 12);

//fundamental
		l1=Select.kr(switch2,
				[((lamdoma1+1)/lamdoma1),((lamdoma1+1)/lamdoma1).reciprocal]);

fundamental=(center)*scalar*l1;
freq1=(fundamental*octave);

////spherical harmonics and ripple effect
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

		varamp=waveFreq.reciprocal*10;

	t=SinOsc.kr(ripple).range(1, 100);
	theta = az;
     phi = el;
	 wave = varamp*sin(waveFreq * theta + waveFreq * phi - waveSpeed * t);
  magxx=  magx * wave;

				mag_x=magxx.value;mag_y=magy.value;mag_z=magz.value;mag_qx=magqx.value;mag_qy=magqy.value
				);
///phase,tones

				l2=Select.kr(switch3,
				[((lamdoma2+1)/lamdoma2),((lamdoma2+1)/lamdoma2).reciprocal]);

						phase=Complex(sph.theta.linlin(pi.neg,pi,1.neg,1),sph.phi.linlin((pi/2).neg,(pi/2),1.neg,1)).theta;
				mod_angle2=SinOsc.ar(lfo2,phase).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones
			//mod_angle2=LFNoise1.ar(lfo2).range(90.neg.degrad,90.degrad);///harm oscillator phase can vary across tones

harm=((Complex(cos(((sph.phi+mod_angle2).round(0.00001)*mh).wrap((pi/2).neg,(pi/2))),cos(((sph.phi).round(0.00001)*mh).wrap((pi/2).neg,(pi/2)))).rho/(2.sqrt)).pow(spread));

sphere=Spherical(28*harm,az,el);

n1=(sphere.x).round(0.00000001);n2=(sphere.y).round(0.00000001);n3=(sphere.z).round(0.00000001);
//ratio1=n1.round(1);ratio2=n2.round(1);ratio3=n3.round(1);
//ton1 = 2.pow(Select.kr(ratio1.linlin(28.neg, 28, 0, 56), scale) / 12);
//ton2 = 2.pow(Select.kr(ratio2.linlin(28.neg, 28, 0, 56), scale) / 12);
//ton3 = 2.pow(Select.kr(ratio3.linlin(28.neg, 28, 0, 56), scale) / 12);
ton1 = 2.pow(n1 / 12);ton2 = 2.pow(n2 / 12);ton3 = 2.pow(n3 / 12);
	amp1=(ton1.reciprocal*octave.reciprocal*scalar.reciprocal*l1.reciprocal*l2.reciprocal).round(0.00000001);
	amp2=(ton2.reciprocal*octave.reciprocal*scalar.reciprocal*l1.reciprocal*l2.reciprocal).round(0.00000001);
	amp3=(ton3.reciprocal*octave.reciprocal*scalar.reciprocal*l1.reciprocal*l2.reciprocal).round(0.00000001);

	pitch1=(freq1*ton1*l2).round(0.0000001);pitch2=(freq1*ton2*l2).round(0.0000001);pitch3=(freq1*ton3*l2).round(0.0000001);

///magnitude and 4d rotation
mag=(Cartesian(mag_x,mag_y,mag_z).rho)+(Cartesian(mag_qx,mag_qy,mag_z).rho);

	v=Quaternion(0,sph.x,sph.y,sph.z);/// vector as quaternion

	coordinatesx=[1,0,0].normalizeSum.sqrt;coordinatesy=[0,1,0].normalizeSum.sqrt;coordinatesz=[0,0,1].normalizeSum.sqrt;

	i=Quaternion(0, coordinatesx.[0], 0, 0);j=Quaternion(0, 0, coordinatesx.[1], 0);k=Quaternion(0, 0, 0, coordinatesx.[2]);
	ii=Quaternion(0, coordinatesy.[0], 0, 0);jj=Quaternion(0, 0, coordinatesy.[1], 0);kk=Quaternion(0, 0, 0, coordinatesy.[2]);
	iii=Quaternion(0, coordinatesz.[0], 0, 0);jjj=Quaternion(0, 0, coordinatesz.[1], 0);kkk=Quaternion(0, 0, 0, coordinatesz.[2]);

axis1=(((i+j+k)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real); ////rotation vector with angle of rotatio and ijk xyz normalized components
v1=axis1*v*axis1.conjugate;

axis2=(((ii+jj+kk)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real);
v2=axis2*v1*axis2.conjugate;

axis3=(((iii+jjj+kkk)*exp(Complex(0,1)*rot_angle).imag)+exp(Complex(0,1)*rot_angle).real);
v3=axis3*v2*axis3.conjugate;

qsphe=Cartesian(v3.b,v3.c,v3.d).asSpherical;

///bpf oscillator basics
//sig=PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1,doneAction:2)*0.1;
			// osc1=VBAP.ar(4,BPF.ar(sig,pitch1,mul:amp1*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
			// osc2=VBAP.ar(4,BPF.ar(sig,pitch2,mul:amp2*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
			// osc3=VBAP.ar(4,BPF.ar(sig,pitch3,mul:amp3*mag,rq:rq),~b.bufnum,qsphe.theta.raddeg,
			// SinOsc.ar(cell,qsphe.phi).range(90.neg,90));

///oscillators
osc1=VBAP.ar(4,Osc.ar(~t.bufnum,pitch1,mul:amp1*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
osc2=VBAP.ar(4,Osc.ar(~t.bufnum,pitch2,mul:amp2*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));
osc3=VBAP.ar(4,Osc.ar(~t.bufnum,pitch3,mul:amp3*mag,phase:phase),~b.bufnum,qsphe.theta.raddeg,
				SinOsc.ar(cell,qsphe.phi).range(90.neg,90));

///ouput channels
Out.ar(0,LeakDC.ar(osc3,mul:amp*0.01));
Out.ar(0,LeakDC.ar(osc2,mul:amp*0.01));
Out.ar(0,LeakDC.ar(osc1,mul:amp*0.01));

}).add;

	);

}
)
/////////////control via GUI
////controls

(

Window.closeAll;
		s.meter;s.freqscope;s.scope;≥
w=Window.new("gui",Rect.new(100,100,1100,800)).front.alwaysOnTop_(true);

~a_gain = Knob.new(w.view,Rect.new(20,450,100,100));
~b_spread = Knob.new(w.view,Rect.new(140,450,100,100));
~c_ripple1 = Knob.new(w.view,Rect.new(260,450,100,100));
~d_lfo1 = Knob.new(w.view,Rect.new(20,650,100,100));
~e_lfo2 = Knob.new(w.view,Rect.new(140,650,100,100));
~f_lfo3 = Knob.new(w.view,Rect.new(260,650,100,100));
~p_lfo4 = Knob.new(w.view,Rect.new(380,650,100,100));
~g_fund1 = Knob.new(w.view,Rect.new(640,500,100,100));
~k_fund2 = Knob.new(w.view,Rect.new(760,500,100,100));
~n_octave = Knob.new(w.view,Rect.new(880,500,100,100));
~l_lamda = Knob.new(w.view,Rect.new(900,80,100,100));
~m_harmonic = Knob.new(w.view,Rect.new(900,200,100,100));
~o_rotation = Knob.new(w.view,Rect.new(900,320,100,100));
~q_az_el = Slider2D.new(w.view,Rect.new(20,20,800,400));
~s1 = Button(w,Rect(620,700,60,60)).value_;
~s2 = Button(w,Rect(720,700,60,60));
~s3 = Button(w,Rect(820,700,60,60));

(
StaticText(w, Rect(400,420,200, 20)).string = "azimuth|elevation";
StaticText(w, Rect(20,500,100,100)).string = "amp";
StaticText(w, Rect(140,500,100,100)).string = "spread";
StaticText(w, Rect(260,500,100,100)).string = "ripple waves";
StaticText(w, Rect(20,700,100,100)).string = "mag lfo";
StaticText(w, Rect(140,700,100,100)).string = "tone lfo";
StaticText(w, Rect(260,700,100,100)).string = "ripple lfo";
StaticText(w, Rect(380,700,100,100)).string = "rotation lfo";
StaticText(w, Rect(640,560,100,100)).string = "scale tone fund";
StaticText(w, Rect(760,560,100,100)).string = "lamda tone fund";
StaticText(w, Rect(880,560,100,100)).string = "octave fund";
StaticText(w, Rect(900,130,100,100)).string = "lamda tone";
StaticText(w, Rect(900,250,100,100)).string = "sph harm order";
StaticText(w, Rect(900,370,100,100)).string = "rotation angle";
StaticText(w, Rect(620,740,60,60)).string = "fund";
StaticText(w, Rect(720,740,60,60)).string = "fund";
StaticText(w, Rect(820,740,60,60)).string = "tone";
);

~synth=Synth.new(\ospace,[
	\amp,~a_gain.value,
	\lfo,~d_lfo1.value.linlin(0,1,0.001,10),
	\spread,~b_spread.value.linlin(0,1,1,100),
	\ripple,~f_lfo3.value.linlin(0,1,0.0001,1),
	\waveFreq,~c_ripple1.value.linlin(0,1,1,10).round(1),
	\rotation,~o_rotation.value.linlin(0,1,0,359).round(1),
	\coo,~g_fund1.value.linlin(0,1,14.neg,14).round(1),
	\cell,~p_lfo4.value.linlin(0,1,0.01,1),
	\lamdoma2,~l_lamda.value.linlin(0,1,1,3).round(1),
	\lamdoma1,~k_fund2.value.linlin(0,1,1,3).round(1),
	\mh,~m_harmonic.value.linlin(0,1,0,3).round(1),
	\lfo2,~e_lfo2.value.linlin(0,1,0.01,10),
	\octave,~k_fund2.value_(1),
	\switch1,~s1.value_(1),
	\switch2,~s2.value_(1),
	\switch3,~s3.value_(1),
\el,~q_az_el.y.linlin(0,1,180.neg.degrad,180.degrad),
\az,~q_az_el.x.linlin(0,1,90.neg.degrad,90.degrad)]).register;

(
~s1.states_([
			["major",Color.red,Color.gray],["minor",Color.black,Color.red]]).action_({
	arg obj;
	if(obj.value==0,{if(~synth.isPlaying,{~synth.set(\switch1,0)});},{if(~synth.isPlaying,{~synth.set(\switch1,1)});})})
);
(
~s2.states_([
			["overtone",Color.green,Color.gray],["sub",Color.black,Color.green]]).action_({
	arg obj;
	if(obj.value==0,{if(~synth.isPlaying,{~synth.set(\switch2,0)});},{if(~synth.isPlaying,{~synth.set(\switch2,1)});})})
);
(
~s3.states_([
			["overtone",Color.blue,Color.gray],["sub",Color.black,Color.blue]]).action_({
	arg obj;
	if(obj.value==0,{if(~synth.isPlaying,{~synth.set(\switch3,0)});},{if(~synth.isPlaying,{~synth.set(\switch3,1)});})})
);
(
~a_gain.action_({
	arg obj;
			var gain;
	obj.value.postln;
	gain=obj.value;
		if(~synth.isPlaying,{~synth.set(\amp,gain)});
});
);
(
~b_spread.action_({
	arg obj;
			var spread;
	spread=obj.value.linlin(0,1,1,100);
				spread.value.postln;
	if(~synth.isPlaying,{~synth.set(\spread,spread)});
});
);
(
~c_ripple1.action_({
	arg obj;
			var ripple1;

				ripple1=obj.value.linlin(0,1,1,10).round(1);
				ripple1.value.postln;
	if(~synth.isPlaying,{~synth.set(\waveFreq,ripple1)});
});
);
(
~d_lfo1.action_({
	arg obj;
			var mag;
			mag=obj.value.linlin(0,1,0.001,10);
				mag.value.postln;
if(~synth.isPlaying,{~synth.set(\lfo,mag)});
});
);
	(
~e_lfo2.action_({
	arg obj;
			var tone;
			tone=obj.value.linlin(0,1,0.001,10);
				tone.value.postln;
if(~synth.isPlaying,{~synth.set(\lfo2,tone)});
});
);
			(
~f_lfo3.action_({
	arg obj;
			var ripple;
				ripple=obj.value.linlin(0,1,0.0001,1);
				ripple.value.postln;
if(~synth.isPlaying,{~synth.set(\ripple,ripple)});
});
);
			(
~g_fund1.action_({
	arg obj;
			var fund1;
				fund1=obj.value.linlin(0,1,14.neg,14).round(1);
				fund1.value.postln;
if(~synth.isPlaying,{~synth.set(\coo,fund1)});
});
);
			(
~k_fund2.action_({
	arg obj;
			var fund2;
				fund2=obj.value.linlin(0,1,1,3).round(1);
				fund2.value.postln;
if(~synth.isPlaying,{~synth.set(\lamdoma1,fund2)});
});
);
			(
~l_lamda.action_({
	arg obj;
			var lamda;
				lamda=obj.value.linlin(0,1,1,3).round(1);
				lamda.value.postln;
if(~synth.isPlaying,{~synth.set(\lamdoma2,lamda)});
});
);
			(
~m_harmonic.action_({
	arg obj;
			var harmonic;
				harmonic=obj.value.linlin(0,1,0,3).round(1);
				harmonic.value.postln;
if(~synth.isPlaying,{~synth.set(\mh,harmonic)});
});
);
			(
~n_octave.action_({
	arg obj;
			var octave,powers,oct;
		powers=[1,2,4,8];
				octave=obj.value.linlin(0,1,0,3).round(1);
		oct=powers.[octave];
				oct.value.postln;
if(~synth.isPlaying,{~synth.set(\octave,oct)});
});
);
			(
~o_rotation.action_({
	arg obj;
			var rotation;
				rotation=obj.value.linlin(0,1,0,359).round(1);
				rotation.value.postln;
if(~synth.isPlaying,{~synth.set(\rotation,rotation)});
});
);
			(
~p_lfo4.action_({
	arg obj;
			var lfo4;
				lfo4=obj.value.linlin(0,1,0.001,1);
				lfo4.value.postln;
if(~synth.isPlaying,{~synth.set(\cell,lfo4)});
});
);
		(
~q_az_el.action_({
	arg obj;
			var az,el;
	az=obj.x.linlin(0,1,180.neg.degrad,180.degrad);
	el=obj.y.linlin(0,1,90.neg.degrad,90.degrad);
				az.value.postln;
				el.value.postln;
if(~synth.isPlaying,{~synth.set(\az,az,\el,el)});
});
);
	);


s.record(numChannels:4);
