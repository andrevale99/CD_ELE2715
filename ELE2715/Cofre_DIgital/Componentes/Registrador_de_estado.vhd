--========================================
--			REGISTRADOR DE ESTADO
--========================================

entity REGEST is
	port(	n : in bit_vector(3 downto 0);
			clk: in bit;
			s : out bit_vector(3 downto 0));
end REGEST;

architecture ckt of REGEST is

	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;

	begin

		S0 : FFD port map(clk, n(0), '1', '1', '1', s(0));
		S1 : FFD port map(clk, n(1), '1', '1', '1', s(1));
		S2 : FFD port map(clk, n(2), '1', '1', '1', s(2));
		S3 : FFD port map(clk, n(3), '1', '1', '1', s(3));

end ckt;