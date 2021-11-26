--7404 - 6 HEX inverters

entity ci_7404 is
	port ( a : in bit_vector(5 downto 0);
		 y : out bit_vector(5 downto 0));
end ci_7404;

architecture ckt of ci_7404 is

	begin 

	y(0) <= not a(0);
	y(1) <= not a(1);
	y(2) <= not a(2);
	y(3) <= not a(3);
	y(4) <= not a(4);
	y(5) <= not a(5);

	

end ckt;