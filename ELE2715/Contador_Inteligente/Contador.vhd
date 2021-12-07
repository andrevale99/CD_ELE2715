--=================================================================
--				MUX de 2 BITS
--=================================================================
entity MUX2B is
	port (i0, i1, s : in bit;
		 	y : out bit);
end MUX2B;

architecture ckt of MUX2B is

	begin
		y <= (not s and i0) or (s and i1);

end ckt;

--=================================================================
--				MUX de 4 BITS INPUT e 4 BITS OUTPUT
--=================================================================
entity MUX4X4B is
	port (i0, i1 : in bit_vector(3 downto 0);
			s : in bit;
		 	y : out bit_vector(3 downto 0));
end MUX4X4B;

architecture ckt of MUX4X4B is

	component MUX2B is
		port (i0, i1, s : in bit;
				y : out bit);
	end component;

	begin

		S0 : MUX2B port map (i0(0), i1(0), s, y(0));
		S1 : MUX2B port map (i0(1), i1(1), s, y(1));
		S2 : MUX2B port map (i0(2), i1(2), s, y(2));
		S3 : MUX2B port map (i0(3), i1(3), s, y(3));

end ckt;

--=================================================================
--				ESTOURO CRESCENTE E DECRESCENTE
--=================================================================
entity TC_CRES is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_CRES;

architecture ckt of TC_CRES is

	begin
		Y <= I(3) and I(2) and I(1) and I(0);

end ckt;

entity TC_DEC is
	port(I : in bit_vector(3 downto 0);
			Y : out bit);
end TC_DEC;

architecture ckt of TC_DEC is

	begin
		Y <= not (I(3) or I(2) or I(1) or I(0));

end ckt;

--=================================================================
--				SELETOR DO ESTOURO
--=================================================================
entity TC is
	port(ENTRADA : in bit_vector(3 downto 0);
			S : in bit;
			Y : out bit);
end TC;

architecture ckt of TC is

	component MUX2B is
		port (i0, i1, s : in bit;
				 y : out bit);
	end component;

	component TC_CRES is
		port(I : in bit_vector(3 downto 0);
			Y : out bit);
	end component;

	component TC_DEC is
		port(I : in bit_vector(3 downto 0);
			Y : out bit);
	end component;

	signal SAIDA_0 : bit;
	signal SAIDA_1 : bit;

	begin
		
		CR : TC_CRES port map (ENTRADA, SAIDA_0);
		DC : TC_DEC port map (ENTRADA, SAIDA_1);

		ESTOURO : MUX2B port map (SAIDA_0, SAIDA_1, S);

		Y <= (not S and SAIDA_0) or (S and SAIDA_1);

end ckt;

--=================================================================
--				COMPARADOR DE 4 BITS
--=================================================================

entity COMP_4BIT is
	port (A, B : in bit_vector(3 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
end COMP_4BIT;

architecture ckt of COMP_4BIT is

signal AmaiorB_aux : bit;
signal AigB_aux : bit;

begin

	AigB_aux <= (A(3) xnor B(3)) and (A(2) xnor B(2)) 
				and (A(1) xnor B(1)) 
				and (A(0) xnor B(0));
	
	
	AmaiorB_aux <= (A(3) and not B(3)) 
				or (A(2) and not B(2) and (A(3) xnor B(3)))
				or (A(1) and not B(1) and (A(3) xnor B(3)) and (A(2) xnor B(2))) 
				or (A(0) and not B(0) and (A(3) xnor B(3)) 
					and (A(2) xnor B(2)) and (A(1) xnor B(1)));

	AmenorB <= AigB_aux nor AmaiorB_aux;

	AigB <= AigB_aux;
	AmaiorB <= AmaiorB_aux;
	

end ckt;

--==============================================================================================
--				LOGICA DO SOMADOR COMPLETO
--==============================================================================================
entity SCOMP is
	port( A, B, Ci : in bit;
			S, Co : out bit);
end SCOMP;

architecture ckt of SCOMP is

	begin
		S <= A xor B xor Ci;
		Co <= (A and B) or (A and Ci) or (B and Ci);
		
end ckt;


