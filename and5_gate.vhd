entity and5_gate is
port(a,b,c,d,e: in bit; z: out bit);
end entity;

architecture behaviour of and5_gate is
begin
z <= a and b and c and d and e;
end architecture;
