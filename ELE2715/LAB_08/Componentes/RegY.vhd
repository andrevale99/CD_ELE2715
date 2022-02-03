--====================================================
--	REGISTRADOR PARA ARMAZENAR 1 VALOR DE Y
--====================================================
entity REGY is
	port (	Y : in bit_vector(3 downto 0);
			clk, clr_r, ld_r : in bit;
			Yout : out bit_vector(3 downto 0));
end REGY;

architecture ckt of REGY is

	component MEM4B is
		port (	Y : in bit_vector(3 downto 0);
				clk, clr, ld : in bit;
				Q : out bit_vector(3 downto 0));
	end component;

	begin 

		SAIDA : MEM4B port map (Y, clk, clr_r, ld_r, Yout);

end ckt;
