-- 7408 quad AND

entity ci_7408 is
	port (a, b : bit_vector(3 downto 0);
		 y : out bit_vector(3 downto 0));
end ci_7408;


architecture ckt_7408 of ci_7408 is

	begin 

	process(a, b)
	begin

		y(0) <= a(0) and b(0); 
		y(1) <= a(1) and b(1);
		y(2) <= a(2) and b(2);
		y(3) <= a(3) and b(3);

	end process;

end ckt_7408;