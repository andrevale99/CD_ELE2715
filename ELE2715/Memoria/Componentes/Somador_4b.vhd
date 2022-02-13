--===============================================
--				MEIO SOMADOR
--==============================================
entity SMEIO is
	port (A, B : in bit;
			S, Co : out bit);
end SMEIO;

architecture ckt of SMEIO is

	begin 
		S <= A xor B;
		Co <= A and B;

end ckt;

--===============================================
--				SOMADOR COMPLETO
--==============================================

entity SCOMP is
	port( A, B, Ci : in bit;
			Co, S : out bit);
end SCOMP;

architecture ckt of SCOMP is

	begin

		S <= A xor B xor Ci;
		Co <= (A and B) or (A and Ci) or (B and Ci);
		
end ckt;

--===============================================
--				SOMADOR DE 4 BITS
--==============================================

entity ADD4 is
	port(A, B : in bit_vector(3 downto 0);
			Co : out bit;
		 	S : out bit_vector(3 downto 0));
end ADD4;

architecture ckt of ADD4 is

	component SMEIO is
		port (A, B : in bit;
			S, Co : out bit);
	end component;

	component SCOMP is
		port( A, B, Ci : in bit;
			Co, S : out bit);
	end component;

	signal Carry : bit_vector(2 downto 0);

	begin

		R0 : SMEIO port map (A(0), B(0), S(0), Carry(0));
		R1 : SCOMP port map (A(1), B(1), Carry(0), Carry(1), S(1));
		R2 : SCOMP port map (A(2), B(2), Carry(1), Carry(2), S(2));
		R3 : SCOMP port map (A(3), B(3), Carry(2), Co, S(3));
		
end ckt;