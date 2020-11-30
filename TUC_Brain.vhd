entity TUC_Brain is
port(IRQ,TDRE,CID,clk: in bit; load_TDR: out bit);
end entity;

architecture structure of TUC_Brain is

component and3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component not_gate is 
port(a: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

signal A1,A0,A3_1,A3_2,A3_3,A3_4,O3_1,notTDRE,notCID,notA1,notA0: bit;

begin

	NOT_TDRE: not_gate port map(TDRE,notTDRE);
	NOT_CID: not_gate port map(CID,notCID);
	NOT_A1: not_gate port map(A1,notA1);
	NOT_A0: not_gate port map(A0,notA0);

	AND3_1: and3_gate port map(notA1,A0,TDRE,A3_1);
	AND3_2: and3_gate port map(notA1,notA0,IRQ,A3_2);
	AND3_3: and3_gate port map(notA1,A0,notTDRE,A3_3);
	AND3_4: and3_gate port map(A1,notA0,notCID,A3_4);
	OR3_1: or3_gate port map(A3_2,A3_3,A3_4,O3_1);

	DFF1: rising_edge_dFF port map(A3_1,clk,A1);
	DFF0: rising_edge_dFF port map(O3_1,clk,A0);

	load_TDR <= A1; -- this also indicates that the circuit is in state C2

end architecture;
