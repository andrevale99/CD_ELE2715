--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simulation && gtkwave wave.simulation

entity tb is
end tb;

architecture bench of tb is

	component DEMUX8B is
		port(i : in bit;
         	s : in bit_vector(2 downto 0);
         	q : out bit_vector(7 downto 0));
	end component;

	signal a : bit_vector(7 downto 0);
	signal b : bit_vector(7 downto 0);
	signal I : bit;
	signal S : bit_vector(2 downto 0);

	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--for MUX8 : MUX8B use entity work.MUX8B;

	begin
	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--MUX8 : MUX8B port map (i=>a, s=>S);
	
	
	process
	begin

		
	
		wait;
		end process;

end bench;

