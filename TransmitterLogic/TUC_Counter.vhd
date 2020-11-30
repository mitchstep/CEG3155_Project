entity TUC_Counter is
port(g,clk: in bit; CID,S2,S1,S0: out bit);
end entity;

architecture structure of TUC_Counter is

component and4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

component not_gate is 
port(a: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

signal A2,A1,A0,notG,notA2,notA1,notA0,A2_1,A2_2,A2_3,A2_4,A2_5,A2_6,A3_1,A4_1,O3_1,O3_2,O2_1: bit;

begin

	NOT_A2: not_gate port map(A2,notA2);
	NOT_A1: not_gate port map(A1,notA1);
	NOT_A0: not_gate port map(A0,notA0);
	NOT_G: not_gate port map(g,notG);

	AND2_1: and2_gate port map(A2,notA0,A2_1);
	AND2_2: and2_gate port map(A2,g,A2_2);
	AND2_3: and2_gate port map(A1,notA0,A2_3);
	AND2_4: and2_gate port map(A1,g,A2_4);
	AND2_5: and2_gate port map(notA0,notG,A2_5);
	AND2_6: and2_gate port map(A0,g,A2_6);

	AND3_1: and3_gate port map(A1,A0,notG,A3_1);
	
	AND4_1: and4_gate port map(notA2,notA1,A0,notG,A4_1);

	OR2_1: or2_gate port map(A2_5,A2_6,O2_1);

	OR3_1: or3_gate port map(A2_1,A2_2,A3_1,O3_1);
	OR3_2: or3_gate port map(A4_1,A2_3,A2_4,O3_2);

	DFF2: rising_edge_dFF port map(O3_1,clk,A2);
	DFF1: rising_edge_dFF port map(O3_2,clk,A1);
	DFF0: rising_edge_dFF port map(O2_1,clk,A0);

	AND_CID: and2_gate port map(A2,A0,CID);
	
	S2 <= A2;
	S1 <= A1;
	S0 <= A0;	
end architecture;