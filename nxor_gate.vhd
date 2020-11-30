entity nxor_gate is
port(a,b: in bit; z: out bit);
end entity;

architecture behaviour of nxor_gate is

begin
z <= not (a xor b);
end architecture;
