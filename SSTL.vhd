entity SSTL is
port(g,MT,SST,SSC,clk: in bit; L2,L1,L0: out bit);
end entity;

architecture structure of SSTL is

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

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

signal S2,S1,S0,notS2,notS1,notS0,notMT,notSST,notSSC,notG: bit;
signal O3,O2_1,O2_2,A2_1,A2_2,A2_3,A3_1,A4_1,A4_2,A4_3,A4_4,A4_5,A4_6: bit;

begin

	NOT_S2: not_gate port map(S2,notS2);
	NOT_S1: not_gate port map(S1,notS1);
	NOT_S0: not_gate port map(S0,notS0);
	NOT_MT: not_gate port map(MT,notMT);
	NOT_SST: not_gate port map(SST,notSST);
	NOT_SSC: not_gate port map(SSC,notSSC);
	NOT_G: not_gate port map(g,notG);

	AND2_1: and2_gate port map(O3,notG,A2_1);
	AND2_2: and2_gate port map(O2_1,notG,A2_2);
	AND2_3: and2_gate port map(O2_2,notG,A2_3);

	AND3_1: and3_gate port map(notS2,notS1,notS0,A3_1);

	AND4_1: and4_gate port map(notMT,S2,notS1,notS0,A4_1);
	AND4_2: and4_gate port map(SST,notS2,S1,notS0,A4_2);
	AND4_3: and4_gate port map(notSST,notS2,S1,notS0,A4_3);
	AND4_4: and4_gate port map(SSC,notS2,notS1,S0,A4_4);
	AND4_5: and4_gate port map(notSSC,notS2,notS1,S0,A4_5);
	AND4_6: and4_gate port map(MT,S2,notS1,notS0,A4_6);

	OR3: or3_gate port map(A4_1,A3_1,A4_2,O3);
	OR2_1: or2_gate port map(A4_3,A4_4,O2_1);
	OR2_2: or2_gate port map(A4_5,A4_6,O2_2);

	DFFS2: rising_edge_dFF port map(A2_1,clk,S2);
	DFFS1: rising_edge_dFF port map(A2_2,clk,S1);
	DFFS0: rising_edge_dFF port map(A2_3,clk,S0);

	L2 <= S2;
	L1 <= S1;
	L0 <= S0;

end architecture;
