entity FFJK is
	port (clk ,j,k,set ,clr: in bit;
		q: out bit);
end FFJK;


architecture CKT of FFJK is

signal qs: bit;
begin

	process(ck ,set ,clr)
	begin
		if set = ’0’ then qs <= ’1’;
		elsif clr = ’0’ then qs <= ’0’;
		elsif ck=’1’ and ck ’event then
			
			if j = ’1’ and k = ’1’ then qs <= not qs;
			elsif j = ’1’ and k = ’0’ then qs <= ’1’;
			elsif j = ’0’ and k = ’1’ then qs <= ’0’;
			end if;

		end if;
	end process;

	q <= qs;

end CKT;