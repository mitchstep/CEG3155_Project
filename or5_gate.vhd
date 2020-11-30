entity or5_gate is
port(a,b,c,d,e: in bit; z: out bit);
end entity;

architecture behaviour of or5_gate is
begin
z <= a or b or c or d or e;
end architecture;