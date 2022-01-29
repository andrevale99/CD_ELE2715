--========================================
--	CONTADOE DE 20 SEGUNDOS
--========================================
entity CONT20 is 
    port (CLK: in bit;
			S : in bit_vector(3 downto 0);
            COMPT20 : out bit);
end CONT20;

architecture ckt of CONT20 is

    component FFJK is
        port (clk ,j,k,set ,clr, en: in bit;
		q: out bit);
    end component;

    signal saida : bit_vector(4 downto 0);
    signal and_1 : bit;
    signal vdd : bit_vector(2 downto 0);
	signal EN : bit;
	signal start : bit;

    begin

		start <= S(3) and not S(2) and not S(1) and S(0);

        C0 : FFJK port map (CLK, '1', '1', '1', start, EN, saida(0));
        C1 : FFJK port map (CLK, saida(0), saida(0), '1', start, EN, saida(1));

        vdd(0) <= saida(0) and saida(1);
        C2 : FFJK port map (CLK, vdd(0), vdd(0), '1', start, EN, saida(2));

        vdd(1) <= saida(2) and vdd(0);
        C3 : FFJK port map (CLK, vdd(1), vdd(1), '1', start, EN, saida(3));

        vdd(2) <= saida(3) and vdd(1);
        C4 : FFJK port map (CLK, vdd(2), vdd(2), '1', start, EN, saida(4));

		EN <= not (saida(4) and saida(1) and saida(0));

        COMPT20 <= not EN;

end ckt;