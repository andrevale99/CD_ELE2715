--==============================================================
--      LOGICA DA MAQUINA DE ESTADOS
--===============================================================
entity MAQ is
    port ( a : in bit_vector(2 downto 0);
            wr_fu : in bit;
            rd_em : in bit;
            wr, rd : in bit;
            reset : in bit;
            full, empty, clr : out bit;
            b : out bit_vector(2 downto 0));
end MAQ;

architecture ckt of MAQ is

    begin

        b(0) <= (not a(2) and not a(1) and not a(0) and not RESET)
                or (not a(2) and not a(1) and a(0) and not WR and not RESET) 
                or (not a(2) and a(1) and not a(0) and WR_FU and not RESET) 
                or (not a(2) and a(1) and a(0) and RD_EM and not RESET) 
                or (a(2) and not a(1) and not a(0) and  RD and not RESET) 
                or (a(2) and not a(1) and a(0) and not WR and RD and not RESET) 
                or (a(2) and not a(1) and a(0) and not RD and not RESET);

        b(1) <= (not a(2) and not a(1) and a(0) and WR and not RD and not RESET)
                or(a(2) and not a(1) and not a(0) and WR and not RESET)
                or(a(2) and not a(1) and not a(0) and RD and not RESET) 
                or(a(2) and not a(1) and a(0) and not WR and RD and not RESET);

        b(2) <= (not a(2) and a(1) and not a(0) and not WR_FU and not RESET)
                or (not a(2) and a(1) and not a(0) and WR_FU and not RESET) 
                or (not a(2) and a(1) and a(0) and not RD_EM and not RESET)
                or (a(2) and not a(1) and not a(0) and not WR and not RD and not RESET) 
                or (a(2) and not a(1) and a(0) and not RD and not RESET);

        full <= a(2) and not a(1) and a(0);

        clr <= not a(2) and not a(1) and not a(0);

        empty <= not a(2) and not a(1) and a(0);

end ckt;