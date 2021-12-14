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

	component BARREL is
		port (S : in bit_vector(2 downto 0);
			I : in bit_vector(7 downto 0);
			Y : out bit_vector(7 downto 0));
	end component;

	signal A : bit_vector(7 downto 0);
	signal B : bit_vector(7 downto 0);
	signal B_3 : bit_vector(2 downto 0);
	signal Cin : bit;

	for SOMA : ADD8 use entity work.ADD8;
	for DESC : BARREL use entity work.BARREL;

	begin

	SOMA : ADD8 port map (A=>A, B=>B, Ci => Cin);
	DESC : BARREL port map (S=>B_3, I=>A);
	
	process
	begin

		
		wait;
		end process;

end bench;

