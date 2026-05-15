
(
s.waitForBoot({
	var visualizationFrequency = 100;
	var impulsesPerSecond = 15;
	var overallSpeedMod = 1;
	var generator = Group.new;
	var squiggleGroup = Group.before(generator);
	~allPoints = Array.fill(300, Point(0,0));
	~squiggleBus.free;
	~squiggleBus = Bus.control(s, 6);

	m = NetAddr("127.0.0.1", NetAddr.langPort); // loopback

	SynthDef(\genSeg1, {
		| controlOutBus, parameterrange, dur |
		var time, xy, sc, env;
		time = LFSaw.kr(freq:1/dur, iphase:1).range(0, parameterrange);
		env = EnvGen.kr(Env.new([0,1,1,0], times:[0.001,dur-0.02,0.001]), doneAction:2);
		xy = [time + sin(20*time), time, -1, 8, -0.8, 4]; // composed graph lies between -1,8 and between -0.8 and 4
		Out.kr(controlOutBus,env*xy);
	}).add;

	SynthDef(\genSeg2, {
		| controlOutBus, parameterrange, dur |
		var time, xy, sc, env;
		time = LFSaw.kr(freq:1/dur, iphase:1).range(0, parameterrange);
		xy = [(2*time) + 2.695, 3 + sin(20*time), -1, 8, -0.8, 4]; // composed graph lies between -1,8 and between -0.8 and 4
		env = EnvGen.kr(Env.new([0,1,1,0], times:[0.001,dur-0.02,0.001]), doneAction:2);
		Out.kr(controlOutBus, env*xy);
	}).add;

	SynthDef(\genSeg3, {
		| controlOutBus, parameterrange, dur |
		var time, xy, sc, env;
		time = LFSaw.kr(freq:1/dur, iphase:1).range(0, parameterrange);
		xy = [((time+5)/5)*(6.695-time+sin(10*time)), 3.745-time, -1, 8, -0.8, 4]; // composed graph lies between -1,8 and between-0.8 and 4
		env = EnvGen.kr(Env.new([0,1,1,0], times:[0.001,dur-0.02,0.001]), doneAction:2);
		Out.kr(controlOutBus, env*xy);
	}).add;

	SynthDef(\genSeg4, {
		| controlOutBus, parameterrange, dur |
		var time, xy, sc, env;
		time = LFSaw.kr(freq:1/dur, iphase:1).range(0, parameterrange);
		xy = [4.704 - (3.76*time) - sin(20*time), 0.245 - time, -1, 8, -0.8, 4]; // composed graph lies between -1,8 and between -0.8 and 4
		env = EnvGen.kr(Env.new([0,1,1,0], times:[0.001,dur-0.02,0.001]), doneAction:2);
		Out.kr(controlOutBus, env*xy);
	}).add;

	SynthDef(\genSeg5, {
		| controlOutBus, parameterrange, dur |
		var time, xy, sc, env;
		time = LFSaw.kr(freq:1/dur, iphase:1).range(0, parameterrange);
		xy = [0, (time/1.3)-0.76, -1, 8, -0.8, 4]; // composed graph lies between -1,8 and between -0.8 and 4
		env = EnvGen.kr(Env.new([0,1,1,0], times:[0.001,dur-0.02,0.001]), doneAction:2);
		Out.kr(controlOutBus, env*xy);
	}).add;

	SynthDef(\squiggleTestAutomatic, {
		| out = 0, controlInBus |
		var sig, xy, freqs, ringtimes, env;
		// read the xy control values in the form [ minx, maxx, x, miny, maxy, y ]
		xy = Lag.kr(In.kr(controlInBus, 6));

		freqs = [800, 1071, 1153, 1723] * Lag.kr(xy[0].linlin(xy[2],xy[3],0.5,2), 0.1); /* MouseX.kr(0.5, 2, 1); */
		ringtimes = [1, 1, 1, 1] * Lag.kr(xy[1].linlin(xy[4], xy[5], 0.1, 10), 0.1); /* MouseY.kr(0.1, 10, 1); */
		sig = DynKlank.ar(`[freqs, nil, ringtimes ], Impulse.ar(impulsesPerSecond, 0, 0.1));

		SendReply.kr(Impulse.kr(visualizationFrequency), '/viz', [xy[0], xy[1]]); // impulse argument tells how often to update the display
		Out.ar(out, (0.3*sig)!2);

	}).add;

	s.sync;

	o=OSCFunc({|msg|
		~allPoints[0] = (Point(msg[3] /* x */,msg[4] /* y */));
		~allPoints = ~allPoints.shift(1, Point(0,0));
	}, '/viz');

	w = Window(bounds: Rect(0, 0, 1920, 780));
	v = UserView(w, w.view.bounds);
	v.background_(Color.white);
	v.animate_(true);
	v.drawFunc_({
		var startPoint = Point(~allPoints[0].x,~allPoints[0].y);
		Pen.moveTo(startPoint);
		~allPoints.do({
			| pt, index |
			if ((index > 1), {
				var prevPoint = ~allPoints[index-1];
				Pen.fillColor = "000000";
				Pen.alpha_(index.linlin(0, ~allPoints.size, 1, 0));
				Pen.line(
					Point((prevPoint.x.linlin(-1, 8, 0, 1920)), (prevPoint.y.linlin(-0.8,4,780,0))),
					Point((pt.x.linlin(-1, 8, 0, 1920)),(pt.y.linlin(-0.8,4,780,0)))
					);
				Pen.stroke;
			});
		});
	});
	w.onClose_({
		Pdef(\testSquiggle).stop;
		Pdef(\testSquiggle).clear;
		~squiggleBus.free;
	});
	w.front;


	Synth(\squiggleTestAutomatic, [controlInBus: ~squiggleBus]);
	Pdef(\testSquiggle).play;
	Pdef(\testSquiggle,
		Pbind(\instrument, Pseq([\genSeg1,\genSeg2,\genSeg3,\genSeg4,\genSeg5], 1),
			  \parameterrange, Pseq([3,2,3.5,1,1], 1),
			  \dur, Pfunc({|ev| ev[\parameterrange] / overallSpeedMod; }),
			  \group, squiggleGroup,
			  \meh, Pfunc({|ev| ("Switching to " ++ ev[\instrument]).postln; }),
			  \controlOutbus, ~squiggleBus));
});
)