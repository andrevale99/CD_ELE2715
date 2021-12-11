--==============================================================================================
--				LOGICA DO PASSO DECRESCENTE
--==============================================================================================
entity SUBMEIO is
	port (A , B : in bit;
			S, Tout : out bit);
end SUBMEIO;

architecture ckt of SUBMEIO is

	begin
		S <= (not A) and B;
		Tout <= A xor B;

end ckt;

entity SUBCOMP is
	port(A, B : in bit;
		Tin : in bit;
		S : out bit;
		Tout : out bit);
end SUBCOMP;

architecture ckt of SUBCOMP is

	begin
		S <= (A xor B) xor Tin;
		Tout <= ((not A) and B) or ((not A) and Tin) or (B and Tin);
end ckt;

entity SUB4 is
	port (A, B : in bit_vector(3 downto 0);
			Tout : out bit;
			S : out bit_vector(3 downto 0));
end SUB4;

architecture ckt of SUB4 is

	component SUBMEIO is
		port (A , B : in bit;
			S, Tout : out bit);
	end component;

	component SUBCOMP is
		port(A, B : in bit;
		Tin : in bit;
		S : out bit;
		Tout : out bit);
	end component;

	signal Borrow : bit_vector(3 downto 0);

	begin

		R0 : SUBMEIO port map (A(0), B(0), S(0), Borrow(0));
		R1 : SUBCOMP port map (A(1), B(1), Borrow(0), S(1), Borrow(1));
		R2 : SUBCOMP port map (A(2), B(2), Borrow(1), S(2), Borrow(2));
		R3 : SUBCOMP port map (A(3), B(3), Borrow(2), S(3), Borrow(3));

end ckt;
