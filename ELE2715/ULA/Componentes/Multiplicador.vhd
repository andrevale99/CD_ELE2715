--==============================================================================================
--				OPERACAO AND PARA MULTIPLICACAO
--==============================================================================================
entity AND_MULT is
    port (A : in bit_vector(7 downto 0);
            B : in bit;
            S : out bit_vector(7 downto 0));
end AND_MULT;

architecture ckt of AND_MULT is

    begin
        S(0) <= A(0) and B;
        S(1) <= A(1) and B;
        S(2) <= A(2) and B;
        S(3) <= A(3) and B;
        S(4) <= A(4) and B;
        S(5) <= A(5) and B;
        S(6) <= A(6) and B;
        S(7) <= A(7) and B;

end ckt;

--==============================================================================================
--				MULTIPLICADOR
--==============================================================================================
entity MULT is
    port(A, B : in bit_vector(7 downto 0);
            Co : out bit;
            S : out bit_vector(7 downto 0));
end MULT;

architecture ckt of MULT is

    component AND_MULT is
        port (A : in bit_vector(7 downto 0);
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
        port (S : in bit_vector(2 downto 0);
			    I : in bit_vector(7 downto 0);
			    Y : out bit_vector(7 downto 0));
    end component;

    signal cout : bit_vector(7 downto 0);

    signal aux_1 : bit_vector(7 downto 0);
    signal aux_2 : bit_vector(7 downto 0);
    signal aux_3 : bit_vector(7 downto 0);
    signal aux_4 : bit_vector(7 downto 0);
    signal aux_5 : bit_vector(7 downto 0);
    signal aux_6 : bit_vector(7 downto 0);
    signal aux_7 : bit_vector(7 downto 0);
    signal aux_8 : bit_vector(7 downto 0);

    signal desc_1 : bit_vector(7 downto 0);
    signal desc_2 : bit_vector(7 downto 0);
    signal desc_3 : bit_vector(7 downto 0);
    signal desc_4 : bit_vector(7 downto 0);
    signal desc_5 : bit_vector(7 downto 0);
    signal desc_6 : bit_vector(7 downto 0);
    signal desc_7 : bit_vector(7 downto 0);

    signal sum_1 : bit_vector(7 downto 0);
    signal sum_2 : bit_vector(7 downto 0);
    signal sum_3 : bit_vector(7 downto 0);
    signal sum_4 : bit_vector(7 downto 0);
    signal sum_5 : bit_vector(7 downto 0);
    signal sum_6 : bit_vector(7 downto 0);

    begin 
    
        OPR1 : AND_MULT port map (A, B(0), aux_1);

        OPR2 : AND_MULT port map (A, B(1), aux_2);
        DESC1 : BARREL_LEFT port map ("001", aux_2, desc_1);

        OPR3 : AND_MULT port map (A, B(2), aux_3);
        DESC2 : BARREL_LEFT port map ("010", aux_3, desc_2);

        OPR4 : AND_MULT port map (A, B(3), aux_4);
        DESC3 : BARREL_LEFT port map ("011", aux_4, desc_3);

        OPR5 : AND_MULT port map (A, B(4), aux_5);
        DESC4 : BARREL_LEFT port map ("100", aux_5, desc_4);

        OPR6 : AND_MULT port map (A, B(5), aux_6);
        DESC5 : BARREL_LEFT port map ("101", aux_6, desc_5);

        OPR7 : AND_MULT port map (A, B(6), aux_7);
        DESC6 : BARREL_LEFT port map ("110", aux_7, desc_6);

        OPR8 : AND_MULT port map (A, B(7), aux_8);
        DESC7 : BARREL_LEFT port map ("111", aux_8, desc_7);


        SUM1 : ADD8 port map (aux_1, desc_1, '0', cout(0), sum_1);
        SUM2 : ADD8 port map (sum_1, desc_2, cout(0), cout(1), sum_2);
        SUM3 : ADD8 port map (sum_2, desc_3, cout(1), cout(2), sum_3);
        SUM4 : ADD8 port map (sum_3, desc_4, cout(2), cout(3), sum_4);
        SUM5 : ADD8 port map (sum_4, desc_5, cout(3), cout(4), sum_5);
        SUM6 : ADD8 port map (sum_5, desc_6, cout(4), cout(5), sum_6);
        SUM7 : ADD8 port map (sum_6, desc_7, cout(5), cout(6), S);  

end ckt;