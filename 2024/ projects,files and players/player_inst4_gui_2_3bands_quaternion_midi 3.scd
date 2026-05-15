


////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*8;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 4;
s.waitForBoot
)

Buffer.freeAll
s.record(numChannels:4)

(
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241122_121357.wav");
)
(
(
(
SynthDef.new(\inst4,
{
		arg cutt1=0,cutt2=0,gain1=1,mix1=1,mix2=1,mix3=1,width=1;
		var sig1,sig2,sig3;
		var pass1,pass2,pass3;
		var i,j,k,q1,q2,v1,v2,xyz=[1,1,1].normalizeSum.sqrt;
		var angle_cuttfreq1;
		var cuttfreq1,axis;

		angle_cuttfreq1 = cutt1;

		v1=Quaternion(0,1,0,0);
		v2=Quaternion(0,1,0,0);

	i=Quaternion(0, xyz.[0], 0, 0); j=Quaternion(0, 0, xyz.[1], 0); k=Quaternion(0, 0, 0, xyz.[2]);

		axis=i+j+k;

q1=((axis*exp(Complex(0,1)*angle_cuttfreq1).imag)+exp(Complex(0,1)*angle_cuttfreq1).real); v1=q1*v1*q1.conjugate;


		cuttfreq1=Cartesian(v1.b,v1.c,v1.d);

		pass1=cuttfreq1.x.round(0.000001).abs.linlin(0,1,55,55*256);
		pass2=cuttfreq1.y.round(0.000001).abs.linlin(0,1,55,55*256);
		pass3=cuttfreq1.z.round(0.000001).abs.linlin(0,1,55,55*256);


sig1=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),
				freq:pass1.lag(0.333),rq:width,mul:1/(width.lag(0.333)).sqrt),
			mix:mix1.lag(0.333),room:1,mul:gain1.lag(0.333));

sig2=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),
				freq:pass2.lag(0.333),rq:width,mul:1/(width.lag(0.333)).sqrt),
			mix:mix2.lag(0.333),room:1,mul:gain1.lag(0.333));
sig3=FreeVerb.ar(BPF.ar
			(PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:2),
			freq:pass3.lag(0.333),rq:width,mul:1/(width.lag(0.333)).sqrt),
			mix:mix3.lag(0.333),room:1,mul:gain1.lag(0.333));


	Out.ar(0,sig1);Out.ar(0,sig2);Out.ar(0,sig3);

}).add;);
(
Window.closeAll;
w=Window.new("gui",Rect.new(750,100,300,400)).front.alwaysOnTop_(true);

~gain1 = Slider.new(w.view,Rect.new(20,20,160,30));

~filter1 = Slider.new(w.view,Rect.new(20,100,30,250));
~band1 = Slider.new(w.view,Rect.new(60,310,200,30));

~reverb1 = Slider.new(w.view,Rect.new(60,100,160,30));
~reverb2 = Slider.new(w.view,Rect.new(60,130,160,30));
~reverb3 = Slider.new(w.view,Rect.new(60,160,160,30));

~on = Button(w,Rect(100,230,60,60)).states_([
	["off",Color.black],Color.gray,["on",Color.white,Color.gray]]).action_({
	arg obj;
	if(
		obj.value==1,{~synth=Synth.new(\inst4,[
\gain1,~gain1.value,\mix1,~reverb1.value,\mix2,~reverb2.value,\mix3,~reverb3.value,
			\cutt1,~filter1.value.linlin(0,1,360.neg,360),\width,~band1.value.linlin(0,1,0.0001,1)]).register;},
		{~synth.free}
)});
(
a = StaticText(w, Rect(190,20,100, 20));
a.string = "gain1";
b = StaticText(w, Rect(240,100,200, 20));
b.string = "reverb1";
c = StaticText(w, Rect(240,130,200, 20));
c.string = "reverb2";
d = StaticText(w, Rect(240,160,200, 20));
d.string = "reverb3";
e = StaticText(w, Rect(70,340,200,30));
e.string = "bandwidth";
)
);

(
~gain1.value_(0.5).action_({
	arg obj;
	var gain;
	obj.value.postln;
	gain=obj.value;
	if(~synth.isPlaying,{~synth.set(\gain1,gain)});
});
);
(
~reverb1.action_({
	arg obj;
	var mix;
	obj.value.postln;
	mix=obj.value;
	if(~synth.isPlaying,{~synth.set(\mix1,mix)});
});
);
(
~reverb2.action_({
	arg obj;
	var mix;
	obj.value.postln;
	mix=obj.value;
	if(~synth.isPlaying,{~synth.set(\mix2,mix)});
});
);
(
~reverb3.action_({
	arg obj;
	var mix;
	obj.value.postln;
	mix=obj.value;
	if(~synth.isPlaying,{~synth.set(\mix3,mix)});
});
);
(
~filter1.action_({
	arg obj;
	var pass;
	pass=obj.value.linlin(0,1,360.neg,360);
	["pass"].postln;
	pass.value.postln;
	if(~synth.isPlaying,{~synth.set(\cutt1,pass)});
});
);
(
~band1.action_({
	arg obj;
	var band;
	band=obj.value.linlin(0,1,0.0001,1);
	["band"].postln;
	band.value.postln;
	if(~synth.isPlaying,{~synth.set(\width,band)});
});
);
);

	(
MIDIClient.init;
MIDIIn.connectAll;

		(
MIDIdef.cc(\midi2,{ |val, num, chan, src|
		var band;
	//[val, num, chan, src].postln;
	band=val.linlin(0,1,0.0001,1);
		band.postln;
		if(~synth.isPlaying,{~synth.set(\width,band)});
},25);
	);

		(
MIDIdef.cc(\midi2,{ |val, num, chan, src|
		var pass;
	//[val, num, chan, src].postln;
	pass=val.linlin(0,127,360.neg,360);
		pass.postln;
		if(~synth.isPlaying,{~synth.set(\cutt1,pass)});
},24);
	);
	(
MIDIdef.cc(\midi3,{ |val, num, chan, src|
		var pass;
	//[val, num, chan, src].postln;
	pass=val.linlin(0,127,0,1);
		pass.postln;
		if(~synth.isPlaying,{~synth.set(\gain1,pass)});
},23);
	);
		(
MIDIdef.cc(\midi4,{ |val, num, chan, src|
		var mix;
	//[val, num, chan, src].postln;
	mix=val.linlin(0,127,0,1);
		mix.postln;
		if(~synth.isPlaying,{~synth.set(\mix1,mix)});
},22);
	);
	(
MIDIdef.cc(\midi5,{ |val, num, chan, src|
		var mix;
	//[val, num, chan, src].postln;
	mix=val.linlin(0,127,0,1);
		mix.postln;
		if(~synth.isPlaying,{~synth.set(\mix1,mix)});
},21);
	);
		(
MIDIdef.cc(\midi6,{ |val, num, chan, src|
		var mix;
	//[val, num, chan, src].postln;
	mix=val.linlin(0,127,0,1);
		mix.postln;
		if(~synth.isPlaying,{~synth.set(\mix3,mix)});
},20);
	);

)
)