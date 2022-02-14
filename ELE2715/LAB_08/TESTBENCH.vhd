--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH.vhd && ghdl -e tb && ghdl -r tb --vcd=wave.simu --stop-time=120sec && gtkwave wave.simu

entity tb is
end tb;

architecture bench of tb is

	component FILT is
		port ( ld_out : in bit;
				s_cod : in bit_vector(1 downto 0);
				en_cod : in bit;
				clr_r : in bit;
				ld_r : in bit;
				clk : in bit;
				y : in bit_vector(3 downto 0);
				c : in bit_vector(3 downto 0);
				F : out bit_vector(9 downto 0));
	end component;

	signal clk : bit := '0';

	signal ldout : bit;
	signal scod : bit_vector(1 downto 0);
	signal encod : bit;
	signal clrr : bit;
	signal ldr : bit;
	signal y : bit_vector(3 downto 0);
	signal c : bit_vector(3 downto 0);

	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--for MUX8 : MUX8B use entity work.MUX8B;
	for FI : FILT use entity work.FILT;



	begin
	--EXEMPLO de como criar os componentes para visualização no GTKWAVE
	--MUX8 : MUX8B port map (i=>a, s=>S);
	CLOCK : clk <= not clk after 0.250 sec; --4Hz
	FI : FILT port map (ld_out=>ldout, s_cod=>scod, en_cod=>encod, clr_r=>clrr, ld_r=>ldr, clk=>clk, y=>y, c=>c);

	
	
	process
	begin
	
		clrr <= '1';
		ldout <= '1';
		ldr <= '1';

		y <= "0011";

		c <= "0011";

		encod <= '1';
		scod <= "00";
		wait for 500 ms;

		ldout <= '0';
		c <= "1000";
		scod <= "01";
		wait for 500 ms;

		y <= "1111";

		c <= "0001";
		scod <= "10";
		wait for 500 ms;

		--c <= "0000";
		scod <= "00";
		wait for 500 ms;

		--clrr <= '0';
		--wait for 500 ms;



		wait;
		end process;

end bench;
