--=================================================================
--				COMPARADOR DE 4 BITS
--=================================================================

entity COMP8B is
	port (A, B : in bit_vector(7 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
end COMP8B;

architecture ckt of COMP8B is

signal AmaiorB_aux : bit;
signal AigB_aux : bit;

begin

	AigB_aux <= (A(7) xnor B(7)) 
				and	(A(6) xnor B(6))
				and	(A(5) xnor B(5))
				and	(A(4) xnor B(4))
				and (A(3) xnor B(3)) 
				and (A(2) xnor B(2)) 
				and (A(1) xnor B(1)) 
				and (A(0) xnor B(0));
	
	
	AmaiorB_aux <= (A(7) and not B(7))
					or ((A(7) xnor B(7)) and (A(6) and not B(6)))
					or ((A(7) xnor B(7)) and ((A(6) xnor B(6)) and (A(5) and not B(5))))
					or ((A(7) xnor B(7)) and (A(6) xnor B(6)) and ((A(5) xnor B(5))) and (A(4) and not B(4)))
					or ((A(7) xnor B(7)) and (A(6) xnor B(6)) and ((A(5) xnor B(5))) and ((A(4) xnor B(4))) and (A(3) and not B(3)))
					or ((A(7) xnor B(7)) and (A(6) xnor B(6)) and ((A(5) xnor B(5))) and ((A(4) xnor B(4))) and ((A(3) xnor B(3))) and (A(2) and not B(2)))
					or ((A(7) xnor B(7)) and (A(6) xnor B(6)) and (A(5) xnor B(5)) and (A(4) xnor B(4)) and (A(3) xnor B(3)) and (A(2) xnor B(2)) and (A(1) and not B(1)))
					or ((A(7) xnor B(7)) and (A(6) xnor B(6)) and (A(5) xnor B(5)) and (A(4) xnor B(4)) and (A(3) xnor B(3)) and (A(2) xnor B(2)) and (A(1) and not B(1)) and (A(0) and not B(0)));

	AmenorB <= AigB_aux nor AmaiorB_aux;

	AigB <= AigB_aux;
	AmaiorB <= AmaiorB_aux;
	

end ckt;