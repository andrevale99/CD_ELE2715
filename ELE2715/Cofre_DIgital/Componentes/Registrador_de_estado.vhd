--========================================
--			REGISTRADOR DE ESTADO
--========================================

entity REGEST is
	port(	nx : in bit_vector(3 downto 0);
			clk ,d,set ,clr: in bit;
			sx : out bit_vector(3 downto 0));
end REGEST;

architecture ckt of REGEST is

	component FFD is
		port (	clk ,d,set ,clr: in bit;
				q: out bit);
	end component;

	begin

		S0 : FFD port map(clk, nx(0), set, clr, sx(0));
		S1 : FFD port map(clk, nx(1), set, clr, sx(1));
		S2 : FFD port map(clk, nx(2), set, clr, sx(2));
		S3 : FFD port map(clk, nx(3), set, clr, sx(3));

end ckt;