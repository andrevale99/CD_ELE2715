entity tb is
end tb;

architecture bench of tb is

	--COMPONENTES
	component COMP_8BITS is
		port (A, B : in bit_vector(7 downto 0);
			AigB, AmaiorB, AmenorB : out bit);
	end component;
	

	--SINAIS
	signal A : bit_vector(7 downto 0);
	signal B : bit_vector(7 downto 0);
	

	--for DESL_LEFT : SHFTL use entity work.SHFTL;
	for COMP : COMP_8BITS use entity work.COMP_8BITS;

	begin

	--DESL_LEFT : SHFTL port map (I => A, S => SEL, Y => F);
	COMP : COMP_8BITS port map (A => A, B => B);

	process
	begin
		
		A <= "00000000";
		B <= "00000000";
		wait for 10 ns;

		A <= "00010000";
		B <= "00000000";
		wait for 10 ns;
		
		A <= "00010000";
		B <= "00100000";
		wait for 10 ns;


		wait;
		end process;

end bench;

