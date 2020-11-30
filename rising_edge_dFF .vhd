Library IEEE;
USE IEEE.Std_logic_1164.all;

entity rising_edge_dFF is 
   port(D,Clk: in bit; Q: out bit);
end entity;

architecture Behavioral of rising_edge_dFF is  
begin  
 process(Clk)
 begin 
    if Clk = '1' then
    	Q <= D; 
    end if;       
 end process;  
end Behavioral; 
