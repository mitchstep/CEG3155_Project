-- compares two vectors of 4 bit length. Returns 1 if the two vectors are the same, 0 if not.
entity comparator_4bit is 
port(a0,a1,a2,a3,b0,b1,b2,b3: in bit; z: out bit);
end entity;

architecture structure of comparator_4bit is

component nxor_gate is
port(a,b: in bit; z: out bit);
end component;

component and4_gate is
port(a,b,c,d: in bit; z: out bit);
end component;

signal nxor_0,nxor_1,nxor_2,nxor_3: bit;

begin

	NXOR_GATE0: nxor_gate port map(a0,b0,nxor_0);
	NXOR_GATE1: nxor_gate port map(a1,b1,nxor_1);
	NXOR_GATE2: nxor_gate port map(a2,b2,nxor_2);
	NXOR_GATE3: nxor_gate port map(a3,b3,nxor_3);

	AND4_1: and4_gate port map(nxor_0,nxor_1,nxor_2,nxor_3,z);

end architecture;
