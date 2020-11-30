entity TUC is 
port(TLC_TDRE_SET,IRQ,clk: in bit; load_TDR,S2,S1,S0,TDRE_out: out bit); -- TLC_TRDE is the set_TRDE signal that comes from the lower controller
end entity;

architecture structure of TUC is

component TUC_Brain is
port(IRQ,TDRE,CID,clk: in bit; load_TDR: out bit);
end component;

component TUC_Counter is
port(g,clk: in bit; CID,S2,S1,S0: out bit);
end component;

component not_gate is
port(a: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

component or3_gate is
port(a,b,c: in bit; z: out bit);
end component;

component Mult_2to1 is
port(S,A1,A0: in bit; z: out bit);
end component;

component rising_edge_dFF is
port(D,Clk: in bit; Q: out bit);
end component;

signal C2,notC2,CID,mult_upper,mult_lower: bit;

signal mult_or2: bit;

signal spark,TDRE: bit := '1';

begin

	NOT_G: not_gate port map(C2,notC2);

	OR2_Of_Mults: or3_gate port map(mult_upper,TLC_TDRE_SET,spark,mult_or2);

	--DFF_TDRE: rising_edge_dFF port map(mult_or2,clk,TDRE); -- the multiplexer decides whether to update TRDE with itself or with the toggle from the TUC brain

	TDRE <= mult_or2; -- my TDRE flip flop isn't working so I have resorted to this nonesense.

	M_2to1_UPPER: Mult_2to1 port map(C2,notC2,TDRE,mult_upper); -- S = C2, A0 = current value of TRDE, A1 = notC2
	
	--M_2to1_LOWER: Mult_2to1 port map(TLC_TDRE_SET,TLC_TDRE_SET,TDRE,mult_lower); -- this is the multiplexer for the lower controller to toggle TDRE 

	Brain_TUC: TUC_Brain port map(IRQ,TDRE,CID,clk,C2);

	Counter_TUC: TUC_Counter port map(notC2,clk,CID,S2,S1,S0);

	load_TDR <= C2;
	TDRE_out <= TDRE;

	process(clk)
	begin
	if mult_or2 = '1' then
		spark <= '0';
	end if;
	end process;

end architecture;


