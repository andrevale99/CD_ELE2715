entity  REG4B is
	port (	clk : in bit;
			estados_in : in bit_vector(3 downto 0);
			estados_o : out bit_vector(3 downto 0));
end REG4B;

architecture ckt of REG4B is

	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;

begin

	Q1 : FFD port map(clk, estados_in(0), '1', '1', '1', estados_o(0));
	Q2 : FFD port map(clk, estados_in(1), '1', '1', '1', estados_o(1));
	Q3 : FFD port map(clk, estados_in(2), '1', '1', '1', estados_o(2));
	Q4 : FFD port map(clk, estados_in(3), '1', '1', '1', estados_o(3));

end ckt;