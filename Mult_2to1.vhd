entity Mult_2to1 is
port(S,A1,A0: in bit; z: out bit);
end entity;

architecture structure of Mult_2to1 is

component not_gate is
port(a: in bit; z: out bit);
end component;

component or2_gate is
port(a,b: in bit; z: out bit);
end component;

component and2_gate is
port(a,b: in bit; z: out bit);
end component;

signal notS,A2_1,A2_2,O2_1: bit;

begin

	NOT_S: not_gate port map(S,notS);
	AND2_1: and2_gate port map(A0,notS,A2_1);
	AND2_2: and2_gate port map(A1,S,A2_2);
	OR2_1: or2_gate port map(A2_1,A2_2,O2_1);
	
	z <= O2_1;

end architecture;