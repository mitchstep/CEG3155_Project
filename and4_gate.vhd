entity and4_gate is
port(a,b,c,d: in bit; z: out bit);
end entity;

architecture behaviour of and4_gate is
begin
z <= a and b and c and d;
end architecture;
