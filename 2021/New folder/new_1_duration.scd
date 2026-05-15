








Env.new([0,0.9,0.6,0.6,0],[1],[-4]).plot



attack=;decay=sustain=;release=;

duration = atttack + decay +sustain +release;
envelope=EnvGen.kr(Env.new([0,0.9,0.6,0.6,0],[duration],[tc]),doneAction:2);