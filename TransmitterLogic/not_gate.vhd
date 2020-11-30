entity not_gate is
port(a: in bit; z: out bit);
end entity;


architecture behaviour of not_gate is
begin
z <= not a;
end architecture;