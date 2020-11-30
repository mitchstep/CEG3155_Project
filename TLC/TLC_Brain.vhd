ENTITY TLC_Brain IS
	PORT ( 	clk 		: IN bit;
		TSRD, TDRE	: IN bit;
		set_TDRE	: OUT bit;
		load_TSR	: OUT bit;
		g		: OUT bit);
END TLC_Brain;

ARCHITECTURE rtl OF TLC_Brain IS

COMPONENT rising_edge_dFF IS
	PORT ( D, Clk: IN bit; Q: OUT bit);
END COMPONENT;

SIGNAL int_c0, int_c1 : bit;
SIGNAL int_q0, int_q1 : bit;

BEGIN

int_c0 <= TSRD OR (int_c0 AND TDRE);
int_c1 <= (int_c0 AND NOT(TDRE)) OR NOT(TSRD);

DFF0: rising_edge_dFF 
	PORT MAP(int_c0, clk, int_q0);

DFF1: rising_edge_dFF
	PORT MAP(int_c1, clk, int_q1);

	--Output Drivers
	load_TSR <= int_q1;
	g <= int_q0;
		  
END rtl;
