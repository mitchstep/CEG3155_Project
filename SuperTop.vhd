entity SuperTop is
port(
	logic_clock: in bit; -- is the clock for the transmitter. Goes to Pin_Y2
	KEY0: in bit; -- is the button clock of the traffic lights
	SW: in bit_vector(9 downto 0); -- SW[9] = gReset, SW[8] = SSCS, SW[7-4] = MSC_max, SW[3-0] = SSC_max
	LEDR: out bit_vector(5 downto 0); -- LEDR[5-3] = MSTL, LEDR[2-0] = SSTL
	TXD: out bit -- the serial output of the TSR register. Goes on Pin_G9
);
end entity;

architecture structure of SuperTop is

component TL_Top is -- traffic lights
port(gReset,SSCS,i0_MSC,i1_MSC,i2_MSC,i3_MSC,i0_SSC,i1_SSC,i2_SSC,i3_SSC,clk: in bit; MS0_Green,MS1_Yellow,MS2_Red,SS0_Green,SS1_Yellow,SS2_Red: out bit);
end component;

component TL is -- transmitter logic
port(clk,IRQ: in bit; load_TDR,load_TSR,shift_TSR,S2,S1,S0: out bit);
end component;

component irq_generator is
port(
		i_ms 		: in Bit_vector(2 downto 0);
		i_ss 		: in Bit_vector(2 downto 0);
		clk		: in Bit;
		o_mstl_irq 	: out Bit; 
		o_mstl0 	: out Bit_vector(8 downto 0);
		o_mstl1 	: out Bit_vector(8 downto 0);
		o_mstl2 	: out Bit_vector(8 downto 0);
		o_mstl3 	: out Bit_vector(8 downto 0);
		o_mstl4 	: out Bit_vector(8 downto 0);
		o_mstl5 	: out Bit_vector(8 downto 0)
);
end component;

component Mux_8to1_9bit is
port(
	in0,in1,in2,in3,in4,in5,in6,in7		:in BIT_VECTOR(8 downto 0);
	sel0,sel1,sel2				:in BIT;
	o_output				:out BIT_VECTOR(8 downto 0)
);
end component;

component tSr is 
PORT(
		i_reset, i_load, i_shift, Clk : IN BIT;
		input_vector		 : IN BIT_VECTOR (8 DOWNTO 0);
		output_value		 : OUT BIT;
		out_vector: out bit_vector(8 downto 0)
);
end component;

signal ground: bit_vector(8 downto 0); -- goes into inputs 6 and 7 of the 3-to-8 9 bit Mux
signal irq,S2,S1,S0,load_TDR,load_TSR,shift_TSR: bit; -- inputs and outputs of transmitter logic
signal ss_lights,ms_lights: bit_vector(2 downto 0);
signal mstl_0,mstl_1,mstl_2,mstl_3,mstl_4,mstl_5: bit_vector(8 downto 0);
signal mux_out_vector: bit_vector(8 downto 0);

signal mstl_0_1bit_out,mstl_1_1bit_out,mstl_2_1bit_out,mstl_3_1bit_out,mstl_4_1bit_out,mstl_5_1bit_out: bit; -- mstl least significant bits
signal mstl_0_out,mstl_1_out,mstl_2_out,mstl_3_out,mstl_4_out,mstl_5_out: bit_vector(8 downto 0); -- mstl outputs
signal TDR_out_vector,TSR_out_vector: bit_vector(8 downto 0);
signal TDR_lsb: bit;

begin

	TOP: TL_Top port map(SW(9),SW(8),SW(4),SW(5),SW(6),SW(7),SW(0),SW(1),SW(2),SW(3),KEY0, -- inputs
	ms_lights(0),ms_lights(1),ms_lights(2),ss_lights(0),ss_lights(1),ss_lights(2)); -- outputs

	LEDR(5) <= ms_lights(2);
	LEDR(4) <= ms_lights(1);
	LEDR(3) <= ms_lights(0);
	LEDR(2) <= ss_lights(2);
	LEDR(1) <= ss_lights(1);
	LEDR(0) <= ss_lights(0);

	MSTL0: tSr port map('0',irq,'0',logic_clock,mstl_0,mstl_0_1bit_out,mstl_0_out);
	MSTL1: tSr port map('0',irq,'0',logic_clock,mstl_1,mstl_1_1bit_out,mstl_1_out);
	MSTL2: tSr port map('0',irq,'0',logic_clock,mstl_2,mstl_2_1bit_out,mstl_2_out);
	MSTL3: tSr port map('0',irq,'0',logic_clock,mstl_3,mstl_3_1bit_out,mstl_3_out);
	MSTL4: tSr port map('0',irq,'0',logic_clock,mstl_4,mstl_4_1bit_out,mstl_4_out);
	MSTL5: tSr port map('0',irq,'0',logic_clock,mstl_5,mstl_5_1bit_out,mstl_5_out);

	Mux_3to8_9bit: Mux_8to1_9bit port map (mstl_0_out,mstl_1_out,mstl_2_out,mstl_3_out,mstl_4_out,mstl_5_out,ground,ground,S0,S1,S2,mux_out_vector);

	TDR_Register: tSr port map('0',load_TDR,'0',logic_clock,mux_out_vector, -- in bits
			TDR_lsb,TDR_out_vector); -- out bits
	
	TSR_Register: tSr port map('0',load_TSR,shift_TSR,logic_clock,TDR_out_vector, -- in bits
			TXD,TSR_out_vector); -- out bits

	Generator_IRQ: irq_generator port map(ms_lights,ss_lights,logic_clock, -- in bits
			irq,mstl_0,mstl_1,mstl_2,mstl_3,mstl_4,mstl_5); -- out bits
	
	TransmitterLogic: TL port map(logic_clock,irq, -- in bits
			load_TDR,load_TSR,shift_TSR,S2,S1,S0); -- out bits

	

end architecture;
