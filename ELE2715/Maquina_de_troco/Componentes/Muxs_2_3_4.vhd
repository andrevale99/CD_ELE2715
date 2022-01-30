--============================
--	MUX COM 2 BITS DE SELECAO
--===========================

entity MUX2S is
	port ( I1, I2, I3, I4 : in bit;
			S : in bit_vector(1 downto 0);
			Q : out bit);
end MUX2S;

architecture ckt of MUX2S is

begin

	Q <= (I1 and not S(1) and not S(0)) 
		 or (I2 and not S(1) and S(0)) 
		 or (I3 and S(1) and not S(0)) 
		 or (I4 and S(1) and S(0));

end ckt;

--============================
--	MUX COM 3 BITS DE SELECAO
--===========================

entity MUX3S is
	port ( I1, I2, I3, I4, I5, I6, I7, I8 : in bit;
			S : in bit_vector(2 downto 0);
			Q : out bit);
end MUX3S;

architecture ckt of MUX3S is

begin

	Q <= (I1 and not S(2) and not S(1) and not S(0)) 
		 or (I2 and not S(1) and not S(1) and S(0)) 
		 or (I3 and not S(2) and S(1) and not S(0)) 
		 or (I4 and not S(2) and S(1) and S(0))
		 or (I5 and S(2) and not S(1) and not S(0))
		 or (I6 and S(2) and not S(1) and S(0))
		 or (I7 and S(2) and S(1) and not S(0))
		 or (I8 and S(2) and S(1) and S(0));

end ckt;

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

--===========================================================
-- MUX ARRAY 4 BITS INPUT COM 2 BITS DE SELECAO
--===========================================================

entity MUX4B2S is
	port ( I1, I2, I3, I4 : in bit_vector(3 downto 0);
			S : in bit_vector(1 downto 0);
			Q : out bit_vector(3 downto 0));
end MUX4B2S;

architecture ckt of MUX4B2S is

	component MUX2S is
		port ( I1, I2, I3, I4 : in bit;
				S : in bit_vector(1 downto 0);
				Q : out bit);
	end component;

begin 

		Q1 : MUX2S port map (I1(0), I2(0), I3(0), I4(0), S, Q(0));
		Q2 : MUX2S port map (I1(1), I2(1), I3(1), I4(1), S, Q(1));
		Q3 : MUX2S port map (I1(2), I2(2), I3(2), I4(2), S, Q(2));
		Q4 : MUX2S port map (I1(3), I2(3), I3(3), I4(3), S, Q(3));

end ckt;

--===========================================================
-- MUX ARRAY 4 BITS INPUT COM 4 BITS DE SELECAO
--===========================================================

entity MUX4B4S is
	port ( I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : in bit_vector(3 downto 0);
			S : in bit_vector(3 downto 0);
			Q : out bit_vector(3 downto 0));
end MUX4B4S;

architecture ckt of MUX4B4S is

	component MUX4S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16 : in bit;
				S : in bit_vector(3 downto 0);
				Q : out bit);
	end component;
	

begin 

		Q1 : MUX4S port map (I1(0), I2(0), I3(0), I4(0), I5(0), I6(0), I7(0), I8(0), I9(0), I10(0), I11(0), I12(0), I13(0), I14(0), I15(0), I16(0), S, Q(0));
		Q2 : MUX4S port map (I1(1), I2(1), I3(1), I4(1), I5(1), I6(1), I7(1), I8(1), I9(1), I10(1), I11(1), I12(1), I13(1), I14(1), I15(1), I16(1), S, Q(1));
		Q3 : MUX4S port map (I1(2), I2(2), I3(2), I4(2), I5(2), I6(2), I7(2), I8(2), I9(2), I10(2), I11(2), I12(2), I13(2), I14(2), I15(2), I16(2), S, Q(2));
		Q4 : MUX4S port map (I1(3), I2(3), I3(3), I4(3), I5(3), I6(3), I7(3), I8(3), I9(3), I10(3), I11(3), I12(3), I13(3), I14(3), I15(3), I16(3), S, Q(3));

end ckt;

--===========================================================
-- MUX ARRAY 10 BITS INPUT COM 3 BITS DE SELECAO
--===========================================================

entity MUX10B3S is
	port ( I1, I2, I3, I4, I5, I6, I7, I8 : in bit_vector(9 downto 0);
			S : in bit_vector(2 downto 0);
			Q : out bit_vector(9 downto 0));
end MUX10B3S;

architecture ckt of MUX10B3S is

	component MUX3S is
		port ( I1, I2, I3, I4, I5, I6, I7, I8 : in bit;
				S : in bit_vector(2 downto 0);
				Q : out bit);
	end component;

begin 

		Q1 : MUX3S port map(I1(0), I2(0), I3(0), I4(0), I5(0), I6(0), I7(0), I8(0), S, Q(0));
		Q2 : MUX3S port map(I1(1), I2(1), I3(1), I4(1), I5(1), I6(1), I7(1), I8(1), S, Q(1));
		Q3 : MUX3S port map(I1(2), I2(2), I3(2), I4(2), I5(2), I6(2), I7(2), I8(2), S, Q(2));
		Q4 : MUX3S port map(I1(3), I2(3), I3(3), I4(3), I5(3), I6(3), I7(3), I8(3), S, Q(3));
		Q5 : MUX3S port map(I1(4), I2(4), I3(4), I4(4), I5(4), I6(4), I7(4), I8(4), S, Q(4));
		Q6 : MUX3S port map(I1(5), I2(5), I3(5), I4(5), I5(5), I6(5), I7(5), I8(5), S, Q(5));
		Q7 : MUX3S port map(I1(6), I2(6), I3(6), I4(6), I5(6), I6(6), I7(6), I8(6), S, Q(6));
		Q8 : MUX3S port map(I1(7), I2(7), I3(7), I4(7), I5(7), I6(7), I7(7), I8(7), S, Q(7));
		Q9 : MUX3S port map(I1(8), I2(8), I3(8), I4(8), I5(8), I6(8), I7(8), I8(8), S, Q(8));
	   Q10 : MUX3S port map(I1(9), I2(9), I3(9), I4(9), I5(9), I6(9), I7(9), I8(9), S, Q(9));

	

end ckt;