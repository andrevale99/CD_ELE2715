--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simulation && gtkwave wave.simulation

entity tb is
end tb;

architecture bench of tb is

	component MULT is
		port(A, B : in bit_vector(7 downto 0);
				Co : out bit;
				S : out bit_vector(7 downto 0));
	end component;

	signal a : bit_vector(7 downto 0);
	signal b : bit_vector(7 downto 0);

	for MUMU : MULT use entity work.MULT;

	begin

	MUMU : MULT port map (A=>a, B=>b);
	
	process
	begin

		a <= "00001001";
		b <= "00001001";
		wait for 10 ns;


		wait;
		end process;

end bench;

