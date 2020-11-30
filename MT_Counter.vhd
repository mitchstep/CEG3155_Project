entity MT_Counter is
port(g,clk: in bit; MT: out bit);
end entity;

architecture structure of MT_Counter is

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component and4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

signal notG,notA2,notA1,notA0,A2,A1,A0: bit;
signal A2_1,A3_1,A3_2,A3_3,A3_4,A4_1,A4_2,O3_1,O2_1: bit;

begin

	NOT_G: not_gate port map(g,notG);
	NOT_A2: not_gate port map(A2,notA2);
	NOT_A1: not_gate port map(A1,notA1);
	NOT_A0: not_gate port map(A0,notA0);
	
	AND2_1: and2_gate port map(notA0,notG,A2_1);
	AND3_1: and3_gate port map(A2,notA0,notG,A3_1);
	AND3_2: and3_gate port map(A2,notA1,notG,A3_2);
	AND3_3: and3_gate port map(A1,notA0,notG,A3_3);
	AND3_4: and3_gate port map(notA1,A0,notG,A3_4);
	AND4_1: and4_gate port map(notA2,A1,A0,notG,A4_1);
	AND4_2: and4_gate port map(A2,A1,A0,notG,A4_2);
	OR3_1: or3_gate port map(A3_1,A3_2,A4_1,O3_1);
	OR2_1: or2_gate port map(A3_3,A3_4,O2_1);
	
	DFF_A2: rising_edge_dFF port map(O3_1,clk,A2);
	DFF_A1: rising_edge_dFF port map(O2_1,clk,A1);
	DFF_A0: rising_edge_dFF port map(A2_1,clk,A0);

	MT <= A4_2;
end architecture;