(
{
	var sig,audio=0,freq=100,rand=(360-(360/((sqrt(5)+1)/2))),add=1+rand.wrap(1,4);
	1000.do{
		sig=BPF.ar(SinOsc.ar(freq*add,mul:0.1,phase:add),440,0.01);

	rand= rand+(360-(360/((sqrt(5)+1)/2)));
	add=1+rand.wrap(1,2pi);
	add.postln;

		audio=sig+audio;

	};

	Out.ar(0,audio!2);
}.play
)







(
var add=1, rand=(360-(360/((sqrt(5)+1)/2))),f;

100.do{
	rand= rand+(360-(360/((sqrt(5)+1)/2)));
	add=1+rand.wrap(1,2pi);
	//f=(exp(Complex.new(0,1)*add));
	add.postln;
	}

)



(
	var sig,audio=0,freq=100,x=0,y=1,a=1;
	10.do{


	x=x+1;
	y=x;
		a=exp(y);
	a.postln;


	};

)
exp(0.1)

((sqrt(5)+1)/2)

(
{
	var sig,audio=0,freq=440,x=0,y=1,a=10;
	100.do{
		sig= BPF.ar(SinOsc.ar(freq*y,mul:1/a),440,0.1);

	x=x+1;
	y=1/x;
		a=exp(y);

		audio=sig+audio;

	};

	Out.ar(0,audio!2);
}.play
)












(2048/((sqrt(5)+1)/2))








