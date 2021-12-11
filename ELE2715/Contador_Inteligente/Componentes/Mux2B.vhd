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