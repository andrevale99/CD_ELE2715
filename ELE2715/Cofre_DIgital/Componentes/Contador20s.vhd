--========================================
--	CONTADOE DE 20 SEGUNDOS
--========================================
entity CONT20 is 
    port (CLK, CLR : in bit;
            C : out bit_vector(4 downto 0));
end CONT20;

architecture ckt of CONT20 is

    component FFJK is
        port (clk ,j,k,set ,clr: in bit;
                q: out bit);
    end component;

    signal saida : bit_vector(4 downto 0);
    signal and_1 : bit;
    signal vdd : bit_vector(2 downto 0);

    begin

        C0 : FFJK port map (CLK, '1', '1', '1', CLR, saida(0));
        C1 : FFJK port map (CLK, saida(0), saida(0), CLR, saida(1));

        vdd(0) <= saida(0) and saida(1);
        C2 : FFJK port map (CLK, vdd(0), vdd(0), CLR, saida(2));

        vdd(1) <= saida(2) and vdd(0);
        C3 : FFJK port map (CLK, vdd(1), vdd(1), CLR, saida(3));

        vdd(2) <= saida(3) and vdd(1);
        C4 : FFJK port map (CLK, vdd(2), vdd(2), CLR, saida(4));

        C(0) <= saida(0);
        C(1) <= saida(1);
        C(2) <= saida(2);
        C(3) <= saida(3);
        C(4) <= saida(4);

end ckt;