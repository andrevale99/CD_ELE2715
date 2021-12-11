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

	signal CRESCENTE : bit;
	signal DECRESCENTE : bit;

	begin
		
		CR : TC_CRES port map (ENTRADA, CRESCENTE);
		DC : TC_DEC port map (ENTRADA, DECRESCENTE);

		ESTOURO : MUX2B port map (CRESCENTE, DECRESCENTE, S);

		Y <= (not S and CRESCENTE) or (S and DECRESCENTE);

end ckt;