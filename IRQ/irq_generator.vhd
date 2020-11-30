Library IEEE;
USE IEEE.Std_logic_1164.all;

ENTITY irq_generator IS
	port(
		i_ms 		: in Bit_vector(2 downto 0);
		i_ss 		: in Bit_vector(2 downto 0);
		clk		: in Bit;
		o_mstl_irq 	: out Bit; 
		o_mstl0 	: out Bit_vector(8 downto 0);
		o_mstl1 	: out Bit_vector(8 downto 0);
		o_mstl2 	: out Bit_vector(8 downto 0);
		o_mstl3 	: out Bit_vector(8 downto 0);
		o_mstl4 	: out Bit_vector(8 downto 0);
		o_mstl5 	: out Bit_vector(8 downto 0));
END irq_generator;

ARCHITECTURE rtl OF irq_generator IS

	SIGNAL S0 : Bit;
	SIGNAL S1 : Bit; 
	SIGNAL C0,C1,C2,C3,C4,C5 : bit;
	SIGNAL interrupt : Bit;

	COMPONENT state_comparator is
		PORT(i_state, CLK: in bit; o_state_change: out bit);
	END COMPONENT;
SIGNAL int_term1, int_term2, int_term3, int0 : bit;
SIGNAL int_norTerm1, int_norTerm2, int_norTerm3 : bit;


BEGIN 
int_term1 <= i_ms(2) AND i_ss(0);
int_term2 <= i_ms(2) AND i_ss(1);
int_term3 <= i_ms(1) AND i_ss(2);

	S1 <= int_term1 OR int_term2;
	S0 <= int_term3 OR int_term2;
	interrupt <= C0 OR C1 OR C2 OR C3 OR C4 OR C5;


	comparator0 : state_comparator
		PORT MAP (
			i_state => i_ms(0),
			CLK => clk,
			o_state_change => C0);

	comparator1 : state_comparator
		PORT MAP (
			i_state => i_ms(1),
			CLK => clk,
			o_state_change => C1);

	comparator2 : state_comparator
		PORT MAP (
			i_state => i_ms(2),
			CLK => clk,
			o_state_change => C2);

	comparator3 : state_comparator
		PORT MAP (
			i_state => i_ss(0),
			CLK => clk,
			o_state_change => C3);

	comparator4 : state_comparator
		PORT MAP (
			i_state => i_ss(1),
			CLK => clk,
			o_state_change => C4);

	comparator5 : state_comparator
		PORT MAP (
			i_state => i_ss(2),
			CLK => clk,
			o_state_change => C5);
	

	--output driver
	o_mstl0 <= "000011011"; 
	o_mstl1 <= "010011010";
	o_mstl2 <= '0' & "11" & (S0 OR S1) & '0' & Not(S1) & (S1 OR Not(S0)) & (NOT(S1) AND NOT(S0)) & (NOT(S1) AND NOT(S0)); 
	o_mstl3 <= "010111110";
	o_mstl4 <= "010100110";
	o_mstl5 <= '0' & "11" & (S0 OR NOT(S1)) & '0' & S1 & (NOT(S1) OR Not(S0)) & (S1 AND NOT(S0)) & (S1 AND NOT(S0));
	o_mstl_irq <= interrupt;
END rtl;