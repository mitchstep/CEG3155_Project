entity or2_gate is
port(a,b: in bit; z: out bit);
end entity;

architecture behaviour of or2_gate is
begin
z <= a or b;
end architecture;
