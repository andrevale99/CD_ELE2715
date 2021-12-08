entity tb is
end tb;

architecture bench of tb is

	--COMPONENTES
	component TC is
		port(ENTRADA : in bit_vector(3 downto 0);
				S : in bit;
				Y : out bit);
	end component;

	component ADD4 is
		port(A, B : in bit_vector(3 downto 0);
	   			Co : out bit;
				S : out bit_vector(3 downto 0));
	end component;

	component SUB4 is
		port (A, B : in bit_vector(3 downto 0);
			Tout : out bit;
			S : out bit_vector(3 downto 0));
	end component;
	

	--SINAIS
	signal A : bit_vector(3 downto 0);
	signal B : bit_vector(3 downto 0);
	signal SEL : bit;
	

	--for DESL_LEFT : SHFTL use entity work.SHFTL;
	for ESTOURO : TC use entity work.TC;
	for SOMA : ADD4 use entity work.ADD4;
	for SUB : SUB4 use entity work.SUB4;

	begin

	--DESL_LEFT : SHFTL port map (I => A, S => SEL, Y => F);
	ESTOURO : TC port map (ENTRADA => A, S => SEL);
	SOMA : ADD4 port map (A => A, B=>B);
	SUB : SUB4 port map (A=>A, B=> B);

	process
	begin

		A <= "1110";
		B <= "0100";
		wait for 10 fs;

		A <= "1001";
		B <= "0011";
		wait for 10 fs;

		A <= "1111";
		B <= "1111";
		wait for 10 fs;

		A <= "1000";
		B <= "0111";
		wait for 10 fs;

		wait;
		end process;

end bench;

