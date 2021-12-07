entity tb is
end tb;

architecture bench of tb is

	--COMPONENTES
	component TC is
		port(ENTRADA : in bit_vector(3 downto 0);
				S : in bit;
				Y : out bit);
	end component;
	

	--SINAIS
	signal A : bit_vector(3 downto 0);
	signal SEL : bit;
	

	--for DESL_LEFT : SHFTL use entity work.SHFTL;
	for FINAL : TC use entity work.TC;

	begin

	--DESL_LEFT : SHFTL port map (I => A, S => SEL, Y => F);
	FINAL : TC port map (ENTRADA => A, S => SEL);

	process
	begin

		A <= "1111";
		SEL <= '0';
		wait for 10 ns;

		A <= "1111";
		SEL <= '1';
		wait for 10 ns;

		A <= "0000";
		SEL <= '0';
		wait for 10 ns;

		A <= "0000";
		SEL <= '1';
		wait for 10 ns;

		wait;
		end process;

end bench;

