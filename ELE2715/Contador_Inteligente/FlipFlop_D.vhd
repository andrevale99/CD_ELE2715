entity latch_d is
	port(d, en : in bit;
			q, qn : inout bit);
end latch_d;

architecture ckt of latch_d is

	signal s : bit;
	signal r : bit;

	begin
		s <= d nand en;
		r <= not d nand en;

		q <= not s or not qn;
		qn <= not r or not q;

end ckt;