--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simu--stop-time=10sec && gtkwave wave.simu

entity tb is
end tb;

architecture bench of tb is

	component REG16X13 is
		port (  clk, clr : in bit;
				wd , rd : in bit;
				wd_addr, rd_addr : in bit_vector(3 downto 0);
				wd_data : in bit_vector(12 downto 0);
				rd_data : out bit_vector(12 downto 0));
	end component;

	signal clk: bit := '0'; --CLOCK

	signal clr : bit;
	signal wd, rd : bit;
	signal wd_addr, rd_addr : bit_vector(3 downto 0);
	signal wd_data : bit_vector(12 downto 0);


	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--for MUX8 : MUX8B use entity work.MUX8B;
	for R16x13 : REG16X13 use entity work.REG16X13;


	begin
	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--MUX8 : MUX8B port map (i=>a, s=>S);
	CLOCK : clk <=  not clk after 0.250 sec;
	R16x13 : REG16X13 port map (clk=>clk, clr=>clr, wd=>wd, rd=>rd, wd_addr=>wd_addr, rd_addr=>rd_addr, wd_data=>wd_data);

	process
	begin

		clr <= '1';
		wd_data <= "1111111111111";

		wd <= '1';
		wd_addr <= "0000";
		wait for 1 sec;

		wd_data <= "0101010101010";
		wd <= '1';
		wd_addr <= "0101";
		wait for 1 sec;

		wd_data <= "0000000000011";
		wd <= '1';
		wd_addr <= "1111";
		wait for 1 sec;

		wd <= '0';
		wait for 1 sec;

		rd <= '1';
		rd_addr <= "0000";
		wait for 1 sec;

		rd_addr <= "0001";
		wait for 1 sec;

		rd_addr <= "0101";
		wait for 1 sec;

		rd_addr <= "1111";
		wait for 1 sec;

		rd <= '0';
		rd_addr <= "0000";
		wait for 4 sec;

		clr <= '0';
		wait for 1 sec;


		wait;
		end process;

end bench;

