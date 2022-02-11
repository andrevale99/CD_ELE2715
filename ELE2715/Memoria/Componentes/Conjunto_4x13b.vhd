--==============================================================
--      CONJUNTO DE 4 REGISTRADORES DE 13 BITS
--===============================================================

entity REG4X13 is
    port (  clk : in bit;
            clr : in bit;
            wd_en_01 : in bit;
            wd_en_02 : in bit;
            wd_en_03 : in bit;
            wd_en_04 : in bit;
            rd_en_01 : in bit;
            rd_en_02 : in bit;
            rd_en_03 : in bit;
            rd_en_04 : in bit;
            wd_data : in bit_vector(12 downto 0);
            rd_data_1 : out bit_vector(12 downto 0);
            rd_data_2 : out bit_vector(12 downto 0);
            rd_data_3 : out bit_vector(12 downto 0);
            rd_data_4 : out bit_vector(12 downto 0));
end REG4X13;

architecture ckt of REG4X13 is

    component REG13 is
        port (  I : in bit_vector(12 downto 0);
                clk : in bit;
                wd_en : in bit;
                clr : in bit;
                rd_en : in bit;
                Q : out bit_vector(12 downto 0));
    end component;


    begin

        P0 : REG13 port map (wd_data, clk, wd_en_01, clr, rd_en_01, rd_data_1);
        P1 : REG13 port map (wd_data, clk, wd_en_02, clr, rd_en_02, rd_data_2);
        P2 : REG13 port map (wd_data, clk, wd_en_03, clr, rd_en_03, rd_data_3);
        P3 : REG13 port map (wd_data, clk, wd_en_04, clr, rd_en_04, rd_data_4);


end ckt;