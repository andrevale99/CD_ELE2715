--====================================================
--		FILTRO FIR
--====================================================

entity FILT is
	port ( ld_out : in bit;
			s_cod : in bit_vector(1 downto 0);
			en_cod : in bit;
			clr_r : in bit;
			ld_r : in bit;
			clk : in bit;
			y : in bit_vector(3 downto 0);
			c : in bit_vector(3 downto 0);
			F : out bit_vector(9 downto 0));
end FILT;

architecture ckt of FILT is

	component RC is
		port ( 	ld_c : in bit;
				clr_r : in bit;
				ld_r : in bit;
				clk : in bit;
				carry : out bit;
				y, c : in bit_vector(3 downto 0);
				yout : out bit_vector(3 downto 0);
				result : out bit_vector(7 downto 0));
	end component;

	component DECODER is
		port ( s_cod : in bit_vector(1 downto 0);
				en_cod : in bit;
				c0 : out bit;
				c1 : out bit;
				c2 : out bit);
	end component;

	component ADD10 is
		port (	A, B : in bit_vector(9 downto 0);
				cin : in bit;
				Co : out bit;
				S : out bit_vector(9 downto 0));
	end component;

	component MEM10B is
		port (	Y : in bit_vector(9 downto 0);
				clk, clr, ld : in bit;
				Q : out bit_vector(9 downto 0));
	end component;

	signal qual : bit_vector(2 downto 0);

	signal y1 : bit_vector(3 downto 0); 
	signal y2 : bit_vector(3 downto 0); 
	signal y3 : bit_vector(3 downto 0); 

	signal r0 : bit_vector(7 downto 0);
	signal r1 : bit_vector(7 downto 0);
	signal r2 : bit_vector(7 downto 0); 

	signal r0_aux : bit_vector(9 downto 0);
	signal r1_aux : bit_vector(9 downto 0);
	signal r2_aux : bit_vector(9 downto 0); 

	signal soma_aux : bit_vector(9 downto 0);

	signal F_aux : bit_vector(9 downto 0);

	signal carry_mult : bit_vector(2 downto 0);
	signal carry_soma : bit_vector(1 downto 0);

	begin

		r0_aux(0) <= r0(0);
		r0_aux(1) <= r0(1);
		r0_aux(2) <= r0(2);
		r0_aux(3) <= r0(3);
		r0_aux(4) <= r0(4);
		r0_aux(5) <= r0(5);
		r0_aux(6) <= r0(6);
		r0_aux(7) <= r0(7);
		r0_aux(8) <= '0';
		r0_aux(9) <= '0'; 

		r1_aux(0) <= r1(0);
		r1_aux(1) <= r1(1);
		r1_aux(2) <= r1(2);
		r1_aux(3) <= r1(3);
		r1_aux(4) <= r1(4);
		r1_aux(5) <= r1(5);
		r1_aux(6) <= r1(6);
		r1_aux(7) <= r1(7);
		r1_aux(8) <= '0';
		r1_aux(9) <= '0';

		r2_aux(0) <= r2(0);
		r2_aux(1) <= r2(1);
		r2_aux(2) <= r2(2);
		r2_aux(3) <= r2(3);
		r2_aux(4) <= r2(4);
		r2_aux(5) <= r2(5);
		r2_aux(6) <= r2(6);
		r2_aux(7) <= r2(7);
		r2_aux(8) <= '0';
		r2_aux(9) <= '0';

		CHOOSE_C : DECODER port map (s_cod, en_cod, qual(0), qual(1), qual(2));

		RC0 : RC port map (qual(0), clr_r, ld_r, clk, carry_mult(0), y, c, y1, r0);
		RC1 : RC port map (qual(1), clr_r, ld_r, clk, carry_mult(1), y1, c, y2, r1);
		RC2 : RC port map (qual(2), clr_r, ld_r, clk, carry_mult(2), y2, c, y3, r2);

		SOMA0 : ADD10 port map (r0_aux, r1_aux, carry_mult(0), carry_soma(0), soma_aux);
		SOMA1 : ADD10 port map (soma_aux, r2_aux, carry_mult(1), carry_soma(1), F_aux);

		REG_OUT_F : MEM10B port map (F_aux, clk, '1', ld_out, F);

end ckt;