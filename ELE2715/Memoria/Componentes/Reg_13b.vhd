--==============================================================
--      REGISTRADOR DE 13 BITS
--===============================================================

entity REG13 is
    port (  I : in bit_vector(12 downto 0);
            clk : in bit;
            wd_en : in bit;
            clr : in bit;
            rd_en : in bit;
            Q : out bit_vector(12 downto 0));
end REG13;

architecture ckt of REG13 is

    component REG1 is
        port ( clk, d, en, clr, rd : in bit;
                q : out bit);
    end component;

    begin

        R0 : REG1 port map (clk,  I(0), wd_en, clr, rd_en, Q(0));
        R1 : REG1 port map (clk,  I(1), wd_en, clr, rd_en, Q(1));
        R2 : REG1 port map (clk,  I(2), wd_en, clr, rd_en, Q(2));
        R3 : REG1 port map (clk,  I(3), wd_en, clr, rd_en, Q(3));
        R4 : REG1 port map (clk,  I(4), wd_en, clr, rd_en, Q(4));
        R5 : REG1 port map (clk,  I(5), wd_en, clr, rd_en, Q(5));
        R6 : REG1 port map (clk,  I(6), wd_en, clr, rd_en, Q(6));
        R7 : REG1 port map (clk,  I(7), wd_en, clr, rd_en, Q(7));
        R8 : REG1 port map (clk,  I(8), wd_en, clr, rd_en, Q(8));
        R9 : REG1 port map (clk,  I(9), wd_en, clr, rd_en, Q(9));
       R10 : REG1 port map (clk, I(10), wd_en, clr, rd_en, Q(10));
       R11 : REG1 port map (clk, I(11), wd_en, clr, rd_en, Q(11));
       R12 : REG1 port map (clk, I(12), wd_en, clr, rd_en, Q(12)); 

end ckt;