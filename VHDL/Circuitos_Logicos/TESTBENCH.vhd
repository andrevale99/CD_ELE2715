entity ckt_tb is
end ckt_tb;
	
architecture bench of ckt_tb is
	
	component mux2b8 is
		port(	s : in bit;
			i : in bit_vector(7 downto 0);
			y : out bit_vector(7 downto 0));
	end component;

	signal SEL : bit;
	signal I : bit_vector(7 downto 0);

	for barrel : mux2b8 use entity work.mux2b8;

	begin
	
		barrel : mux2b8 port map (i => I, s => SEL);
	
	process
	begin

		I <= "11111111";
		SEL <= '0';
		wait for 100 fs;

		I <= "11111111";
		SEL <= '1';
		wait for 100 fs;


		wait;
	end process;

end bench;