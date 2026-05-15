s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1024*4;

s.options.numOutputBusChannels=40;/////////////40tet1 +40tet2 +2so +2el4az_coordinates (or 46 rest for coordinates eg. 24 for dodecahedron
TempoClock.default.tempo_(120/60);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;


(
SynthDef.new(\t, {

	var env,level,duration,face1,face2,face3,face4;
	var edge1a,edge1b,edge1c,edge2a,edge2b,edge2c;
	var edge3a,edge3b,edge3c,edge4a,edge4b,edge4c;
	var v3a,v3b,v3c,v4a,v4b,v4c;
	var v1a,v1b,v1c,v2a,v2b,v2c;
	var v5a,v5b,v5c,v6a,v6b,v6c;
	var v7a,v7b,v7c,v8a;

	env = EnvGen.ar(Env.sine(duration,level), doneAction: 2);
////////////////////////////////////////////////////////////////////////////	////////

	face1 = Out.ar(4,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));

	face2 = Out.ar(7,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));

	face3 = Out.ar(10,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));

	face4 = Out.ar(13,PanAz.ar(3,InFeedback.ar(3),LFSaw.ar(),level:env,width:2));
///////////////////////////////////////////////////////////////////////////////

	edge1a = Out.ar(16,Pan2.ar(InFeedback.ar(4),LFSaw.ar(),level:env));
	edge1b = Out.ar(18,Pan2.ar(InFeedback.ar(5),LFSaw.ar(),level:env));
	edge1c = Out.ar(20,Pan2.ar(InFeedback.ar(6),LFSaw.ar(),level:env));

	edge2a = Out.ar(22,Pan2.ar(InFeedback.ar(7),LFSaw.ar(),level:env));
	edge2b = Out.ar(24,Pan2.ar(InFeedback.ar(8),LFSaw.ar(),level:env));
	edge2c = Out.ar(26,Pan2.ar(InFeedback.ar(9),LFSaw.ar(),level:env));

	edge3a = Out.ar(28,Pan2.ar(InFeedback.ar(10),LFSaw.ar(),level:env));
	edge3b = Out.ar(30,Pan2.ar(InFeedback.ar(11),LFSaw.ar(),level:env));
	edge3c = Out.ar(32,Pan2.ar(InFeedback.ar(12),LFSaw.ar(),level:env));

	edge4a = Out.ar(34,Pan2.ar(InFeedback.ar(13),LFSaw.ar(),level:env));
	edge4b = Out.ar(36,Pan2.ar(InFeedback.ar(14),LFSaw.ar(),level:env));
	edge4c = Out.ar(38,Pan2.ar(InFeedback.ar(15),LFSaw.ar(),level:env));
////////////////////////////////////////////////////////////////////////////

	v1a = Out.ar(0,LeakDC.ar(InFeedback.ar(16)),LFSaw.ar(),level:env);
	v1b = Out.ar(0,LeakDC.ar(InFeedback.ar(17)),LFSaw.ar(),level:env);
	v1c = Out.ar(0,LeakDC.ar(InFeedback.ar(18)),LFSaw.ar(),level:env);
	v1d = Out.ar(0,LeakDC.ar(InFeedback.ar(19)),LFSaw.ar(),level:env);
	v1e = Out.ar(0,LeakDC.ar(InFeedback.ar(20)),LFSaw.ar(),level:env);
	v1f = Out.ar(0,LeakDC.ar(InFeedback.ar(21)),LFSaw.ar(),level:env);

	v2a = Out.ar(1,LeakDC.ar(InFeedback.ar(22)),LFSaw.ar(),level:env);
	v2b = Out.ar(1,LeakDC.ar(InFeedback.ar(23)),LFSaw.ar(),level:env);
	v2c = Out.ar(1,LeakDC.ar(InFeedback.ar(24)),LFSaw.ar(),level:env);
	v2d = Out.ar(1,LeakDC.ar(InFeedback.ar(25)),LFSaw.ar(),level:env);
	v2e = Out.ar(1,LeakDC.ar(InFeedback.ar(26)),LFSaw.ar(),level:env);
	v2f = Out.ar(1,LeakDC.ar(InFeedback.ar(27)),LFSaw.ar(),level:env);

	v3a = Out.ar(2,LeakDC.ar(InFeedback.ar(28)),LFSaw.ar(),level:env);
	v3b = Out.ar(2,LeakDC.ar(InFeedback.ar(29)),LFSaw.ar(),level:env);
	v3c = Out.ar(2,LeakDC.ar(InFeedback.ar(30)),LFSaw.ar(),level:env);
	v3d = Out.ar(2,LeakDC.ar(InFeedback.ar(31)),LFSaw.ar(),level:env);
	v3e = Out.ar(2,LeakDC.ar(InFeedback.ar(32)),LFSaw.ar(),level:env);
	v3f = Out.ar(2,LeakDC.ar(InFeedback.ar(33)),LFSaw.ar(),level:env);

	v4a = Out.ar(3,LeakDC.ar(InFeedback.ar(34)),LFSaw.ar(),level:env);
	v4b = Out.ar(3,LeakDC.ar(InFeedback.ar(35)),LFSaw.ar(),level:env);
	v4c = Out.ar(3,LeakDC.ar(InFeedback.ar(36)),LFSaw.ar(),level:env);
	v4d = Out.ar(3,LeakDC.ar(InFeedback.ar(37)),LFSaw.ar(),level:env);
	v4e = Out.ar(3,LeakDC.ar(InFeedback.ar(38)),LFSaw.ar(),level:env);
	v4f = Out.ar(3,LeakDC.ar(InFeedback.ar(39)),LFSaw.ar(),level:env);


}).add;
)

Synth.new(\t);

