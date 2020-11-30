entity and3_gate is
port(a,b,c: in bit; z: out bit);
end entity;

architecture behaviour of and3_gate is
begin
z <= a and b and c;
end architecture;
