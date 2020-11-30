ENTITY TLC_Counter IS
	PORT (	clk 	  : IN	bit;
		g   	  : IN	bit;
		TSRD	  : IN	bit;
		set_TDRE  : OUT bit;
		shift_TSR : OUT	bit;
		set_TSRD  : OUT bit);
END TLC_Counter;

ARCHITECTURE rtl OF TLC_Counter IS

COMPONENT rising_edge_dFF IS
	PORT ( D, Clk: IN bit; Q: OUT bit);
END COMPONENT;

SIGNAL s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11 : bit;
SIGNAL shiftStates : bit;
SIGNAL d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11 : bit;

BEGIN

shiftStates <= s1 OR s2 OR s3 OR s4 OR s5 OR s6 OR s7 OR s8 OR s9 OR s10;

d0 <= (NOT(g) AND NOT(shiftStates)) OR s11;
d1 <= s0 AND g;
d2 <= s1;
d3 <= s2;
d4 <= s3; 
d5 <= s4; 
d6 <= s5; 
d7 <= s6; 
d8 <= s7; 
d9 <= s8; 
d10 <= s9;
d11 <= s10;

DFF0: rising_edge_dFF PORT MAP(d0, clk, s0);
DFF1: rising_edge_dFF PORT MAP(d1, clk, s1);
DFF2: rising_edge_dFF PORT MAP(d2, clk, s2);
DFF3: rising_edge_dFF PORT MAP(d3, clk, s3);
DFF4: rising_edge_dFF PORT MAP(d4, clk, s4);
DFF5: rising_edge_dFF PORT MAP(d5, clk, s5);
DFF6: rising_edge_dFF PORT MAP(d6, clk, s6);
DFF7: rising_edge_dFF PORT MAP(d7, clk, s7);
DFF8: rising_edge_dFF PORT MAP(d8, clk, s8);
DFF9: rising_edge_dFF PORT MAP(d9, clk, s9);
DFF10: rising_edge_dFF PORT MAP(d10, clk, s10);
DFF11: rising_edge_dFF PORT MAP(d11, clk, s11);

	--Output Drivers
	shift_TSR <= shiftStates;
	set_TDRE <= s1;
	set_TSRD <= s11;
	
END rtl;
	
