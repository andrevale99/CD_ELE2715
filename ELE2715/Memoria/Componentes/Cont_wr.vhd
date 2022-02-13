--==============================================================
--      CONTADOR PARA WR
--===============================================================
entity CONT_WR is
    port ( clk, clr : in bit;
           a : in bit_vector(2 downto 0);
            s : out bit_vector(3 downto 0));
end CONT_WR;

architecture ckt of CONT_WR is

    component FFJK is
        port (  clk ,j,k,set ,clr, en: in bit;
		        q: out bit);
    end component;

    signal tc : bit_vector(1 downto 0);

    signal b : bit_vector(3 downto 0);

    signal en : bit;

    begin

        en <= not a(2) and a(1) and not a(0);
        
        S0 : FFJK port map (clk, '1', '1', '1', clr, en, b(0));
        S1 : FFJK port map (clk, b(0), b(0), '1', clr, en, b(1));

        tc(0) <= b(0) and b(1);
        S2 : FFJK port map (clk, tc(0), tc(0), '1', clr, en, b(2));

        tc(1) <= tc(0) and b(2);
        S3 : FFJK port map (clk, tc(1), tc(1), '1', clr, en, b(3));

        s(0) <= b(0);
        s(1) <= b(1);
        s(2) <= b(2);
        s(3) <= b(3);
    

end ckt;