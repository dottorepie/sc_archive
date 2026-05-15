(
{
	var m=0;
	1.do{
		m=m+1;
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*24*10,mul:1/(24*m)),LFSaw.ar(10/24*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*32*10,mul:1/(32*m)),LFSaw.ar(10/32*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*36*10,mul:1/(36*m)),LFSaw.ar(10/36*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*40*10,mul:1/(40*m)),LFSaw.ar(10/40*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*42*10,mul:1/(42*m)),LFSaw.ar(10/42*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*45*10,mul:1/(45*m)),LFSaw.ar(10/45*m)));
	    Out.ar(0,PanAz.ar(2,SinOsc.ar(m*48*10,mul:1/(48*m)),LFSaw.ar(10/48*m)));
	}
}.play)


(
{
	var m=0;
	12.do{
		m=m+1;
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*5*60,mul:1/(5*m)),LFSaw.ar(1/5*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*7*60,mul:1/(7*m)),LFSaw.ar(1/7*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*10*60,mul:1/(10*m)),LFSaw.ar(1/10*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*11*60,mul:1/(11*m)),LFSaw.ar(1/11*m)));
	}
}.play)


(
{
	var m=0,sum,sig1,sig2,sig3;
	sum=PanAz.ar(2,FSinOsc.ar(6*20,mul:1/6),LFSaw.ar(1/6),1,2);
	sum=0;
	12.do{
		m=m+2;
		sig1=PanAz.ar(2,FSinOsc.ar(m*8*20,mul:1/(8*m)),LFSaw.ar(1/8),1,2);
		sig2=PanAz.ar(2,FSinOsc.ar(m*9*20,mul:1/(9*m)),LFSaw.ar(1/9),1,2);
		sig3=PanAz.ar(2,FSinOsc.ar(m*12*20,mul:1/(12*m)),LFSaw.ar(1/12),1,2);
		sum=sum+sig1+sig2+sig3;
	};
	Out.ar(0,sum);
}.play)


(
{
	var m=220,sum,sig1;
	sum=0;
	64.do{
		m=m*(3/2);
		sig1=PanAz.ar(2,FSinOsc.ar(m,mul:1/(m)),LFSaw.ar(1/m),2,2);
		sum=sum+sig1;
	};
	Out.ar(0,sum);
}.play)




(
{
	var m=0,sum,sig1,sig2,sig3,sig4,sig5,sig6,sig7;
	sum=PanAz.ar(2,FSinOsc.ar(6*20,mul:1/6),LFSaw.ar(1/6),1,2);
	12.do{
		m=m+1;
		sig1=PanAz.ar(2,FSinOsc.ar(m*6.75*20,mul:1/(6.75*m)),LFSaw.ar(1/6.75),1,2);
		sig2=PanAz.ar(2,FSinOsc.ar(m*6.75*(9/8)*20,mul:1/(6.75*(9/8)*m)),LFSaw.ar(1/6.75*(9/8)),1,2);
		    sig3=PanAz.ar(2,FSinOsc.ar(m*8*20,mul:1/(8*m)),LFSaw.ar(1/8),1,2);
		    sig4=PanAz.ar(2,FSinOsc.ar(m*9*20,mul:1/(9*m)),LFSaw.ar(1/9),1,2);
			sig5=PanAz.ar(2,FSinOsc.ar(m*10.125*20,mul:1/(10.125*m)),LFSaw.ar(1/10.125),1,2);
		sig6=PanAz.ar(2,FSinOsc.ar(m*10.125*(9/8)*20,mul:1/(10.125*(9/8)*m)),LFSaw.ar(1/10.125*(9/8)),1,2);
		   sig7=PanAz.ar(2,FSinOsc.ar(m*12*20,mul:1/(12*m)),LFSaw.ar(1/12),1,2);
		sum=sum+sig1+sig2+sig3+sig4+sig5+sig6+sig7;
		//sum=sum+sig3+sig4+sig7;
	};
	Out.ar(0,sum);
}.play)





(
{
	var m=1,k=0,sum,sig1,sig2,sig3;
	/sum=PanAz.ar(2,FSinOsc.ar(6*20,mul:1/6),LFSaw.ar(1/6),1,2);
	sum=0;
	3.do{
		k=k+1;
		m=(k+1)/k;
		sig1=PanAz.ar(2,FSinOsc.ar(m*8*20,mul:1/(8*m)),LFSaw.ar(1/(8*m)),1,2);
		sig2=PanAz.ar(2,FSinOsc.ar(m*9*20,mul:1/(9*m)),LFSaw.ar(1/(9*m)),1,2);
		sig3=PanAz.ar(2,FSinOsc.ar(m*12*20,mul:1/(12*m)),LFSaw.ar(1/(2*m)),1,2);
		sum=sum+sig1+sig2+sig3;
	};
	Out.ar(0,sum);
}.play)
///////////////////////////////////////

(
{
	var m=0,sum,sig1,sig2,sig3,k;
	k=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),4,6.linlin(6,12,1,4),mul:1/6),LFSaw.ar(1/6),1,2);
	sum=0;
	1.do{
		m=m+2;
		sig1=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),4,(m*8).linlin(6,12,1,4),mul:1/(8*m)),LFSaw.ar(1/8),1,2);
		sig2=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),4,m*9.linlin(6,12,1,4),mul:1/(9*m)),LFSaw.ar(1/9),1,2);
		sig3=PanAz.ar(2,PitchShift.ar(SoundIn.ar(0),4,m*12.linlin(6,12,1,4),mul:1/(12*m)),LFSaw.ar(1/12),1,2);
		sum=sum+sig1+sig2+sig3;
	};
	Out.ar(0,sum+k);
}.play)

