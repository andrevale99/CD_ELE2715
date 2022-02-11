--==============================================================
--      REGISTRADOR DE 1 BIT COM LOAD E BUFFER (BUFFER COM MUX)
--===============================================================
entity REG1 is
    port ( clk, d, en, clr, rd : in bit;
            q : out bit);
end REG1;

architecture ckt of REG1 is

    component FFD is
        port (clk ,d,set ,clr: in bit;
                q: out bit);
    end component;

    component MUX is
        port (	I1, I2 : in bit;
                S : in bit;
                Q : out bit);
    end component;

    signal aux : bit;
    signal saida_mux : bit;

    begin

        MUX_1 : MUX port map (aux, d, en, saida_mux); 
        REG_1 : FFD port map (clk, saida_mux, '1', clr, aux);

        MUX_SAIDA : MUX port map ('0', aux, S=>rd, Q=>q);
        

end ckt;