entity latch_sr is
	port(s, r :in bit;
		q, qn : inout bit);
end latch_sr;

architecture ckt of latch_sr is

	begin
		q <= (s nand qn);
		qn <= (r nand q);
		
end ckt;