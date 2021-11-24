-- 7402 quad NOR

entity ci_7402 is
	port ( a, b : in bit_vector(3 downto 0);
		y : out bit_vector(3 downto 0));
end ci_7402;

architecture ckt_7402 of ci_7402 is

	begin

		process(a, b)
		begin
			y(0) <= a(0) nor b(0);
			y(1) <= a(1) nor b(1);
			y(2) <= a(2) nor b(2);
			y(3) <= a(3) nor b(3);

		end process;

end ckt_7402;