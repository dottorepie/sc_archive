//////////////////////////////////

(
SynthDef.new(\id, {
	arg a=1,fund=200,b=1,o=10,x=0,bus=0,attack=1,decay=1,fil=440;
	var y,sum=0,wave,c;
	var envelope,p=0;
	b=TWChoose.kr(1,[4/1,5/2,6/3,7/4,8/5,9/6],[0.1,0.2,0.5,0.6,0.4,0.1]);
	b=b*(-1);
	3.do{
		p=p+1/3;
		x=x+1;
		y=((x**b)+a)/(x**(b));
		y.postln;
		envelope=EnvGen.ar(Env.perc(attack,decay,1,[-4,-6]),doneAction:2);
     //wave=SinOsc.ar(y*fund,mul: (1/y))*envelope;
		wave=BLowPass.ar(VarSaw.ar(y*fund,mul: (1/y),iphase:p,width:1/y),fil,1);
		sum= sum+wave;};
	Out.ar(0,PanAz.ar(2,sum*envelope,bus));

}).add;
)
Synth.new(\id,[\fund,400,\attack,1,\decay,4,\bus,]);


(
Tdef(\sa,
      {
				 1.do({(
Tdef(\synth_x, { loop { 2.wait; (
				Synth.new(\id,[\fund,((9/6)*100),\attack,2,\decay,4,\bus,-0.5,\fil,440]));
} }).play;) ;  0.yield});

					 1.do({(
Tdef(\synth_y, { loop { 5.wait; (
	Synth.new(\id,[\fund,((9/6)*100)+1,\attack,2,\decay,4,\bus,0.5,\fil,440]));
} }).play;) ;  32.yield});

		Tdef(\synth_x).stop; 0.yield;
		Tdef(\synth_y).stop; 0.yield;
					 1.do({(
Tdef(\synth_x, { loop { 2.wait; (
	Synth.new(\id,[\fund,((8/5)*100),\attack,2,\decay,4,\bus,-0.5,\fil,440]));
} }).play;) ;  0.yield});

					 1.do({(
Tdef(\synth_y, { loop { 5.wait; (
	Synth.new(\id,[\fund,((8/5)*100)+1,\attack,2,\decay,4,\bus,0.5,\fil,440]));
} }).play;) ;  32.yield});
				Tdef(\synth_x).stop; 0.yield;
		Tdef(\synth_y).stop; 4.yield;
						 1.do({(
Tdef(\synth_x, { loop { 2.wait; (
				Synth.new(\id,[\fund,((7/4)*100),\attack,2,\decay,4,\bus,-0.5,\fil,440]));
} }).play;) ;  0.yield});

					 1.do({(
Tdef(\synth_y, { loop { 5.wait; (
	Synth.new(\id,[\fund,((7/4)*100)+1,\attack,2,\decay,4,\bus,0.5,\fil,440]));
} }).play;) ;  32.yield});

		Tdef(\synth_x).stop; 0.yield;
		Tdef(\synth_y).stop; 0.yield;
			})
)
Tdef(\sa).play;
Tdef(\sa).stop;





/////////////////////////////////////

(
//~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~a= vel.linlin(6,87,2,20).postln; "a".postln}, 71, 0);
//~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~b= vel.linlin(14,124,0.01,1).round.postln;"b".postln}, 73, 0);
~pot2 = MIDIFunc.cc( , 73, 0);
)

MIDIClient.init;
MIDIIn.connectAll;

////////////////////////////////////////////////////////////////////////////////////installation pattern
////////////////////////////////////////////////////////////////////////////////////////////////////
(
c= Pdef(\ii, Pbind(\instrument, \id,
\b,Pgauss(2,3,1/4,inf)
)).play(quant:1));





s.options.numOutputBusChannels=8;
TempoClock.default.tempo_(60/45);
);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

