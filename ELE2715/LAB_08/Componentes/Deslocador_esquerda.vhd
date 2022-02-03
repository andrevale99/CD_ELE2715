--========================================================================
-- DESLOCADOR DE 1
--========================================================================

entity SHFTL_1 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end SHFTL_1;

architecture ckt of SHFTL_1 is

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

	begin

		Q7_1 : MUX2B port map (i(7), i(6), s, y(7));
		Q6_1 : MUX2B port map (i(6), i(5), s, y(6));
		Q5_1 : MUX2B port map (i(5), i(4), s, y(5));
		Q4_1 : MUX2B port map (i(4), i(3), s, y(4));
		Q3_1 : MUX2B port map (i(3), i(2), s, y(3));
		Q2_1 : MUX2B port map (i(2), i(1), s, y(2));
		Q1_1 : MUX2B port map (i(1), i(0), s, y(1));
		Q0_1 : MUX2B port map (i(0), '0' , s, y(0));

		
end ckt;

--========================================================================
-- DESLOCADOR DE 2
--========================================================================

entity SHFTL_2 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end SHFTL_2;

architecture ckt of SHFTL_2 is

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

	begin

		Q7_2 : MUX2B port map (i(7), i(5), s, y(7));
		Q6_2 : MUX2B port map (i(6), i(4), s, y(6));
		Q5_2 : MUX2B port map (i(5), i(3), s, y(5));
		Q4_2 : MUX2B port map (i(4), i(2), s, y(4));
		Q3_2 : MUX2B port map (i(3), i(1), s, y(3));
		Q2_2 : MUX2B port map (i(2), i(0), s, y(2));
		Q1_2 : MUX2B port map (i(1), '0' , s, y(1));
		Q0_2 : MUX2B port map (i(0), '0' , s, y(0));
		
end ckt;

--========================================================================
-- DESLOCADOR BARREL
--========================================================================

entity BARREL_LEFT is
	port (S : in bit_vector(1 downto 0);
			I : in bit_vector(7 downto 0);
			Y : out bit_vector(7 downto 0));
end BARREL_LEFT;

architecture ckt of BARREL_LEFT is

	component SHFTL_1 is
		port(	s : in bit;
				i : in bit_vector(7 downto 0);
				y : out bit_vector(7 downto 0));
	end component;

	component SHFTL_2 is
		port(	s : in bit;
				i : in bit_vector(7 downto 0);
				y : out bit_vector(7 downto 0));
	end component;
	
	signal var_1 : bit_vector(7 downto 0);
	signal var_2 : bit_vector(7 downto 0);

	begin
		B1 : SHFTL_1 port map (S(0), I, var_1);
		B2 : SHFTL_2 port map (S(1), var_1, var_2);

	Y <= var_2;
		
		
end ckt;