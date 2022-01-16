entity MEM6 is
	port (	CLK, CLR : in bit;
		 	I : in bit_vector(5 downto 0);
			S : out bit_vector(5 downto 0));
end MEM6;

architecture ckt of MEM6 is

	component FFD is
		port (clk ,d,set ,clr: in bit;
				q: out bit);
	end component;

begin

	M1 : FFD port map (CLK, I(0), '1', CLR, S(0)); 
	M2 : FFD port map (CLK, I(1), '1', CLR, S(1)); 
	M3 : FFD port map (CLK, I(2), '1', CLR, S(2)); 
	M4 : FFD port map (CLK, I(3), '1', CLR, S(3)); 
	M5 : FFD port map (CLK, I(4), '1', CLR, S(4)); 
	M6 : FFD port map (CLK, I(5), '1', CLR, S(5)); 

end ckt;