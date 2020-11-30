entity or4_gate is
port(a,b,c,d: in bit; z: out bit);
end entity;

architecture behaviour of or4_gate is
begin
z <= a or b or c or d;
end architecture;
