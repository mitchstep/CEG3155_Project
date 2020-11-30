entity MSC_Counter is
port(g,clk: in bit; z0,z1,z2,z3: out bit);
end entity;

architecture structure of MSC_Counter is

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component and4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component and5_gate is
port(a,b,c,d,e: in bit; z: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

component or4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

signal A3,A2,A1,A0,notA3,notA2,notA1,notA0,notG: bit;
signal A2_1,A3_1,A3_2,A3_3,A3_4,A3_5,A3_6,A3_7,A4_1,A5_1,O4_1,O3_1,O2_1: bit;

begin

	NOT_A3: not_gate port map(A3,notA3);
	NOT_A2: not_gate port map(A2,notA2);
	NOT_A1: not_gate port map(A1,notA1);
	NOT_A0: not_gate port map(A0,notA0);
	NOT_G: not_gate port map(g,notG);

	AND2_1: and2_gate port map(notA0,notG,A2_1);

	AND3_1: and3_gate port map(A3,notA2,notG,A3_1);
	AND3_2: and3_gate port map(A3,notA1,notG,A3_2);
	AND3_3: and3_gate port map(A3,notA0,notG,A3_3);
	AND3_4: and3_gate port map(A2,notA1,notG,A3_4);
	AND3_5: and3_gate port map(A2,notA0,notG,A3_5);
	AND3_6: and3_gate port map(notA1,A0,notG,A3_6);
	AND3_7: and3_gate port map(A1,notA0,notG,A3_7);
	
	AND4_1: and4_gate port map(notA2,A1,A0,notG,A4_1);
	AND5_1: and5_gate port map(notA3,A2,A1,A0,notG,A5_1);

	OR4_1_GATE: or4_gate port map(A3_1,A3_2,A3_3,A5_1,O4_1);
	OR3_1: or3_gate port map(A3_4,A3_5,A4_1,O3_1);
	OR2_1: or2_gate port map(A3_6,A3_7,O2_1);

	DFFA3: rising_edge_dFF port map(O4_1,clk,A3);
	DFFA2: rising_edge_dFF port map(O3_1,clk,A2);
	DFFA1: rising_edge_dFF port map(O2_1,clk,A1);
	DFFA0: rising_edge_dFF port map(A2_1,clk,A0);

	z0 <= A0;
	z1 <= A1;
	z2 <= A2;
	z3 <= A3;

end architecture;