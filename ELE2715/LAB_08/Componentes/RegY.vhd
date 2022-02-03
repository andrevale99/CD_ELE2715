--====================================================
--	REGISTRADOR PARA ARMAZENAR 1 VALOR DE Y
--====================================================
entity REGY is
	port (	Y : in bit_vector(3 downto 0);
			clk, clr, ld : in bit;
			Yout : out bit_vector(3 downto 0));
end REGY;

architecture ckt of REGY is

	component MEM4B is
		port (	Y : in bit_vector(3 downto 0);
				clk, clr, ld : in bit;
				Q : out bit_vector(3 downto 0));
	end component;

	begin 

		SAIDA : MEM4B port map (Y, clk, clr, ld, Yout);

end ckt;

--====================================================
--	REGISTRADOR PARA ARMAZENAR OS 3 VALORES DE Y
--====================================================

entity REGY3 is
	port ( Y : in bit_vector(3 downto 0);
			clk, clr, ld : bit;
			Yout : out bit_vector(3 downto 0));
end REGY3;

architecture ckt of REGY3 is

	component REGY is
		port (	Y : in bit_vector(3 downto 0);
				clk, clr, ld : in bit;
				Yout : out bit_vector(3 downto 0));
	end component;

	signal t0 : bit_vector(3 downto 0);
	signal t1 : bit_vector(3 downto 0);

	begin

		YT0 : REGY port map (Y, clk, clr, ld, t0);
		YT1 : REGY port map (t0, clk, clr, ld, t1);
		YT2 : REGY port map (t1, clk, clr, ld, Yout);

end ckt ; 

