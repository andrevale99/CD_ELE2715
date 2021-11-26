entity tb is
end tb;

architecture bench of tb is

	component SHFTL is
		port (I : in bit_vector(7 downto 0);
				S : in bit_vector(2 downto 0);
				Y : out bit_vector(7 downto 0));
	end component;

	component SHFTR is
		port (I : in bit_vector(7 downto 0);
				S : in bit_vector(2 downto 0);
				Y : out bit_vector(7 downto 0));
	end component;

	signal A : bit_vector(7 downto 0);
	signal SEL : bit_vector(2 downto 0);
	signal F : bit_vector(7 downto 0);
	signal F2 : bit_vector(7 downto 0);

	for lab : SHFTL use entity work.SHFTL;
	for lab_2 : SHFTR use entity work.SHFTR;

	begin

		lab : SHFTL port map (I => A, S => SEL, Y => F);
		lab_2 : SHFTR port map (I => A, S=> SEL, Y => F2);

	process
	begin

		A <= "11111111";
		SEL <= "000";
		wait for 100 fs;
	
		A <= "11111111";
		SEL <= "010";
		wait for 100 fs;

		A <= "11111111";
		SEL <= "100";
		wait for 100 fs;

		A <= "11111111";
		SEL <= "101";
		wait for 100 fs;

		A <= "11111111";
		SEL <= "110";
		wait for 100 fs;

		wait;
		end process;

end bench;