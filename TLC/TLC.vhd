ENTITY TLC IS
	PORT (	clk : IN bit;
		load_TDR, TUC_TDRE: IN bit;
		set_TDRE, load_TSR, shift_TSR : OUT bit);
END TLC;

ARCHITECTURE rtl OF TLC IS

COMPONENT TLC_Brain IS
	PORT ( 	clk 		: IN bit;
		TSRD, TDRE	: IN bit;
		load_TSR	: OUT bit;
		g		: OUT bit);
END COMPONENT;

COMPONENT TLC_Counter IS
	PORT (	clk 	  : IN	bit;
		g   	  : IN	bit;
		TSRD	  : IN	bit;
		set_TDRE  : OUT bit;
		shift_TSR : OUT	bit;
		set_TSRD  	  : OUT bit);
END COMPONENT;

SIGNAL int_TSRD : bit;
SIGNAL int_g	    : bit;
SIGNAL int_set_TDRE : bit;

BEGIN

Brain: TLC_Brain PORT MAP(clk, int_TSRD, TUC_TDRE, load_TSR, int_g); 
Counter: TLC_Counter PORT MAP(clk, int_g, int_TSRD, int_set_TDRE, shift_TSR, int_TSRD);

END rtl;
  
