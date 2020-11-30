entity TL_Top is
port(gReset,SSCS,i0_MSC,i1_MSC,i2_MSC,i3_MSC,i0_SSC,i1_SSC,i2_SSC,i3_SSC,clk: in bit; MS0_Green,MS1_Yellow,MS2_Red,SS0_Green,SS1_Yellow,SS2_Red: out bit);
end entity;

architecture structure of TL_Top is

component comparator_4bit is
port(a0,a1,a2,a3,b0,b1,b2,b3: in bit; z: out bit);
end component;

component SSTL is
port(g,MT,SST,SSC,clk: in bit; L2,L1,L0: out bit);
end component;

component MSTL is
port(MT,MSC,SSCS,SST,g,clk: in bit; L2,L1,L0: out bit);
end component;

component MT_Counter is
port(g,clk: in bit; MT: out bit);
end component;

component MSC_Counter is
port(g,clk: in bit; z0,z1,z2,z3: out bit);
end component;

component nand3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

signal g_MSC,z0_MSC,z1_MSC,z2_MSC,z3_MSC: bit; -- inputs to the MSC counter
signal g_SSC,z0_SSC,z1_SSC,z2_SSC,z3_SSC: bit; -- inputs to the SSC counter
signal MSC,SSC,MT,SST: bit; -- the sequentially controlled input flag bits to the traffic light FSMs
signal z0_MSTL,z1_MSTL,z2_MSTL: bit; -- the MSTL output light bits
signal z0_SSTL,z1_SSTL,z2_SSTL: bit; -- the SSTL output light bits

signal not_z0_MSTL,not_z1_MSTL,not_z2_MSTL: bit;
signal not_z0_SSTL,not_z1_SSTL,not_z2_SSTL: bit;
signal N3_MT,N3_SST,N3_MSC,N3_SSC: bit; -- the nand3 gates going into each corrosponding or2 gate
signal g_MT,g_SST: bit;

begin
	NOT_M0: not_gate port map(z0_MSTL,not_z0_MSTL);
	NOT_M1: not_gate port map(z1_MSTL,not_z1_MSTL);
	NOT_M2: not_gate port map(z2_MSTL,not_z2_MSTL);

	NOT_S0: not_gate port map(z0_SSTL,not_z0_SSTL);
	NOT_S1: not_gate port map(z1_SSTL,not_z1_SSTL);
	NOT_S2: not_gate port map(z2_SSTL,not_z2_SSTL);

	MT_NAND: nand3_gate port map(not_z2_MSTL,z1_MSTL,not_z0_MSTL,N3_MT);
	MT_OR: or2_gate port map(gReset,N3_MT,g_MT);

	SST_NAND: nand3_gate port map(not_z2_SSTL,z1_SSTL,not_z0_SSTL,N3_SST);
	SST_OR: or2_gate port map(gReset,N3_SST,g_SST);

	MSC_NAND: nand3_gate port map(not_z2_MSTL,not_z1_MSTL,z0_MSTL,N3_MSC);
	MSC_OR: or2_gate port map(gReset,N3_MSC,g_MSC);

	SSC_NAND: nand3_gate port map(not_z2_SSTL,not_z1_SSTL,z0_SSTL,N3_SSC);
	SSC_OR: or2_gate port map(gReset,N3_SSC,g_SSC);

	Counter_MT: MT_Counter port map(g_MT,clk,MT); -- counts from 0 to 7. Sets MT = 1 when complete

	Counter_SST: MT_Counter port map(g_SST,clk,SST); -- works the same as Counter_MT

	Counter_MSC: MSC_Counter port map(g_MSC,clk,z0_MSC,z1_MSC,z2_MSC,z3_MSC); -- counts from 0 to 15, or until g_MSC resets it to 0

	Counter_SSC: MSC_Counter port map(g_SSC,clk,z0_SSC,z1_SSC,z2_SSC,z3_SSC); -- works the same as Counter_MSC

	MSC_Comparator: comparator_4bit port map(z0_MSC,z1_MSC,z2_MSC,z3_MSC,i0_MSC,i1_MSC,i2_MSC,i3_MSC,MSC); -- takes in the input counter time and the value of the MSC counter. Outputs MSC = 1 when the two are equal

	SSC_Comparator: comparator_4bit port map(z0_SSC,z1_SSC,z2_SSC,z3_SSC,i0_SSC,i1_SSC,i2_SSC,i3_SSC,SSC); -- works the  same as MSC_Comparator
	
	MSTL_FSM: MSTL port map(MT,MSC,SSCS,SST,gReset,clk,z2_MSTL,z1_MSTL,z0_MSTL);

	SSTL_FSM: SSTL port map(gReset,MT,SST,SSC,clk,z2_SSTL,z1_SSTL,z0_SSTL);

	MS0_Green <= z0_MSTL;
	MS1_Yellow <= z1_MSTL;
	MS2_Red <= z2_MSTL;

	SS0_Green <= z0_SSTL;
	SS1_Yellow <= z1_SSTL;
	SS2_Red <= z2_SSTL;

end architecture;
