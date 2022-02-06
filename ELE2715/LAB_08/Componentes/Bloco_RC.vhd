--========================================================
--		BLOCO R-C
--========================================================
entity RC is 
	port ( ld_c : in bit;
			clr_r : in bit;
			ld_r : in bit;
			clk : in bit;
			carry : out bit;
			y, c : in bit_vector(3 downto 0);
			yout : out bit_vector(3 downto 0);
			result : out bit_vector(7 downto 0));
end RC;

architecture ckt of RC is

	component REGC is
		port ( C : in bit_vector(3 downto 0);
				clk, en_cod: in bit;
				Cout : out bit_vector(3 downto 0));
	end component;
	
	component REGY is
		port (	Y : in bit_vector(3 downto 0);
				clk, clr_r, ld_r : in bit;
				Yout : out bit_vector(3 downto 0));
	end component;

	component MULT is
		port(A, B : in bit_vector(3 downto 0);
				Co : out bit;
				S : out bit_vector(7 downto 0));
	end component;

	signal saida_regc : bit_vector(3 downto 0);
	signal saida_regy : bit_vector(3 downto 0);

	begin

		VY : REGY port map (y, clk, clr_r, ld_r, saida_regy);
		VC : REGC port map (c, clk, ld_c, saida_regc);

		SAIDA_MULT : MULT port map (saida_regy, saida_regc, carry, result);

	
		yout <= saida_regy;



end ckt;