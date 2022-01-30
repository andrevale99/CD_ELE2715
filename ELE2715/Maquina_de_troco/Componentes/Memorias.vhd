--=============================================
--		MEMORIA DE 6 BITS
--=============================================
entity MEM6 is
	port (	Y : in bit_vector(5 downto 0);
			clk, clr, en : in bit;
			Q : out bit_vector(5 downto 0));
end MEM6;

architecture ckt of MEM6 is

	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;
	
	begin

		Q1 : FFD port map(clk, Y(0), '1', clr, en, Q(0));
		Q2 : FFD port map(clk, Y(1), '1', clr, en, Q(1));
		Q3 : FFD port map(clk, Y(2), '1', clr, en, Q(2));
		Q4 : FFD port map(clk, Y(3), '1', clr, en, Q(3));
		Q5 : FFD port map(clk, Y(4), '1', clr, en, Q(4));
		Q6 : FFD port map(clk, Y(5), '1', clr, en, Q(5));

end ckt;

--=============================================
--		MEMORIA DE 6 BITS COM LOAD
--=============================================
entity MEM6LD is
	port (	Y : in bit_vector(5 downto 0);
		 	clk, ld, clr : in bit;
			Q : out bit_vector(5 downto 0));
end MEM6LD;

architecture ckt of MEM6LD is

	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;

	component MUX2B is
		port (	I1, I2 : in bit;
				S : in bit;
				Q : out bit);
	end component;

	signal out_mux : bit_vector(5 downto 0);
	signal out_ffd : bit_vector(5 downto 0);

begin

	Q1 : FFD port map(clk, out_mux(0), '1', clr, '1', out_ffd(0));
	Q2 : FFD port map(clk, out_mux(1), '1', clr, '1', out_ffd(1));
	Q3 : FFD port map(clk, out_mux(2), '1', clr, '1', out_ffd(2));
	Q4 : FFD port map(clk, out_mux(3), '1', clr, '1', out_ffd(3));
	Q5 : FFD port map(clk, out_mux(4), '1', clr, '1', out_ffd(4));
	Q6 : FFD port map(clk, out_mux(5), '1', clr, '1', out_ffd(5));

	MUX1 : MUX2B port map(out_ffd(0), Y(0), ld, out_mux(0));
	MUX2 : MUX2B port map(out_ffd(1), Y(1), ld, out_mux(1));
	MUX3 : MUX2B port map(out_ffd(2), Y(2), ld, out_mux(2));
	MUX4 : MUX2B port map(out_ffd(3), Y(3), ld, out_mux(3));
	MUX5 : MUX2B port map(out_ffd(4), Y(4), ld, out_mux(4));
	MUX6 : MUX2B port map(out_ffd(5), Y(5), ld, out_mux(5));

	Q <= out_ffd;

end ckt;

--=============================================
--		MEMORIA DE 10 BITS
--=============================================

entity MEM10 is
	port (	Y : in bit_vector(9 downto 0);
			clk, clr, en : in bit;
			Q : out bit_vector(9 downto 0));
end MEM10;

architecture ckt of MEM10 is

	component FFD is
		port (clk ,d,set ,clr, en: in bit;
				q: out bit);
	end component;
	
	begin

		Q1 : FFD port map(clk, Y(0), '1', clr, en, Q(0));
		Q2 : FFD port map(clk, Y(1), '1', clr, en, Q(1));
		Q3 : FFD port map(clk, Y(2), '1', clr, en, Q(2));
		Q4 : FFD port map(clk, Y(3), '1', clr, en, Q(3));
		Q5 : FFD port map(clk, Y(4), '1', clr, en, Q(4));
		Q6 : FFD port map(clk, Y(5), '1', clr, en, Q(5));
		Q7 : FFD port map(clk, Y(6), '1', clr, en, Q(6));
		Q8 : FFD port map(clk, Y(7), '1', clr, en, Q(7));
		Q9 : FFD port map(clk, Y(8), '1', clr, en, Q(8));
	   Q10 : FFD port map(clk, Y(9), '1', clr, en, Q(9));

end ckt;