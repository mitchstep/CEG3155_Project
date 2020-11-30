entity nand3_gate is
port(a,b,c: in bit; z: out bit);
end entity;

architecture behaviour of nand3_gate is

begin
z <= not (a and b and c);
end architecture;
