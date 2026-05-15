//////value set example via oscillator
~controlBus_m = Bus.control(s, 1);

(

{
var n1,n2, tone1, tone2, sig, degree,m,scale,nn=8.neg,r;

	scale=15.collect{nn=nn+1;Scale.major.performDegreeToKey(nn,12)};
//scale.postln;
	r=SinOsc.kr(0.1,phase:0.degrad,mul:2).range(pi.neg,pi);
//n1=SinOsc.kr(0.1,phase:0.degrad).range(7.neg,7).round(1);
	//n1=LFNoise0.kr(1).range(12.neg,12).round(1);
	//n1=SinOsc.kr(0.1,phase:0.degrad).range(12.neg,12).round(1);
	//n2=SinOsc.kr(0.1,phase:90.degrad).range(12.neg,12).round(1);
		//Out.kr(~controlBus_m.index, n);

	n1=Spherical(7,r,MouseX.kr(0,90).round(10).degrad).x.round(1);
	tone1= 2.pow(Select.kr(n1.linlin(7.neg, 7, 0, 14), scale) / 12);
	//tone1=2.pow(n1/12);
	//tone2=2.pow(n2/12);
//	n1.poll;
	//	m=~controlBus_m.getSynchronous;
//	tone=Scale.major.performDegreeToKey(m,12).poll;
	//Out.ar(0,SinOsc.ar(440*tone1+n1,phase:0.degrad,mul:tone1.reciprocal)*0.1);
	Out.ar(0,SinOsc.ar(440*tone1,phase:0.degrad,mul:tone1.reciprocal)*0.1);
	//Out.ar(1,SinOsc.ar(440*tone2+n2,phase:90.degrad,mul:tone2.reciprocal)*0.1);
	//Out.ar(1,SinOsc.ar(440*tone2,phase:90.degrad,mul:tone2.reciprocal)*0.1);

}.play
)


//////////pattern////analysis of the ssound-engine synth pattern, to convert some controls to values streams via the control synth

/*(
	~aa=Pdef(\1, Pbind(\instrument, \ospace,

\dur,Pseq(~dur.abs/14,inf),///////////////////////////////////////////////////duration stays as it triggers the audio synth through the pattern in time, dur will be longer intervals to acomododate stream values on other controls. as such dur here does not define a note but a collection of notes, it can possible seen as one ore more bars, measures.

\coo,Pseq(~dur,inf),  //sequence for major/minor fundamental multiplier////////this modulator and below the lamdoma are also connected to the emotional model.It would be best to keep them static for one or more bars and not as stream values.Maybe it would be useful to control them via oscillators through a different control level or a second control synth in the second level, that would trigger in a slower pace and last longer, of course this mess can be avoided if this value is synth by the audio synth pattern, the first level control.

\mm,Prand([1,2/1,3/2,4/3],inf),    //lamdoma interval multiplier/////////////////again as mentioned above.

\mh,Prand([1],inf),     //spherical harmonic for tone bends//////////////////////again as mentioned above with possibly more emphasis on the third control level direction since this number line represents a fourth 'rotational' axis for the emotional model. The third axis is either a lamdoma or major/minor according to the nature of the tonal system (rounded/unrounded) and is not included in this pattern example as the final emotional model has not been yet written in the composition files.

\pl1,Pseq(~list,inf),    ///coordinate selection/////////////////////////////The coordinates selection can happen via the control synth with a value stream setting the location via an array of locations for the unrounded tone model, and via  simpler arrays of az ane el for the rounded tone model. The value stream oscilators as they represent indexes in an array must be rounded to 1, include 0,and be in sync(same oscillator) between az and el for the unrounded model. The can have amplitude modulations again via spherical harmonics, an envelope and be triggered by a pattern. In this case the pattern needs to have 3/4 intervals if the time interval of the sound-engine pattern is 3/4 bar or more bars of this time signature. This means that every three triggers of the control synth pattern sequence are value stream arpegio sequencies in this 3/4 bar. The arpeggio is defined by the envelope and amplitude for its tone/location output and the frequency of the oscillator sets the arpegio speed. Three arpegios in series with interconected amplitude modulations (spherical harmonics) and thus maybe some interesting tone sequencies based on the spheric modulations. As far as panning is conserned, each control channel output corresponds to one sound-engine synth control value as described in this scope. Panning would mean that the control synth may output to more than one synth-audio-engine and potentially servers, depending on the engine cpu load. One example would be to pan the control synth in stereo and have two engine with different octaves each for the fundamental. The panning would then define on which octave the melodies are played on. Three axis panning dictates (tetrahedron) that there need to be at least 4 sound-engine, therefore under the forementioned example four octave levels(1,2,4,8 or 1/2,1,2,4). When there is no value stream gain present in the adjusent tone/location control of the engine this equals to a value of 0 which is the start of the array, scrambled or not. For more precise array localization additional mappings need to be present. Three control oscillators with same phase x,y,z for the three tone oscillators of the engine

\pl2,Pseq(~list2,inf), ///+1coordinate for distance measurement//////////////as the overall compostion model moves, there are no envelopes for individual tones as the are part of a stream. The start location of the stream is defined by the initial phase of its oscillator, which is set by another pl1 for the control synth for the sphere array. In particular this spherical model dictates: through its coordinates x,y,z: location to control oscillator phase maping, spherical mag oscillation for the control. Therefore the stream value envelope can hold the distance information between different value stream triggers of the control synth pattern

\lfo,Pbrown(0.01,1/2,0.1,inf), //mag spherical harmonic oscillation///////////// this control can stay at the engine (no need for value stream) as it concerns its spherical array, the control synth pattern has its own dedicated lfo for the same function

\lfo2,Pbrown(0.0001,0.005,0.001,inf), //tone spherical harmonic oscillation///// same as above

\cell,Pbrown(0.01,1/4,0.1,inf), //speed of 4dimensional oscillation///////same as above

\rot_angle,Pseq(~angle,inf),//angle for filed rotation/////////////////////////same as above

\spread,Pbrown(0.1,2,1,inf),  //spherical harmonic width//////////////////////same as above

\ripple,Pbrown(0.001,0.1,0.01,inf),  //sphere ripple wave oscillation speed///this can become a value stream for interchangeable speeds through the control synth arpegio or event triggers. The control synth will not have a ripple effect in its spherical model, therefore non in its pattern.

\amount,Prand([4,5,6,7,8],inf),   //sphere ripple waves amount//////////////this can stay as is

\varamp,Pbrown(0.1,2,0.1,inf), //ripple amp/////////////////////////////////can stay as is or be better be reciprocal of the ripple speed or amount

\decay,Pbrown(4,8,1,inf),////////////////////////////////////////////////////longer decay correspondent to needs of longer dur interval. The whole engine envelope needs to be redisgned for its new porpuse, maybe be sine and not perc, as it is an enveloped interval between emotions and a whole or more bars.

\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),//outpu channel order randomizer///this can stay as is,no stream, localization becomes too complicated if not already,
\out2,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),/////////////////
\out3,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),////////////////

\amp,Pseq(~r,inf);   ///l system////////////////////////////////////////stays as is and thus defines clearer moments of silence as dur has become a whole or more measures rather then a single note.

)))*/


////about the stream value tone/location settings. The oscillator needs to be a sine oscillator as the phase argument is needed for an initial location. Now the values of the array that the oscillators uses are, in the case of the unrounded model 4320 values (+1 for the 'next point distance range) nad for the rounded model 361 +1, or less. So whether the array is scrambled or not the osiscillator range would be eg. 0,4320 with absolute values thus each cicle is two iterations of the same whole array scan. A further option would be to modulate this range. Lets say the initial position derived from the array through the oscillator phase is some position during that range, then the range min and max can be one random value x as the max and the min value being 0. In this away the range is modulated as different instances of the max value


///after some experiments it seems more viable for the control synth ot ouput only the spherical harmonic magnitude oscillations and not an oscillator that incorporates them.