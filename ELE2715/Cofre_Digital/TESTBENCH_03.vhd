--COMANDO no terminal para compilar e visuzalizar no GTKWAVE
--ghdl -a Componentes/*.vhd  && ghdl -a TESTBENCH_03.vhd && ghdl -e tb_03 && ghdl -r tb_03 --vcd=wave_03.simu --stop-time=100sec && gtkwave wave_03.simu

--senha : 100100(36) | 010111(23) |  111100 (60)

entity tb_03 is
end tb_03;
	
	architecture bench of tb_03 is
	
		--component MEM18 is
		--	port (	CLK : in bit;
		--			ESTADO : in bit_vector(3 downto 0);
		--			I_1 : in bit_vector(5 downto 0);
		--			I_2 : in bit_vector(5 downto 0);
		--			I_3 : in bit_vector(5 downto 0);
		--	   		S : out bit_vector(17 downto 0));
		--end component;
	
		--component SENHA is
		--	port (	CLK : bit;
		--			I1, I2, I3 : in bit_vector(5 downto 0);
		--			S : in bit_vector(3 downto 0);
		--			COMPS : out bit);
		--end component;
	
		component MDE is
			port(	CLK : in bit;
					ONN, ADD : in bit;
					SENHA_1, SENHA_2, SENHA_3 : in bit_vector(5 downto 0);
					OUTT, R, G, B : out bit;
					VALOR, P1, P2 : out bit);
		end component;
	
		--EXEMPLO de como criar os componentes para visualização no GTKWAVE
		--for MUX8 : MUX8B use entity work.MUX8B;
		--for MEM : MEM18 use entity work.MEM18;
		--for SEN : SENHA use entity work.SENHA;
		for FINAL : MDE use entity work.MDE;
	
		signal clk : bit := '0';
	
		--signal s : bit_vector(3 downto 0);
		signal e_1 : bit_vector(5 downto 0);
		signal e_2 : bit_vector(5 downto 0);
		signal e_3 : bit_vector(5 downto 0);
	
		signal onn : bit;
		signal add : bit;
	
		begin
		--EXEMPLO de como criar os componentes para visualização no GTKWAVE
		--MUX8 : MUX8B port map (i=>a, s=>S);
		--MEM : MEM18 port map (CLK=>clk, ESTADO=>s, I_1=>e_1, I_2=>e_2, I_3=>e_3);
		--SEN : SENHA port map (CLK=>clk, I1=>e_1, I2=>e_2, I3=>e_3, S=>s);
		FINAL : MDE port map (CLK=>clk, ONN=>onn, ADD=>add, SENHA_1=>e_1, SENHA_2=>e_2, SENHA_3=>e_3);
		
		CLOCK : clk <=  not clk after 0.5 sec;
			
		process
		begin
	
			e_1 <= "100101";
			e_2 <= "011111";
			e_3 <= "111111";
	
			onn <= '1';
			add <= '0';
			wait for 1 sec;
	
			onn <= '0';
			add <= '1';
			wait for 1 sec;
	
			onn <= '0';
			add <= '0';
			wait for 5 sec;
	
			onn <= '0';
			add <= '1';
			wait for 1 sec;
	
			onn <= '0';
			add <= '0';
			wait for 5 sec;
	
			onn <= '0';
			add <= '1';
			wait for 1 sec;
	
			onn <= '0';
			add <= '0';
			wait for 5 sec;
	
			onn <= '0';
			add <= '1';
			wait for 1 sec;
	
			onn <= '0';
			add <= '0';
			wait for 5 sec;
	
			wait for 30 sec;
	
	
			wait;
			end process;
	
	end bench;
	
	