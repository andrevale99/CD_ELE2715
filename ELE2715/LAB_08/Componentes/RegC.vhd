--========================================================
--		REGISTRADORES PARA ARMAZENAR 1 VALOR DE C
--========================================================

entity REGC is
	port ( C : in bit_vector(3 downto 0);
			clk, en_cod: in bit;
			Cout : out bit_vector(3 downto 0));
end REGC;

architecture ckt of REGC is

	component MEM4B is
		port (	Y : in bit_vector(3 downto 0);
				clk, clr, ld : in bit;
				Q : out bit_vector(3 downto 0));
	end component;

	begin

		SAIDA : MEM4B port map (C, clk, '1', en_cod, Cout);

end ckt;
