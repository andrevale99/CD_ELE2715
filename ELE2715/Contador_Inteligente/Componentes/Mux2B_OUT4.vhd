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