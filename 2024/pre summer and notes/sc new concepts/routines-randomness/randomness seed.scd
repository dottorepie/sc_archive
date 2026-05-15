// every thread, also a Routine, has a random generator seed:
(
r = Routine({
    loop({#[1,2,3,4,5].choose.yield })
});
r.randSeed = 1923;
)

// using the routine to fill an array
Array.fill(7, r);

// setting the random generator seed back to our initial seed
r.randSeed = 1923;

// causes this array to be identical
Array.fill(7, r);

///////////////////////////////////////////////////////////////////////////////
thisThread.randSeed = 1923;

// create a function that returns a Routine

r = { Routine({
	loop({#[1,2,3,4,5].choose.yield })
}) };

Array.fill(7, r.value);

// reset the seed
thisThread.randSeed = 1923;

Array.fill(7, r.value);

/////////////////////////////////////////////////////////////////////////////////////
RandSeed.kr(trig: 0.0, seed: 56789)
///////////////////////////////////////////////

SerialPort.devices;
~port = SerialPort.new("/dev/cu.usbserial-130",9600)

(
~charArray = [];
~getValues = Routine.new({

	var ascii;
	{ascii = ~port.read.asAscii;
		if(ascii.isDecDigit, {~charArray = ~charArray.add(ascii)});
		if(ascii == $a,{~val = ~charArray.collect(_.digit).convertDigits;
			~charArray =[];
		});
	}.loop;

}).play
)

~val

(
SynthDef(\noise ,{ arg amp; var sig;

sig = WhiteNoise.ar(amp.lag(0.02));

	Out.ar(0,sig);
}).add;

)
(
~synth=Synth.new(\noise, [amp:0.1]);

(~control = Routine.new({
	{
		~synth.set(\amp,~val.linlin(20,1100,0.0001,1));
		0.01.wait;
	}.loop;
}).play;
)
)
