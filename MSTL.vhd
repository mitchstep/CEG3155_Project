entity MSTL is
port(MT,MSC,SSCS,SST,g,clk: in bit; L2,L1,L0: out bit);
end entity;

architecture structure of MSTL is

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component and4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

signal A2_1,A2_2,A2_3,A3_1,A3_2,A4_1,A4_2,A4_3,A4_4,A4_5,A4_6,A4_7,O2,O3,O4: bit;
signal A3_1_L0,A3_2_L0: bit;
signal notM2,notM1,notM0: bit;
signal notMT,notSST,notMSC,notSSCS,notG: bit;
signal M2,M1,M0: bit;

begin

	NOT_M2: not_gate port map(M2,notM2);
	NOT_M1: not_gate port map(M1,notM1);
	NOT_M0: not_gate port map(M0,notM0);
	NOT_MT: not_gate port map(MT,notMT);
	NOT_SST: not_gate port map(SST,notSST);
	NOT_MSC: not_gate port map(MSC,notMSC);
	NOT_SSCS: not_gate port map(SSCS,notSSCS);
	NOT_G: not_gate port map(g,notG);

	AND2_1: and2_gate port map(notG,O2,A2_1);
	AND2_2: and2_gate port map(notG,O3,A2_2);
	AND2_3: and2_gate port map(notG,O4,A2_3);

	AND3_1: and3_gate port map(notM2,notM1,M0,A3_1);
	AND3_2: and3_gate port map(notM2,notM1,notM0,A3_2);

	AND4_1: and4_gate port map(MT,notM2,M1,notM0,A4_1);
	AND4_2: and4_gate port map(notSST,M2,notM1,notM0,A4_2);
	AND4_3: and4_gate port map(notMT,notM2,M1,notM0,A4_3);
	AND4_4: and4_gate port map(SSCS,notM2,M1,M0,A4_4);
	AND4_5: and4_gate port map(MSC,notM2,notM1,M0,A4_5);
	AND4_6: and4_gate port map(SST,M2,notM1,notM0,A4_6);
	AND4_7: and4_gate port map(notSSCS,notM2,M1,M0,A4_7);

	OR2: or2_gate port map(A4_1,A4_2,O2);
	OR3: or3_gate port map(A4_3,A4_4,A4_5,O3);
	OR4: or4_gate port map(A3_1,A4_6,A4_7,A3_2,O4);

	DFF_M2: rising_edge_dFF port map(A2_1,clk,M2);
	DFF_M1: rising_edge_dFF port map(A2_2,clk,M1);
	DFF_M0: rising_edge_dFF port map(A2_3,clk,M0);

	A3_L2: and3_gate port map(M2,notM1,notM0,L2);
	A3_L1: and3_gate port map(notM2,M1,notM0,L1);

	A3_1L0: and3_gate port map(notM2,notM1,M0,A3_1_L0);
	A3_2L0: and3_gate port map(notM2,M1,M0,A3_2_L0);
	O2_L0: or2_gate port map(A3_1_L0,A3_2_L0,L0);

end architecture;