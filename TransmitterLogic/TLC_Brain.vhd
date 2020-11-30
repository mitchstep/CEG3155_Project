entity TLC_Brain is
port(clk,TSRD,TDRE: in bit; g,load_TSR: out bit);
end entity;

architecture structure of TLC_Brain is

component not_gate is 
port(a: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

signal A1,A0,notA1,notA0,O2_1,A2_1,A2_2,A2_3,A3_1,notTSRD,notTDRE: bit;

begin

	TDRE_NOT: not_gate port map(TDRE,notTDRE);
	TSRD_NOT: not_gate port map(TSRD,notTSRD);
	NOT_A1: not_gate port map(A1,notA1);
	NOT_A0: not_gate port map(A0,notA0);
		
	AND2_1: and2_gate port map(A1,notTSRD,A2_1);
	AND2_2: and2_gate port map(notA1,A0,A2_2);
	AND2_3: and2_gate port map(A1,notA0,A2_3);
	AND3_1: and3_gate port map(notA1,notA0,notTDRE,A3_1);
	OR2_1: or2_gate port map(A0,A2_1,O2_1);

	DFF1: rising_edge_dFF port map(O2_1,clk,A1);
	DFF0: rising_edge_dFF port map(A3_1,clk,A0);

	load_TSR <= A2_2;
	g <= A2_3;

end architecture;