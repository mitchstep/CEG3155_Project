entity TLC is
port(clk,TDRE: in bit; load_TSR,shift_TSR,set_TDRE: out bit);
end entity;

architecture structure of TLC is

component TLC_Brain is
port(clk,TSRD,TDRE: in bit; g,load_TSR: out bit);
end component;

component TLC_Counter is
PORT (	clk 	  : IN	bit;
		g   	  : IN	bit;
		TSRD	  : IN	bit;
		set_TDRE  : OUT bit;
		shift_TSR : OUT	bit;
		set_TSRD  : OUT bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

signal TSRD,g: bit;
signal spark: bit := '1';
signal sparked_TDRE: bit;

begin

	Counter_TLC: TLC_Counter port map(clk,g,TSRD, -- in bits
		              set_TDRE,shift_TSR,TSRD); -- out bits

	Brain_TLC: TLC_Brain port map(clk,TSRD,sparked_TDRE, -- in bits 
		  	    g,load_TSR); -- out bits

	Spark_OR2_TDRE: or2_gate port map(TDRE,spark,sparked_TDRE); -- sparking TDRE to start as TDRE = 1

	process(clk)
	begin
	if sparked_TDRE = '1' then
		spark <= '0';
	end if;
	end process;

end architecture;