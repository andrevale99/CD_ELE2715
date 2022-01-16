entity MDE is
	port(CLK : in bit;
		 ONN, ADD : in bit;
		 SENHA_1, SENHA_2, SENHA_3 : in bit_vector(5 downto 0);
		 OUTT, R, G, B : out bit;
		 VALOR, P1, P2 : out bit);
end MDE;

architecture ckt of MDE is

	component LOGCOMB is
		port(  ONN, ADD, COMPT5, COMPT20, COMPS : in bit;
				S: in bit_vector(3 downto 0);
				OUTT, R, G, B : out bit;
				VALOR, P1, P2 : out bit;
				N : out bit_vector(3 downto 0));
	end component;

	component REGEST is
		port(	n : in bit_vector(3 downto 0);
				clk: in bit;
				s : out bit_vector(3 downto 0));
	end component;

	component CONT5 is 
		port (CLK: in bit;
				S : in bit_vector(3 downto 0);
				COMPT5 : out bit);
	end component;

	component CONT20 is 
	port (CLK: in bit;
			S : in bit_vector(3 downto 0);
            COMPT20 : out bit);
	end component;

	component SENHA is
		port (	CLK : bit;
				I1, I2, I3 : in bit_vector(5 downto 0);
				S : in bit_vector(3 downto 0);
				COMPS : out bit);
	end component;

	signal Estado_futuro : bit_vector(3 downto 0);
	signal Estado_atual : bit_vector(3 downto 0);

	signal c20 : bit;
	signal c5 : bit;

	signal senha_correta : bit;

	signal outf : bit;
	signal rf : bit;
	signal gf : bit;
	signal bf : bit;

	--Logica do MDE
	begin

		LOGC : LOGCOMB port map (ONN, ADD, c5, c20, senha_correta, estado_atual, N=>Estado_futuro, R=>rf, G=>gf, B=>bf, OUTT=>outf);
		REG : REGEST port map(Estado_futuro, CLK, estado_atual);
		CT5 : CONT5 port map (CLK, estado_atual, c5);
		CT20 : CONT20 port map (CLK, estado_atual, c20);
		SEN : SENHA port map (CLK, SENHA_1, SENHA_2, SENHA_3, estado_atual, senha_correta);

	OUTT <= outf;
	R <= rf;
	G <= gf;
	B <= bf;

end ckt ;