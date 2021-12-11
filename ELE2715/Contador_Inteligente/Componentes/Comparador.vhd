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