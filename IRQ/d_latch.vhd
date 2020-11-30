library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_latch is
    Port ( EN : in  BIT;
           D  : in  BIT;
           Q  : out BIT);
end d_latch;

architecture Behavioral of d_latch is
begin
	process (EN, D)
	begin
	    if (EN = '1') then
	        Q <= D;
	    end if;
	end process;
end Behavioral;