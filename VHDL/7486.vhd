-- 7486 quad XOR

entity ci_7486 is
	port ( a, b : in bit_vector(3 downto 0);
		y : out bit_vector(3 downto 0));
end ci_7486;

architecture ckt of ci_7486 is

	begin

		y(0) <= a(0) xor b(0);
		y(1) <= a(1) xor b(1);
		y(2) <= a(2) xor b(2);
		y(3) <= a(3) xor b(3);


end ckt;