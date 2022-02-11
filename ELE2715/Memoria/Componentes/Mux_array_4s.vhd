--============================
--	MUX COM 4 BITS DE SELECAO
--===========================

entity MUX4S is
	port ( I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : in bit;
			S : in bit_vector(3 downto 0);
			Q : out bit);
end MUX4S;

architecture ckt of MUX4S is

begin

	Q <= (I1 and not S(3) and not S(2) and not S(1) and not S(0)) 
		 or (I2 and not S(3) and not S(2) and not S(1) and S(0)) 
		 or (I3 and not S(3) and not S(2) and S(1) and not S(0)) 
		 or (I4 and not S(3) and not S(2) and S(1) and S(0))
		 or (I5 and not S(3) and S(2) and not S(1) and not S(0))
		 or (I6 and not S(3) and S(2) and not S(1) and S(0))
		 or (I7 and not S(3) and S(2) and S(1) and not S(0))
		 or (I8 and not S(3) and S(2) and S(1) and S(0))
		 or (I9 and S(3) and not S(2) and not S(1) and not S(0))
		 or (I10 and S(3) and not S(2) and not S(1) and S(0))
		 or (I11 and S(3) and not S(2) and S(1) and not S(0))
		 or (I12 and S(3) and not S(2) and S(1) and S(0))
		 or (I13 and S(3) and S(2) and not S(1) and not S(0))
		 or (I14 and S(3) and S(2) and not S(1) and S(0))
		 or (I15 and S(3) and S(2) and S(1) and not S(0))
		 or (I16 and S(3) and S(2) and S(1) and S(0));

end ckt;