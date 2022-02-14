--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simu --stop-time=120sec && gtkwave wave.simu

entity tb is
end tb;

architecture bench of tb is

	component MAIN is
		port (	clk : in bit;
				clear : in bit;
				load_cx : in bit;
				iniciar : in bit_vector(3 downto 0);
				troco_real : in bit_vector(9 downto 0);
				load_reg : in bit;
				c1, c2, c3, c4, c5, c6 : in bit_vector(5 downto 0);
				v_temp_out : out bit_vector(9 downto 0));
	end component;

	signal clk : bit := '0';
	signal clear : bit;
	signal load : bit;
	signal ini : bit_vector(3 downto 0);
	signal troco : bit_vector(9 downto 0);
	signal ld_reg : bit;
	signal c1, c2, c3, c4, c5, c6 : bit_vector(5 downto 0);

	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--for MUX8 : MUX8B use entity work.MUX8B;
	for FINAL : MAIN use entity work.MAIN;


	begin
	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--MUX8 : MUX8B port map (i=>a, s=>S);
	FINAL : MAIN port map (clk, clear, load, ini, troco, ld_reg, c1, c2, c3, c4, c5, c6);

	CLOCK : clk <= not clk after 0.0333 sec;
	
	process
	begin

		troco <= "1000011011";

		clear <= '1';

		c1 <= "000111";
		c2 <= "000111";
		c3 <= "000111";
		c4 <= "000111";
		c5 <= "000111";
		c6 <= "000111";

		load <= '1';
		wait for 250 ms;

		load <= '0';
		ini <= "0001";
		wait for 100 ms;


		wait;
		end process;

end bench;