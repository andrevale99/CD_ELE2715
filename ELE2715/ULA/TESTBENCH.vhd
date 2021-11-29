entity tb is
end tb;

architecture bench of tb is

	component SHFTL is
		port (I : in bit_vector(7 downto 0);
			S : in bit_vector(2 downto 0);
			Y : out bit_vector(7 downto 0);
			C : out bit;
			Z : out bit);
	end component;

	component SHFTR is
		port (I : in bit_vector(7 downto 0);
				S : in bit_vector(2 downto 0);
				Y : out bit_vector(7 downto 0);
				Z : out bit);
	end component;

	component ADD8 is
		port (A, B : in bit_vector(7 downto 0);
				Ci : in bit;
				Co : out bit;
				S : out bit_vector(7 downto 0);
				Z : out bit);
	end component;

	component multi_4_bits is
		port(a, b: in bit_vector (3 downto 0);
			s: out bit_vector (7 downto 0));
	end component;

	signal A : bit_vector(7 downto 0);
	signal SEL : bit_vector(2 downto 0);
	signal F : bit_vector(7 downto 0);
	signal F2 : bit_vector(7 downto 0);

	signal AULA : bit_vector(7 downto 0);
	signal BULA : bit_vector(7 downto 0);
	signal CIULA : bit;
	signal SULA : bit_vector(7 downto 0);
	signal Z : bit;

	signal AMULT : bit_vector(3 downto 0);
	signal BMULT : bit_vector(3 downto 0);

	for DESL_LEFT : SHFTL use entity work.SHFTL;
	for DESL_RIGHT : SHFTR use entity work.SHFTR;
	for SOMA : ADD8 use entity work.ADD8;
	for MULT : multi_4_bits use entity work.multi_4_bits;

	begin

	DESL_LEFT : SHFTL port map (I => A, S => SEL, Y => F);
	DESL_RIGHT : SHFTR port map (I => A, S=> SEL, Y => F2);
	SOMA : ADD8 port map (A => AULA, B => BULA, Ci => CIULA, S => SULA , Z => Z);
	MULT : multi_4_bits port map (a => AMULT, b => BMULT);

	process
	begin
		
		AMULT <= "0010";
		BMULT <= "0100";
		wait for 100 fs;

		wait;
		end process;

end bench;

