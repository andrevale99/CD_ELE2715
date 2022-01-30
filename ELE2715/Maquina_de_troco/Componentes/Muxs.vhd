--===============================
--		MUX de 2 bits de saida
--===============================
entity MUX2B is
	port (	I1, I2 : in bit;
			S : in bit;
			Q : out bit);
end MUX2B;

architecture ckt of MUX2B is

begin

	Q <= (I1 and not S) or (I2 and S);


end ckt;

--===============================
--		MUX de 6 bits de saida
--===============================
entity MUX6B is
	port (	I1, I2 : in bit_vector(5 downto 0);
			S : in bit;
			Q : out bit_vector(5 downto 0));
end MUX6B;

architecture ckt of MUX6B is

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

begin

	Q1 : MUX2B port map (I1(0), I2(0), S, Q(0));
	Q2 : MUX2B port map (I1(1), I2(1), S, Q(1));
	Q3 : MUX2B port map (I1(2), I2(2), S, Q(2));
	Q4 : MUX2B port map (I1(3), I2(3), S, Q(3));
	Q5 : MUX2B port map (I1(4), I2(4), S, Q(4));
	Q6 : MUX2B port map (I1(5), I2(5), S, Q(5));


end ckt;

--===============================
--		MUX de 10 bits de saida
--===============================
entity MUX10B is
	port (	I1, I2 : in bit_vector(9 downto 0);
			S : in bit;
			Q : out bit_vector(9 downto 0));
end MUX10B;

architecture ckt of MUX10B is

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

begin

	Q1 : MUX2B port map (I1(0), I2(0), S, Q(0));
	Q2 : MUX2B port map (I1(1), I2(1), S, Q(1));
	Q3 : MUX2B port map (I1(2), I2(2), S, Q(2));
	Q4 : MUX2B port map (I1(3), I2(3), S, Q(3));
	Q5 : MUX2B port map (I1(4), I2(4), S, Q(4));
	Q6 : MUX2B port map (I1(5), I2(5), S, Q(5));
	Q7 : MUX2B port map (I1(6), I2(6), S, Q(6));
	Q8 : MUX2B port map (I1(7), I2(7), S, Q(7));
	Q9 : MUX2B port map (I1(8), I2(8), S, Q(8));
	Q10 : MUX2B port map (I1(9), I2(9), S, Q(9));


end ckt;