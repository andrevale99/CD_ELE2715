--==============================================================================================
--				OPERACAO AND PARA MULTIPLICACAO
--==============================================================================================
entity AND_MULT is
    port (A : in bit_vector(3 downto 0);
            B : in bit;
            S : out bit_vector(7 downto 0));
end AND_MULT;

architecture ckt of AND_MULT is

    begin
        S(0) <= A(0) and B;
        S(1) <= A(1) and B;
        S(2) <= A(2) and B;
        S(3) <= A(3) and B;
        S(4) <= '0';
        S(5) <= '0';
        S(6) <= '0';
        S(7) <= '0';

end ckt;

--==============================================================================================
--				MULTIPLICADOR
--==============================================================================================
entity MULT is
    port(A, B : in bit_vector(3 downto 0);
            Co : out bit;
            S : out bit_vector(7 downto 0));
end MULT;

architecture ckt of MULT is

    component AND_MULT is
        port (A : in bit_vector(3 downto 0);
                B : in bit;
                S : out bit_vector(7 downto 0));
    end component;

    component ADD8 is
        port (A, B : in bit_vector(7 downto 0);
				Ci : in bit;
			    Co : out bit;
			    S : out bit_vector(7 downto 0));
    end component;

    component BARREL_LEFT is
        port (S : in bit_vector(1 downto 0);
			    I : in bit_vector(7 downto 0);
			    Y : out bit_vector(7 downto 0));
    end component;

	signal and1 : bit_vector(7 downto 0);
	signal and2 : bit_vector(7 downto 0);
	signal and3 : bit_vector(7 downto 0);
	signal and4 : bit_vector(7 downto 0);

	signal aux_1 : bit_vector(7 downto 0);
	signal aux_2 : bit_vector(7 downto 0);
	signal aux_3 : bit_vector(7 downto 0);

	signal co_aux : bit_vector(1 downto 0);

	signal pri_soma : bit_vector(7 downto 0);
	signal seg_soma : bit_vector(7 downto 0);

    begin 

	OPR_1 : AND_MULT port map (A, B(0), and1);

	OPR_2 : AND_MULT port map (A, B(1), and2);
	DESL_AND2 : BARREL_LEFT port map ("01", and2, aux_1);

	OPR_3 : AND_MULT port map (A, B(2), and3);
	DESL_AND3 : BARREL_LEFT port map ("10", and3, aux_2);

	OPR_4 : AND_MULT port map (A, B(3), and4);
	DESL_AND4 : BARREL_LEFT port map ("11", and4, aux_3);

	SOMA_1 : ADD8 port map (and1, aux_1, '0', co_aux(0), pri_soma);
	SOMA_2 : ADD8 port map (pri_soma, aux_2, co_aux(0), co_aux(1), seg_soma);
	SOMA_3 : ADD8 port map (seg_soma, aux_3, co_aux(1), Co, S);

end ckt;