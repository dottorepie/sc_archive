
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=2;

/////////////////////////////////////////

/////SynthDef


k.free;
k = Synth.new(\r0);
s.record(numChannels:2);

///////////////////////////////////////////////////////

////Task











