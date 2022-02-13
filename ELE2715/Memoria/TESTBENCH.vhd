--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simu --stop-time=10sec && gtkwave wave.simu

entity tb is
end tb;

architecture bench of tb is

	component FIFO is
		port ( clk, wr, rd, clr_fifo : in bit;
				w_data : in bit_vector(12 downto 0);
				empty, full : out bit;
				r_data : out bit_vector(12 downto 0));
	end component;

	signal wr, rd, clr_fifo : bit;
	signal wdata : bit_vector(12 downto 0);

	signal clk: bit := '0'; --CLOCK


	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--for MUX8 : MUX8B use entity work.MUX8B;
	for FF : FIFO use entity work.FIFO;


	begin
	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--MUX8 : MUX8B port map (i=>a, s=>S);
	CLOCK : clk <=  not clk after 0.250 sec;
	FF : FIFO port map (clk=>clk, wr=>wr, rd=>rd, clr_fifo=>clr_fifo, w_data=>wdata);

	process
	begin

		

		clr_fifo <= '1';
		wr <= '0';
		wait for  500 ms;

		wr <= '1';
		wdata <= "0000000000111";
		wait for 500 ms;

		wdata <= "0000000100111";
		wait for 500 ms;

		wdata <= "0000100100111";
		wait for 500 ms;

		wdata <= "0100000100111";
		wait for 500 ms;

		wdata <= "0000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1010110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000111100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;
		
		wdata <= "1000110100111";
		wait for 500 ms;

		wdata <= "1000110100111";
		wait for 500 ms;

		wr <= '0';
		rd <= '1';


		wait;
		end process;

end bench;

