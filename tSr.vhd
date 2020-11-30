ENTITY tSr IS
	PORT(
		i_reset, i_load, i_shift, Clk : IN BIT;
		input_vector		 : IN BIT_VECTOR (8 DOWNTO 0);
		output_value		 : OUT BIT;
		out_vector: out bit_vector(8 downto 0)
	    );
END tSr;

ARCHITECTURE rtl OF tSr IS
	SIGNAL int_value: bit_vector(8 downto 0);
	SIGNAL o_value	: bit;
		component rising_edge_dFF is
			port(D,Clk: in bit; Q: out bit);
		end component;
	
BEGIN

		out_vector <= int_value;
		
		process(Clk,i_load)
			begin
				
				if (i_load='1') and (Clk = '1') and (Clk'event) then
				int_value <= input_vector;
				end if;
				
				if(i_shift = '1') and (CLK = '1') and (Clk'event) then
				int_value(8) <= '1';
				int_value(7)<=int_value(8);
				int_value(6)<=int_value(7);
				int_value(5)<=int_value(6);
				int_value(4)<=int_value(5);
				int_value(3)<=int_value(4);
				int_value(2)<=int_value(3);
				int_value(1)<=int_value(2);
				int_value(0)<=int_value(1);
				output_value <= int_value(0);
				end if;
		end process;				
		
		
	
		


		--process(i_load)
		--begin
			--if(i_load = '1' and i_shift = '0') then
				--int_value <= input_vector;
			--end if;
		--end process;

		

		--msb: rising_edge_dFF port map(int_value(8), Clk, int_value(7));
		--eighth: rising_edge_dFF port map(int_value(7), Clk, int_value(6));
		--seventh: rising_edge_dFF port map(int_value(6), Clk, int_value(5));
		--sixth: rising_edge_dFF port map(int_value(5), Clk, int_value(4));
		--fifth: rising_edge_dFF port map(int_value(4), Clk, int_value(3
		--fourth: rising_edge_dFF port map(int_value(3), Clk, int_value(2));
		--third: rising_edge_dFF port map(int_value(2), Clk, int_value(1));
		--second: rising_edge_dFF port map(int_value(1), Clk, int_value(0));
		--lsb: rising_edge_dFF port map(int_value(0), Clk, o_value);

		--output_value <= o_value;
END rtl;
	
