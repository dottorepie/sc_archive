(
OSCdef.new(
	\osc,
	{
		arg msg, time, addr, port;
	//	[msg, time, addr, port].postln;
		msg.postln
		Synth(\blabla, [argument:msg.[1]])
	},'/wek/outputs'
);
)

///incoming listening port for sc
NetAddr.langPort;

////loopback adress
~server=NetAddr.new("127.0.0.1",57120);

~server.sendMsg('/test',6,0.01);


////server status and messages
OSCFunc.trace(true);