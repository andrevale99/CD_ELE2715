library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture bench of tb is

	--COMPONENTES
	component TC is
		port(ENTRADA : in bit_vector(3 downto 0);
				S : in bit;
				Y : out bit);
	end component;

	component ADD4 is
		port(A, B : in bit_vector(3 downto 0);
	   			Co : out bit;
				S : out bit_vector(3 downto 0));
	end component;

	component SUB4 is
		port (A, B : in bit_vector(3 downto 0);
				Tout : out bit;
				S : out bit_vector(3 downto 0));
	end component;

	component MEM4B is
		port (I : in bit_vector(3 downto 0);
			clk : bit;
			set : in bit;
			clr : in bit;
			load : in bit;
			S : out bit_vector(3 downto 0));
	end component;
	

	--SINAIS
	signal A : bit_vector(3 downto 0);
	signal B : bit_vector(3 downto 0);
	signal SEL : bit;

	signal clk: bit := '0'; --CLOCK
	
	signal SET : bit;
	signal CLR : bit;
	signal LOAD : bit;

	--for DESL_LEFT : SHFTL use entity work.SHFTL;
	for ESTOURO : TC use entity work.TC;
	for SOMA : ADD4 use entity work.ADD4;
	for SUB : SUB4 use entity work.SUB4;
	for MEMORIA : MEM4B use entity work.MEM4B;

	begin

	--DESL_LEFT : SHFTL port map (I => A, S => SEL, Y => F);
	CLOCK : clk <=  '1' after 0.5 ns when clk = '0' else
        			'0' after 0.5 ns when clk = '1';

	ESTOURO : TC port map (ENTRADA => A, S => SEL);
	SOMA : ADD4 port map (A => A, B=>B);
	SUB : SUB4 port map (A=>A, B=> B);
	MEMORIA : MEM4B port map (I => A, clk => clk, set => SET, clr => CLR, load => LOAD);

	process
	begin

		SET <= '1';
		CLR <= '1';
		
		LOAD <= '0';
		A <= "1111";
		wait for 10 ns;
		
		A(0) <= '0';
		wait for 10 ns;

		LOAD <= '1';
		wait for 5 ns;
		LOAD <= '0';
		wait for 5 ns;

		A(3) <= '0';
		wait for 10 ns;

		A <= "1010";
		LOAD <= '1';
		wait for 5 ns;
		LOAD <= '0';
		wait for 5 ns;

		wait;
		end process;

end bench;

