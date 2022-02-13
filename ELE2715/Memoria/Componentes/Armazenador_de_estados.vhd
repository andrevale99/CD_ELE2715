--=================================================================
--				ARMAZENADOR DE ESTADOS
--=================================================================
entity ARMEST is
    port ( clk, clr : in bit;
            a : in bit_vector(2 downto 0);
            s : out bit_vector(2 downto 0)); 
end ARMEST;

architecture ckt of ARMEST is

    component FFD is
        port (clk ,d,set ,clr: in bit;
                q: out bit);
    end component;

    begin

        S0 : FFD port map (clk, a(0), '1', clr, s(0));
        S1 : FFD port map (clk, a(1), '1', clr, s(1));
        S2 : FFD port map (clk, a(2), '1', clr, s(2));

end ckt;