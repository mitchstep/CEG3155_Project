entity and2_gate is
port(a,b: in bit; z: out bit);
end entity;

architecture behaviour of and2_gate is
begin
z <= a and b;
end architecture;
