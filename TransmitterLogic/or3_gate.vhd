entity or3_gate is
port(a,b,c: in bit; z: out bit);
end entity;

architecture behaviour of or3_gate is
begin
z <= a or b or c;
end architecture;
