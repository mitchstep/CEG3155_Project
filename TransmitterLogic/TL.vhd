entity TL is 
port(clk,IRQ: in bit; load_TDR,load_TSR,shift_TSR,S2,S1,S0: out bit);
end entity;

architecture structure of TL is

component TUC is
port(TLC_TDRE_SET,IRQ,clk: in bit; load_TDR,S2,S1,S0,TDRE_out: out bit);
end component;

component TLC is
port(clk,TDRE: in bit; load_TSR,shift_TSR,set_TDRE: out bit);
end component;

-- note that the TDRE bit is inside the TUC
signal TLC_TDRE_OUT,TUC_TDRE_OUT: bit;

begin

	Upper_Controller: TUC port map(TLC_TDRE_OUT,IRQ,clk, -- in bits
			  	       load_TDR,S2,S1,S0,TUC_TDRE_OUT); -- out bits

	Lower_Controller: TLC port map(clk,TUC_TDRE_OUT, -- in bits
				       load_TSR,shift_TSR,TLC_TDRE_OUT); -- out bits

end architecture;