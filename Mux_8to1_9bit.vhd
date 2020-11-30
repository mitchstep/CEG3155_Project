entity Mux_8to1_9bit is
port(
	in0,in1,in2,in3,in4,in5,in6,in7		:in BIT_VECTOR(8 downto 0);
	sel0,sel1,sel2				:in BIT;
	o_output				:out BIT_VECTOR(8 downto 0)
);
end Mux_8to1_9bit;
	
architecture behaviour of Mux_8to1_9bit is

--gates
component not_gate is
	port(
		a: in bit; 
		z: out bit
);
end component;

component and4_gate is
	port(
		a,b,c,d: in bit; 
		z: out bit
);
end component;

component or_8gate is
	port(
		a,b,c,d,e,f,g,h: in bit;
		z: out bit
);
end component;

--signals
	signal notsel2: bit;
	signal notsel1: bit;
	signal notsel0: bit;
	--bit0
	signal 	in_0and_0_out: bit;
	signal 	in_1and_0_out: bit;
	signal 	in_2and_0_out: bit;
	signal 	in_3and_0_out: bit;
	signal 	in_4and_0_out: bit;
	signal 	in_5and_0_out: bit;
	signal 	in_6and_0_out: bit;
	signal 	in_7and_0_out: bit;
	signal 	or_0_out: bit;
	--bit1

	signal 	in_0and_1_out: bit;
	signal 	in_1and_1_out: bit;
	signal 	in_2and_1_out: bit;
	signal 	in_3and_1_out: bit;
	signal 	in_4and_1_out: bit;
	signal 	in_5and_1_out: bit;
	signal 	in_6and_1_out: bit;
	signal 	in_7and_1_out: bit;
	signal 	or_1_out: bit;
	--bit2

	signal 	in_0and_2_out: bit;
	signal 	in_1and_2_out: bit;
	signal 	in_2and_2_out: bit;
	signal 	in_3and_2_out: bit;
	signal 	in_4and_2_out: bit;
	signal 	in_5and_2_out: bit;
	signal 	in_6and_2_out: bit;
	signal 	in_7and_2_out: bit;
	signal 	or_2_out: bit;
	--bit3

	signal in_0and_3_out: bit;
	signal 	in_1and_3_out: bit;
	signal 	in_2and_3_out: bit;
	signal 	in_3and_3_out: bit;
	signal 	in_4and_3_out: bit;
	signal 	in_5and_3_out: bit;
	signal 	in_6and_3_out: bit;
	signal 	in_7and_3_out: bit;
	signal 	or_3_out: bit;
	--bit4

	signal 	in_0and_4_out: bit;
	signal 	in_1and_4_out: bit;
	signal 	in_2and_4_out: bit;
	signal 	in_3and_4_out: bit;
	signal 	in_4and_4_out: bit;
	signal 	in_5and_4_out: bit;
	signal 	in_6and_4_out: bit;
	signal 	in_7and_4_out: bit;
	signal 	or_4_out: bit;
	--bit5

	signal 	in_0and_5_out: bit;
	signal 	in_1and_5_out: bit;
	signal 	in_2and_5_out: bit;
	signal 	in_3and_5_out: bit;
	signal 	in_4and_5_out: bit;
	signal 	in_5and_5_out: bit;
	signal 	in_6and_5_out: bit;
	signal 	in_7and_5_out: bit;
	signal 	or_5_out: bit;
	--bit6

	signal 	in_0and_6_out: bit;
	signal 	in_1and_6_out: bit;
	signal 	in_2and_6_out: bit;
	signal 	in_3and_6_out: bit;
	signal 	in_4and_6_out: bit;
	signal 	in_5and_6_out: bit;
	signal 	in_6and_6_out: bit;
	signal 	in_7and_6_out: bit;
	signal 	or_6_out: bit;
	--bit7

	signal 	in_0and_7_out: bit;
	signal 	in_1and_7_out: bit;
	signal 	in_2and_7_out: bit;
	signal 	in_3and_7_out: bit;
	signal 	in_4and_7_out: bit;
	signal 	in_5and_7_out: bit;
	signal 	in_6and_7_out: bit;
	signal 	in_7and_7_out: bit;
	signal 	or_7_out: bit;
	--bit8

	signal 	in_0and_8_out: bit;
	signal 	in_1and_8_out: bit;
	signal 	in_2and_8_out: bit;
	signal 	in_3and_8_out: bit;
	signal 	in_4and_8_out: bit;
	signal 	in_5and_8_out: bit;
	signal 	in_6and_8_out: bit;
	signal 	in_7and_8_out: bit;
	signal 	or_8_out: bit;
begin

	nots2gate: not_gate port map(sel2,notsel2);
	nots1gate: not_gate port map(sel1,notsel1);
	nots0gate: not_gate port map(sel0,notsel0);
--bit0
	
	in_0and_0:and4_gate port map(in0(0),notsel2,notsel1,notsel0,in_0and_0_out);
	in_1and_0:and4_gate port map(in1(0),notsel2,notsel1,sel0,in_1and_0_out);
	in_2and_0:and4_gate port map(in2(0),notsel2,sel1,notsel0,in_2and_0_out);
	in_3and_0:and4_gate port map(in3(0),notsel2,sel1,sel0,in_3and_0_out);
	in_4and_0:and4_gate port map(in4(0),sel2,notsel1,notsel0,in_4and_0_out);
	in_5and_0:and4_gate port map(in5(0),sel2,notsel1,sel0,in_5and_0_out);
	in_6and_0:and4_gate port map(in6(0),sel2,sel1,notsel0,in_6and_0_out);
	in_7and_0:and4_gate port map(in7(0),sel2,sel1,sel0,in_7and_0_out);

	or_0: or_8gate port map(in_0and_0_out,in_1and_0_out,in_2and_0_out,in_3and_0_out,in_4and_0_out,in_5and_0_out,in_6and_0_out,in_7and_0_out,or_0_out);
--bit1
	in_0and_1:and4_gate port map(in0(1),notsel2,notsel1,notsel0,in_0and_1_out);
	in_1and_1:and4_gate port map(in1(1),notsel2,notsel1,sel0,in_1and_1_out);
	in_2and_1:and4_gate port map(in2(1),notsel2,sel1,notsel0,in_2and_1_out);
	in_3and_1:and4_gate port map(in3(1),notsel2,sel1,sel0,in_3and_1_out);
	in_4and_1:and4_gate port map(in4(1),sel2,notsel1,notsel0,in_4and_1_out);
	in_5and_1:and4_gate port map(in5(1),sel2,notsel1,sel0,in_5and_1_out);
	in_6and_1:and4_gate port map(in6(1),sel2,sel1,notsel0,in_6and_1_out);
	in_7and_1:and4_gate port map(in7(1),sel2,sel1,sel0,in_7and_1_out);

	or_1: or_8gate port map(in_0and_1_out,in_1and_1_out,in_2and_1_out,in_3and_1_out,in_4and_1_out,in_5and_1_out,in_6and_1_out,in_7and_1_out,or_1_out);

--bit2
	in_0and_2:and4_gate port map(in0(2),notsel2,notsel1,notsel0,in_0and_2_out);
	in_1and_2:and4_gate port map(in1(2),notsel2,notsel1,sel0,in_1and_2_out);
	in_2and_2:and4_gate port map(in2(2),notsel2,sel1,notsel0,in_2and_2_out);
	in_3and_2:and4_gate port map(in3(2),notsel2,sel1,sel0,in_3and_2_out);
	in_4and_2:and4_gate port map(in4(2),sel2,notsel1,notsel0,in_4and_2_out);
	in_5and_2:and4_gate port map(in5(2),sel2,notsel1,sel0,in_5and_2_out);
	in_6and_2:and4_gate port map(in6(2),sel2,sel1,notsel0,in_6and_2_out);
	in_7and_2:and4_gate port map(in7(2),sel2,sel1,sel0,in_7and_2_out);

	or_2: or_8gate port map(in_0and_2_out,in_1and_2_out,in_2and_2_out,in_3and_2_out,in_4and_2_out,in_5and_2_out,in_6and_2_out,in_7and_2_out,or_2_out);

--bit3
	in_0and_3:and4_gate port map(in0(3),notsel2,notsel1,notsel0,in_0and_3_out);
	in_1and_3:and4_gate port map(in1(3),notsel2,notsel1,sel0,in_1and_3_out);
	in_2and_3:and4_gate port map(in2(3),notsel2,sel1,notsel0,in_2and_3_out);
	in_3and_3:and4_gate port map(in3(3),notsel2,sel1,sel0,in_3and_3_out);
	in_4and_3:and4_gate port map(in4(3),sel2,notsel1,notsel0,in_4and_3_out);
	in_5and_3:and4_gate port map(in5(3),sel2,notsel1,sel0,in_5and_3_out);
	in_6and_3:and4_gate port map(in6(3),sel2,sel1,notsel0,in_6and_3_out);
	in_7and_3:and4_gate port map(in7(3),sel2,sel1,sel0,in_7and_3_out);

	or_3: or_8gate port map(in_0and_3_out,in_1and_3_out,in_2and_3_out,in_3and_3_out,in_4and_3_out,in_5and_3_out,in_6and_3_out,in_7and_3_out,or_3_out);

--bit4
	in_0and_4:and4_gate port map(in0(4),notsel2,notsel1,notsel0,in_0and_4_out);
	in_1and_4:and4_gate port map(in1(4),notsel2,notsel1,sel0,in_1and_4_out);
	in_2and_4:and4_gate port map(in2(4),notsel2,sel1,notsel0,in_2and_4_out);
	in_3and_4:and4_gate port map(in3(4),notsel2,sel1,sel0,in_3and_4_out);
	in_4and_4:and4_gate port map(in4(4),sel2,notsel1,notsel0,in_4and_4_out);
	in_5and_4:and4_gate port map(in5(4),sel2,notsel1,sel0,in_5and_4_out);
	in_6and_4:and4_gate port map(in6(4),sel2,sel1,notsel0,in_6and_4_out);
	in_7and_4:and4_gate port map(in7(4),sel2,sel1,sel0,in_7and_4_out);

	or_4: or_8gate port map(in_0and_4_out,in_1and_4_out,in_2and_4_out,in_3and_4_out,in_4and_4_out,in_5and_4_out,in_6and_4_out,in_7and_4_out,or_4_out);


--bit5
	in_0and_5:and4_gate port map(in0(5),notsel2,notsel1,notsel0,in_0and_5_out);
	in_1and_5:and4_gate port map(in1(5),notsel2,notsel1,sel0,in_1and_5_out);
	in_2and_5:and4_gate port map(in2(5),notsel2,sel1,notsel0,in_2and_5_out);
	in_3and_5:and4_gate port map(in3(5),notsel2,sel1,sel0,in_3and_5_out);
	in_4and_5:and4_gate port map(in4(5),sel2,notsel1,notsel0,in_4and_5_out);
	in_5and_5:and4_gate port map(in5(5),sel2,notsel1,sel0,in_5and_5_out);
	in_6and_5:and4_gate port map(in6(5),sel2,sel1,notsel0,in_6and_5_out);
	in_7and_5:and4_gate port map(in7(5),sel2,sel1,sel0,in_7and_5_out);

	or_5: or_8gate port map(in_0and_5_out,in_1and_5_out,in_2and_5_out,in_3and_5_out,in_4and_5_out,in_5and_5_out,in_6and_5_out,in_7and_5_out,or_5_out);

--bit6
	in_0and_6:and4_gate port map(in0(6),notsel2,notsel1,notsel0,in_0and_6_out);
	in_1and_6:and4_gate port map(in1(6),notsel2,notsel1,sel0,in_1and_6_out);
	in_2and_6:and4_gate port map(in2(6),notsel2,sel1,notsel0,in_2and_6_out);
	in_3and_6:and4_gate port map(in3(6),notsel2,sel1,sel0,in_3and_6_out);
	in_4and_6:and4_gate port map(in4(6),sel2,notsel1,notsel0,in_4and_6_out);
	in_5and_6:and4_gate port map(in5(6),sel2,notsel1,sel0,in_5and_6_out);
	in_6and_6:and4_gate port map(in6(6),sel2,sel1,notsel0,in_6and_6_out);
	in_7and_6:and4_gate port map(in7(6),sel2,sel1,sel0,in_7and_6_out);

	or_6: or_8gate port map(in_0and_6_out,in_1and_6_out,in_2and_6_out,in_3and_6_out,in_4and_6_out,in_5and_6_out,in_6and_6_out,in_7and_6_out,or_6_out);

--bit7
	in_0and_7:and4_gate port map(in0(7),notsel2,notsel1,notsel0,in_0and_7_out);
	in_1and_7:and4_gate port map(in1(7),notsel2,notsel1,sel0,in_1and_7_out);
	in_2and_7:and4_gate port map(in2(7),notsel2,sel1,notsel0,in_2and_7_out);
	in_3and_7:and4_gate port map(in3(7),notsel2,sel1,sel0,in_3and_7_out);
	in_4and_7:and4_gate port map(in4(7),sel2,notsel1,notsel0,in_4and_7_out);
	in_5and_7:and4_gate port map(in5(7),sel2,notsel1,sel0,in_5and_7_out);
	in_6and_7:and4_gate port map(in6(7),sel2,sel1,notsel0,in_6and_7_out);
	in_7and_7:and4_gate port map(in7(7),sel2,sel1,sel0,in_7and_7_out);

	or_7: or_8gate port map(in_0and_7_out,in_1and_7_out,in_2and_7_out,in_3and_7_out,in_4and_7_out,in_5and_7_out,in_6and_7_out,in_7and_7_out,or_7_out);

--bit8
	in_0and_8:and4_gate port map(in0(8),notsel2,notsel1,notsel0,in_0and_8_out);
	in_1and_8:and4_gate port map(in1(8),notsel2,notsel1,sel0,in_1and_8_out);
	in_2and_8:and4_gate port map(in2(8),notsel2,sel1,notsel0,in_2and_8_out);
	in_3and_8:and4_gate port map(in3(8),notsel2,sel1,sel0,in_3and_8_out);
	in_4and_8:and4_gate port map(in4(8),sel2,notsel1,notsel0,in_4and_8_out);
	in_5and_8:and4_gate port map(in5(8),sel2,notsel1,sel0,in_5and_8_out);
	in_6and_8:and4_gate port map(in6(8),sel2,sel1,notsel0,in_6and_8_out);
	in_7and_8:and4_gate port map(in7(8),sel2,sel1,sel0,in_7and_8_out);

	or_8: or_8gate port map(in_0and_8_out,in_1and_8_out,in_2and_8_out,in_3and_8_out,in_4and_8_out,in_5and_8_out,in_6and_8_out,in_7and_8_out,or_8_out);
	
--output driver
	o_output(0) <= or_0_out;
	o_output(1) <= or_1_out;
	o_output(2) <= or_2_out;
	o_output(3) <= or_3_out;
	o_output(4) <= or_4_out;
	o_output(5) <= or_5_out;
	o_output(6) <= or_6_out;
	o_output(7) <= or_7_out;
	o_output(8) <= or_8_out;

end behaviour;


		
