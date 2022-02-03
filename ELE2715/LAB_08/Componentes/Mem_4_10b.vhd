--====================================================
--	MEMORIA DE 4 BISTS
--====================================================

entity MEM4B is
	port (	Y : in bit_vector(3 downto 0);
			clk, clr, ld : in bit;
			Q : out bit_vector(3 downto 0));
end MEM4B;

architecture ckt of MEM4B is
	component FFD is
		port (	clk ,d,set ,clr: in bit;
				q: out bit);
	end component;

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

	signal aux : bit_vector(3 downto 0);
	signal saida_mux : bit_vector(3 downto 0);

	begin

		LD0 : MUX2B port map (aux(0), Y(0), ld, saida_mux(0));
		Q0: FFD port map(clk, saida_mux(0), '1', clr, aux(0));
		
		LD1 : MUX2B port map (aux(1), Y(1), ld, saida_mux(1));
		Q1: FFD port map(clk, saida_mux(1), '1', clr, aux(1));

		LD2 : MUX2B port map (aux(2), Y(2), ld, saida_mux(2));
		Q2: FFD port map(clk, saida_mux(2), '1', clr, aux(2));

		LD3 : MUX2B port map (aux(3), Y(3), ld, saida_mux(3));
		Q3: FFD port map(clk, saida_mux(3), '1', clr, aux(3));

		Q(0) <= aux(0);
		Q(1) <= aux(1);
		Q(2) <= aux(2);
		Q(3) <= aux(3);

end ckt;

--====================================================
--	MEMORIA DE 10 BISTS
--====================================================

entity MEM10B is
	port (	Y : in bit_vector(9 downto 0);
			clk, clr, ld : in bit;
			Q : out bit_vector(9 downto 0));
end MEM10B;

architecture ckt of MEM10B is
	component FFD is
		port (	clk ,d,set ,clr: in bit;
				q: out bit);
	end component;

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

	signal aux : bit_vector(9 downto 0);
	signal saida_mux : bit_vector(9 downto 0);

	begin

		LD0 : MUX2B port map (aux(0), Y(0), ld, saida_mux(0));
		Q0 : FFD port map(clk, saida_mux(0), '1', clr, aux(0));
		
		LD1 : MUX2B port map (aux(1), Y(1), ld, saida_mux(1));
		Q1 : FFD port map(clk, saida_mux(1), '1', clr, aux(1));

		LD2 : MUX2B port map (aux(2), Y(2), ld, saida_mux(2));
		Q2 : FFD port map(clk, saida_mux(2), '1', clr, aux(2));

		LD3 : MUX2B port map (aux(3), Y(3), ld, saida_mux(3));
		Q3 : FFD port map(clk, saida_mux(3), '1', clr, aux(3));

		LD4 : MUX2B port map (aux(4), Y(4), ld, saida_mux(4));
		Q4 : FFD port map(clk, saida_mux(4), '1', clr, aux(4));

		LD5 : MUX2B port map (aux(5), Y(5), ld, saida_mux(5));
		Q5 : FFD port map(clk, saida_mux(5), '1', clr, aux(5));

		LD6 : MUX2B port map (aux(6), Y(6), ld, saida_mux(6));
		Q6 : FFD port map(clk, saida_mux(6), '1', clr, aux(6));

		LD7 : MUX2B port map (aux(7), Y(7), ld, saida_mux(7));
		Q7 : FFD port map(clk, saida_mux(7), '1', clr, aux(7));

		LD8 : MUX2B port map (aux(8), Y(8), ld, saida_mux(8));
		Q8 : FFD port map(clk, saida_mux(8), '1', clr, aux(8));

		LD9 : MUX2B port map (aux(9), Y(9), ld, saida_mux(9));
		Q9 : FFD port map(clk, saida_mux(9), '1', clr, aux(9));

		Q(0) <= aux(0);
		Q(1) <= aux(1);
		Q(2) <= aux(2);
		Q(3) <= aux(3);
		Q(4) <= aux(4);
		Q(5) <= aux(5);
		Q(6) <= aux(6);
		Q(7) <= aux(7);
		Q(8) <= aux(8);
		Q(9) <= aux(9);

end ckt;