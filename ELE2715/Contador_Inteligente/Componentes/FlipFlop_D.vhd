entity FFD is
	port (clk ,d,set ,clr: in bit;
			q: out bit);
end FFD;

architecture CKT of FFD is
	
signal qs: bit;
begin
	process(clk ,set ,clr)
	begin

		if set = '0' then qs <= '1';
		elsif clr = '0' then qs <= '0';
		elsif clk='1' and clk 'event then
			qs <= d;
	end if;

	end process;

	q <= qs;

end CKT;