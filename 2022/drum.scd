(
{Out.ar(0,LFPulse.ar(2,width:0.1))}.play;
{Out.ar(1,LFPulse.ar(3,width:0.1))}.play;

{Out.ar(2,SoundIn.ar(0)!2)}.play;

)

s.options.numOutputBusChannels =4