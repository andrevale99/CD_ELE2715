--=================================================================
--				COMPARADOR DE 4 BITS
--=================================================================

entity COMP_4BIT is
	port (A, B : in bit_vector(3 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
end COMP_4BIT;

architecture ckt of COMP_4BIT is

signal AmaiorB_aux : bit;
signal AigB_aux : bit;

begin

	AigB_aux <= (A(3) xnor B(3)) and (A(2) xnor B(2)) 
				and (A(1) xnor B(1)) 
				and (A(0) xnor B(0));
	
	
	AmaiorB_aux <= (A(3) and not B(3)) 
				or (A(2) and not B(2) and (A(3) xnor B(3)))
				or (A(1) and not B(1) and (A(3) xnor B(3)) and (A(2) xnor B(2))) 
				or (A(0) and not B(0) and (A(3) xnor B(3)) 
					and (A(2) xnor B(2)) and (A(1) xnor B(1)));

	AmenorB <= AigB_aux nor AmaiorB_aux;

	AigB <= AigB_aux;
	AmaiorB <= AmaiorB_aux;
	

end ckt;

--=================================================================
--				COMPARADOR DE 8 BITS
--=================================================================


entity COMP_8BITS is
	port (A, B : in bit_vector(7 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
end COMP_8BITS;

architecture ckt of COMP_8BITS is

	component COMP_4BIT is
		port (A, B : in bit_vector(3 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
	end component;

	signal A_4LSB : bit_vector(3 downto 0);
	signal A_4MSB : bit_vector(3 downto 0);

	signal B_4LSB : bit_vector(3 downto 0);
	signal B_4MSB : bit_vector(3 downto 0);

	signal LSB_AigB : bit;
	signal MSB_AigB : bit;

	signal LSB_AmaiorB : bit; 
	signal LSB_AmenorB : bit;

	signal MSB_AmaiorB : bit;
	signal MSB_AmenorB : bit;

	begin

		A_4LSB(0) <= A(0);
		A_4LSB(1) <= A(1);
		A_4LSB(2) <= A(2);
		A_4LSB(3) <= A(3);
	
		A_4MSB(0) <= A(4);
		A_4MSB(1) <= A(5);
		A_4MSB(2) <= A(6);
		A_4MSB(3) <= A(7);
	
		B_4LSB(0) <= B(0);
		B_4LSB(1) <= B(1);
		B_4LSB(2) <= B(2);
		B_4LSB(3) <= B(3);
	
		B_4MSB(0) <= B(4);
		B_4MSB(1) <= B(5);
		B_4MSB(2) <= B(6);
		B_4MSB(3) <= B(7);

		LSB : COMP_4BIT port map (A_4LSB, B_4LSB, LSB_AigB, LSB_AmaiorB, LSB_AmenorB);
		MSB : COMP_4BIT port map (A_4MSB, B_4MSB, MSB_AigB, MSB_AmaiorB, MSB_AmenorB);

		AigB <= LSB_AigB and MSB_AigB;
		AmenorB <= (LSB_AmenorB and MSB_AigB) or MSB_AmenorB;
		AmaiorB <= (LSB_AmaiorB and MSB_AigB) or MSB_AmaiorB;		


end ckt;