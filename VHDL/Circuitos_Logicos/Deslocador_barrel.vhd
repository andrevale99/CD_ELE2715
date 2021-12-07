entity mux2b is
	port(s, i0, i1 : in bit;
			y : out bit);
end mux2b;

architecture ckt of mux2b is

	begin

		y <= (i0 and not s) or (i1 and s);

end ckt;

entity mux2b8 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end mux2b8;

architecture ckt of mux2b8 is

	component mux2b is
		port(s, i0, i1 : in bit;
				y : out bit);
	end component;

	signal vax : bit_vector(7 downto 0);

	begin

		Q7 : mux2b port map (s, i(7), '0', y(7));
		Q6 : mux2b port map (s, i(6), i(7), y(6));
		Q5 : mux2b port map (s, i(5), i(6), y(5));
		Q4 : mux2b port map (s, i(4), i(5), y(4));
		Q3 : mux2b port map (s, i(3), i(4), y(3));
		Q2 : mux2b port map (s, i(2), i(3), y(2));
		Q1 : mux2b port map (s, i(1), i(2), y(1));
		Q0 : mux2b port map (s, i(0), i(1), y(0));

end ckt;