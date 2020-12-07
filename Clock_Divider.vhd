library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity Clock_Divider is
port ( clk,reset: in bit;
clock_out: out bit);
end Clock_Divider;
  
architecture bhv of Clock_Divider is
  
signal count: integer:=1;
signal tmp : bit := '0';
  
begin
	process(clk,reset)
	begin
	if(reset='1') then
	count<=1;
	tmp<='0';
	elsif(clk='1') then
	count <=count+1;
	if (count = 5208) then
	tmp <= NOT tmp;
	count <= 1;
	end if;
	end if;
	clock_out <= tmp;
	end process;
  
end bhv;
