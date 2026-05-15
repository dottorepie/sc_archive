s.record(numChannels:4);

(
(
Tdef.new(\h,{loop({
//////////////////////////////////////////////////////////////////////////////////////////f

Synth(\oa, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;


	}
)})
);

(
Tdef.new(\i,{loop({
//////////////////////////////////////////////////////////////////////////////////////////

Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oa, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oa, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;



	}
)})
);

(
Tdef.new(\h2,{loop({
//////////////////////////////////////////////////////////////////////////////////////////f

Synth(\ob, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\ob, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;


	}
)})
);

(
Tdef.new(\i2,{loop({
//////////////////////////////////////////////////////////////////////////////////////////

Synth(\ob, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\ob, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;



	}
)})
);
(
Tdef.new(\h3,{loop({
//////////////////////////////////////////////////////////////////////////////////////////f

Synth(\oc, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;


	}
)})
);

(
Tdef.new(\i3,{loop({
//////////////////////////////////////////////////////////////////////////////////////////

Synth(\oc, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\oc, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;

Synth(\oc, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(1).wait;



	}
)})
);
(
Tdef.new(\h4,{loop({
//////////////////////////////////////////////////////////////////////////////////////////f

Synth(\od, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 17,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 19,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 12,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 5,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;


	}
)})
);

(
Tdef.new(\i4,{loop({
//////////////////////////////////////////////////////////////////////////////////////////

Synth(\od, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 9,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 10,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 7,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 2,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;

Synth(\od, [n: 14,decay:1*exprand(2,8), out: (0..3).rotate(4.rand)]);(2).wait;



	}
)})
);
)

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sine

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
////////////////////4th
Tdef(\i).stop;
Tdef(\i).play;
Tdef(\i).clear;
/////////////////5th
Tdef(\h2).stop;
Tdef(\h2).play;
Tdef(\h2).clear;
//////////////////6th
Tdef(\h3).stop;
Tdef(\h3).play;
Tdef(\h3).clear;

/////////////////////////////////////sine

Tdef(\h4).stop;
Tdef(\h4).play;
Tdef(\h4).clear;
////////////////////4th
Tdef(\i2).stop;
Tdef(\i2).play;
Tdef(\i2).clear;
/////////////////5th
Tdef(\i3).stop;
Tdef(\i3).play;
Tdef(\i3).clear;
//////////////////6th
Tdef(\i4).stop;
Tdef(\i4).play;
Tdef(\i4).clear;

(
Tdef.new(\oo,{

	Tdef(\h).play;
	Tdef(\i).play;(4).wait;
	//Tdef(\j).play;(30).wait;

	//Tdef(\h2).play;
	//Tdef(\i2).play;(4).wait;
	//Tdef(\j2).play;(64).wait;

	//Tdef(\h3).play;
	//Tdef(\i3).play;(4).wait;
	//Tdef(\j3).play;(96).wait;

	//Tdef(\h4).play;
	//Tdef(\i4).play;(4).wait;
	//Tdef(\j4).play;
}
)
)

Tdef(\oo).stop;
Tdef(\oo).play;
Tdef(\oo).clear;