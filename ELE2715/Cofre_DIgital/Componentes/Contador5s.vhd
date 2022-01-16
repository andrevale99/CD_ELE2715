--========================================
--	CONTADOE DE 5 SEGUNDOS
--========================================
entity CONT5 is 
    port (CLK: in bit;
			S : in bit_vector(3 downto 0);
            COMPT5 : out bit);
end CONT5;

architecture ckt of CONT5 is

    component FFJK is
        port (clk ,j,k,set ,clr, en: in bit;
		        q: out bit);
    end component;

    signal saida : bit_vector(2 downto 0);
    signal vdd : bit;
	signal EN : bit;
	signal start : bit;

    begin

		start <= (not S(3) and not S(2) and not S(1) and S(0))
				 or (not S(3) and not S(2) and S(1) and S(0))
				 or (not S(3) and S(2) and not S(1) and S(0))
				 or (not S(3) and S(2) and S(1) and S(0))
				 or (S(3) and S(2) and S(1) and S(0));

        C0 : FFJK port map (CLK, '1', '1', '1', start, EN, saida(0));
        C1 : FFJK port map (CLK, saida(0), saida(0), '1', start, EN, saida(1));
        C2 : FFJK port map (CLK, vdd, vdd, '1', start, EN, saida(2));

		EN <= not saida(2);

        vdd <= saida(0) and saida(1);

        COMPt5 <= not EN;


end ckt;