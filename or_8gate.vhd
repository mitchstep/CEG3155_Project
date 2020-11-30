
entity or_8gate is
port(a,b,c,d,e,f,g,h: in bit; z: out bit);
end entity;

architecture behaviour of or_8gate is
begin
z <= a or b or c or d or e or f or g or h;
end architecture;