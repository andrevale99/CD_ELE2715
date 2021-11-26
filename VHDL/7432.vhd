-- 7432 quad OR

entity ci_7432 is
	port(a, b : in bit_vector(3 downto 0);
		y : out bit_vector(3 downto 0));
end ci_7432;

architecture ckt of ci_7432 is

	begin

		y(0) <= a(0) or b(0);
		y(1) <= a(1) or b(1);
		y(2) <= a(2) or b(2);
		y(3) <= a(3) or b(3);
			
		

end ckt;