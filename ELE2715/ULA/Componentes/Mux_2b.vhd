--========================================================================
-- 	MUX DE 2 BITS
--========================================================================

entity MUX2B is
	port(s, i0, i1 : in bit;
			y : out bit);
end MUX2B;

architecture ckt of MUX2B is

	begin

		y <= (i0 and not s) or (i1 and s);

end ckt;