--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simulation && gtkwave wave.simulation

entity tb is
end tb;

architecture bench of tb is

	component ADD8 is
		port (A, B : in bit_vector(7 downto 0);
				Ci : in bit;
				Co : out bit;
				S : out bit_vector(7 downto 0);
				Z : out bit);
	end component;

	component BARREL_RIGHT is
		port (S : in bit_vector(2 downto 0);
			I : in bit_vector(7 downto 0);
			Y : out bit_vector(7 downto 0));
	end component;

	component BARREL_LEFT is
		port (S : in bit_vector(2 downto 0);
			I : in bit_vector(7 downto 0);
			Y : out bit_vector(7 downto 0));
	end component;

	component SUB8 is
		port (A, B : in bit_vector(7 downto 0);
				Ti : in bit;
				Tout : out bit;
				S : out bit_vector(7 downto 0));
	end component;

	signal A : bit_vector(7 downto 0);
	signal B : bit_vector(7 downto 0);
	signal B_3 : bit_vector(2 downto 0);
	signal Cin : bit;

	for SOMA : ADD8 use entity work.ADD8;
	for SUB : SUB8 use entity work.SUB8;
	for DESC_L : BARREL_LEFT use entity work.BARREL_LEFT;
	for DESC_R : BARREL_RIGHT use entity work.BARREL_RIGHT;


	begin

	SOMA : ADD8 port map (A=>A, B=>B, Ci => Cin);
	SUB : SUB8 port map (A=>A, B=>B, Ti => '0');
	DESC_L : BARREL_LEFT port map (S=>B_3, I=>A);
	DESC_R : BARREL_RIGHT port map (S=>B_3, I=>A);
	
	process
	begin

		A <= "11111111";
		B <= "10000001";
		wait for 10 ns;

		A <= "00000111";
		B <= "00000011";
		wait for 10 ns;

		wait;
		end process;

end bench;

