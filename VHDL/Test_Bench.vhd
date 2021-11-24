entity ckt_tb is
end ckt_tb;
	
architecture bench of ckt_tb is
	component ck7404 is
		port ( a : in bit_vector(5 downto 0);
		 	y : out bit_vector(5 downto 0));
	end component;

	component ck7402 is
		port ( a, b : in bit_vector(3 downto 0);
			 	y : out bit_vector(3 downto 0));
	end component;
	
	signal A : bit_vector(5 downto 0);
    signal Y : bit_vector(5 downto 0);

	signal A7402 : bit_vector(3 downto 0);
	signal B7402 : bit_vector(3 downto 0);
	signal Y7402 : bit_vector(3 downto 0);

	for lab : ck7404 use entity work.ci_7404;
	for lab_2 : ck7402 use entity work.ci_7402;
	
	begin
		lab : ck7404
		port map ( a => A, y => Y);

		lab_2 : ck7402
		port map ( a => A7402 , b => B7402  , y => Y7402);
	
	process
	begin
		A <= "111111";
		A7402 <= "0000";
		B7402 <= "0000";
		wait for 100 ms;

		A7402 <= "1010";
		B7402 <= "0011";
		A <= "010101";
		wait for 100 ms;
		wait;
	end process;

end bench;