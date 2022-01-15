--========================================
--	CONTADOE DE 5 SEGUNDOS
--========================================
entity CONT5 is 
    port (CLK, CLR : in bit;
            C : out bit_vector(2 downto 0));
end CONT5;

architecture ckt of CONT5 is

    component FFJK is
        port (clk ,j,k,set ,clr: in bit;
                q: out bit);
    end component;

    signal saida : bit_vector(2 downto 0);
    signal and_1 : bit;
    signal vdd : bit;

    begin

        C0 : FFJK port map (CLK, '1', '1', '1', CLR, saida(0));
        C1 : FFJK port map (CLK, saida(0), saida(0), CLR, saida(1));
        C2 : FFJK port map (CLK, vdd, vdd, CLR, saida(2));

        vdd <= saida(0) and saida(1);

        C(0) <= saida(0);
        C(1) <= saida(1);
        C(2) <= saida(2);


end ckt;