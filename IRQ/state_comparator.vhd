Library IEEE;
USE IEEE.Std_logic_1164.all;

entity state_comparator is 
   port(i_state, CLK: in bit; o_state_change: out bit);
end state_comparator;



ARCHITECTURE rtl OF state_comparator IS
	SIGNAL next_state : Bit; 

COMPONENT rising_edge_dFF is
		PORT(D,Clk: in bit; Q: out bit);
END COMPONENT;

BEGIN
 	
	DFF1: rising_edge_dFF
	PORT MAP( D => i_state, 
		Clk => CLK,
		Q => next_state);

	--output driver
	o_state_change <= next_state XOR i_state;
	
END rtl; 

