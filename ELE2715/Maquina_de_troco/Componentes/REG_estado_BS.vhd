--==========================================
-- REGISTRADOR DE ESTADO PARA O BOTAO BS
--==========================================

entity REGBS is
	port(	clk, en : in bit;
			n: in bit_vector(1 downto 0);
			s : out bit_vector(1 downto 0));
end REGBS;

architecture ckt of REGBS is
 
	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;

	begin

		SAIDA_1 : FFD port map(clk, n(0), '1', '1', en, s(0));
		SAIDA_2 : FFD port map(clk, n(1), '1', '1', en, s(1));

end ckt ; 