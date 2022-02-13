--=================================================================
--				MEMORIA FINAL
--=================================================================

entity FIFO is
    port ( clk, wr, rd, clr_fifo : in bit;
            w_data : in bit_vector(12 downto 0);
            empty, full : out bit;
            r_data : out bit_vector(12 downto 0));
end FIFO;

architecture ckt of FIFO is

    component CONT_RD is
        port ( clk, clr : in bit;
               a : in bit_vector(2 downto 0);
                s : out bit_vector(3 downto 0));
    end component;

    component ADD4 is
        port(A, B : in bit_vector(3 downto 0);
                Co : out bit;
                 S : out bit_vector(3 downto 0));
    end component;

    component COMP4B is
        port (A, B : in bit_vector(3 downto 0);
                AigB, AmaiorB, AmenorB : out bit);
    end component;

    component REG16X13 is
        port (  clk, clr : in bit;
                wd , rd : in bit;
                wd_addr, rd_addr : in bit_vector(3 downto 0);
                wd_data : in bit_vector(12 downto 0);
                rd_data : out bit_vector(12 downto 0));
    end component;

    component MAQ is
        port ( a : in bit_vector(2 downto 0);
                wr_fu : in bit;
                rd_em : in bit;
                wr, rd : in bit;
                reset : in bit;
                full, empty, clr : out bit;
                b : out bit_vector(2 downto 0));
    end component;

    component CONT_WR is
        port ( clk, clr : in bit;
               a : in bit_vector(2 downto 0);
                s : out bit_vector(3 downto 0));
    end component;

    component ARMEST is
        port ( clk, clr : in bit;
                a : in bit_vector(2 downto 0);
                s : out bit_vector(2 downto 0)); 
    end component;
    
    signal a : bit_vector(2 downto 0);
    signal rd_cont : bit_vector(3 downto 0);
    signal wr_cont : bit_vector(3 downto 0);

    signal rd_cont_mais_um : bit_vector(3 downto 0);
    signal wr_cont_mais_um : bit_vector(3 downto 0);

    signal rd_em : bit;

    signal wr_fu : bit;

    signal clr_geral : bit;

    signal clr : bit;
    signal clr_maq : bit;

    signal b : bit_vector(2 downto 0);

    signal inv_clr_fifo : bit;

    begin
        inv_clr_fifo <= not clr_fifo;
        clr_geral <= inv_clr_fifo or clr_maq;

        CONT_LEITURA : CONT_RD port map (clk, clr_geral, a, rd_cont);
        SOMA_RD_1 : ADD4 port map (rd_cont, "0001", S=>rd_cont_mais_um);

        COMP_WDC_RDC_1 : COMP4B port map (wr_cont, rd_cont_mais_um, AigB=>rd_em);

        MEMORIA : REG16X13 port map (clk, clr_geral, wr, rd, wr_cont, rd_cont, w_data, r_data);

        CONTROLE : MAQ port map (a, wr_fu, rd_em, wr, rd, clr_fifo, full, empty, clr_maq, b);

        ARMAZENADOR : ARMEST port map (clk, inv_clr_fifo, b, a);

        CONT_ESCRITA : CONT_WR port map (clk, clr_geral, a, wr_cont);

        SOMA_WR_1 : ADD4 port map (wr_cont, "0001", S=>wr_cont_mais_um);

        COMP_WDC_RDC_2 : COMP4B port map (wr_cont_mais_um, rd_cont, AigB=>wr_fu);



end ckt;