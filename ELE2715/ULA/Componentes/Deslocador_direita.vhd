--========================================================================
-- DESLOCADOR DE 1
--========================================================================

entity SHFTR_1 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end SHFTR_1;

architecture ckt of SHFTR_1 is

	component MUX2B is
		port(s, i0, i1 : in bit;
				y : out bit);
	end component;

	begin

		Q7_1 : MUX2B port map (s, i(7), '0',  y(7));
		Q6_1 : MUX2B port map (s, i(6), i(7), y(6));
		Q5_1 : MUX2B port map (s, i(5), i(6), y(5));
		Q4_1 : MUX2B port map (s, i(4), i(5), y(4));
		Q3_1 : MUX2B port map (s, i(3), i(4), y(3));
		Q2_1 : MUX2B port map (s, i(2), i(3), y(2));
		Q1_1 : MUX2B port map (s, i(1), i(2), y(1));
		Q0_1 : MUX2B port map (s, i(0), i(1), y(0));

		
end ckt;

--========================================================================
-- DESLOCADOR DE 2
--========================================================================

entity SHFTR_2 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end SHFTR_2;

architecture ckt of SHFTR_2 is

	component MUX2B is
		port(s, i0, i1 : in bit;
				y : out bit);
	end component;

	begin

		Q7_2 : MUX2B port map (s, i(7), '0',  y(7));
		Q6_2 : MUX2B port map (s, i(6), '0',  y(6));
		Q5_2 : MUX2B port map (s, i(5), i(7), y(5));
		Q4_2 : MUX2B port map (s, i(4), i(6), y(4));
		Q3_2 : MUX2B port map (s, i(3), i(5), y(3));
		Q2_2 : MUX2B port map (s, i(2), i(4), y(2));
		Q1_2 : MUX2B port map (s, i(1), i(3), y(1));
		Q0_2 : MUX2B port map (s, i(0), i(2), y(0));
		
end ckt;

--========================================================================
-- DESLOCADOR DE 4
--========================================================================

entity SHFTR_4 is
	port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
end SHFTR_4;

architecture ckt of SHFTR_4 is

	component MUX2B is
		port(s, i0, i1 : in bit;
				y : out bit);
	end component;

	begin

		Q7_4 : MUX2B port map (s, i(7), '0',  y(7));
		Q6_4 : MUX2B port map (s, i(6), '0',  y(6));
		Q5_4 : MUX2B port map (s, i(5), '0', y(5));
		Q4_4 : MUX2B port map (s, i(4), '0', y(4));
		Q3_4 : MUX2B port map (s, i(3), i(7), y(3));
		Q2_4 : MUX2B port map (s, i(2), i(6), y(2));
		Q1_4 : MUX2B port map (s, i(1), i(5), y(1));
		Q0_4 : MUX2B port map (s, i(0), i(4), y(0));
		
end ckt;

--========================================================================
-- DESLOCADOR BARREL
--========================================================================

entity BARREL is
	port (S : in bit_vector(2 downto 0);
			I : in bit_vector(7 downto 0);
			Y : out bit_vector(7 downto 0));
end BARREL;

architecture ckt of BARREL is

	component SHFTR_1 is
		port(	s : in bit;
				i : in bit_vector(7 downto 0);
				y : out bit_vector(7 downto 0));
	end component;

	component SHFTR_2 is
		port(	s : in bit;
				i : in bit_vector(7 downto 0);
				y : out bit_vector(7 downto 0));
	end component;

	component SHFTR_4 is
		port(	s : in bit;
				i : in bit_vector(7 downto 0);
				y : out bit_vector(7 downto 0));
	end component;
	
	signal var_1 : bit_vector(7 downto 0);
	signal var_2 : bit_vector(7 downto 0);
	signal var_4 : bit_vector(7 downto 0);

	begin
		B1 : SHFTR_1 port map (S(0), I, var_1);
		B2 : SHFTR_2 port map (S(1), var_1, var_2);
		B4 : SHFTR_4 port map (S(2), var_2, var_4);

	Y <= var_4;
		
		
end ckt;