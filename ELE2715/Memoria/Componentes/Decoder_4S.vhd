--==============================================================
--      DECODER DE 4 BITS DE SELECAO
--===============================================================

entity DEC is
    port (  en : in bit;
            s : in bit_vector(3 downto 0);
            q : out bit_vector(15 downto 0));
end DEC;

architecture ckt of DEC is

    begin

        q(0) <= (en and not s(3) and not s(2) and not s(1) and not s(0));
        q(1) <= (en and not s(3) and not s(2) and not s(1) and s(0));
        q(2) <= (en and not s(3) and not s(2) and s(1) and not s(0));
        q(3) <= (en and not s(3) and not s(2) and s(1) and s(0));
        q(4) <= (en and not s(3) and s(2) and not s(1) and not s(0));
        q(5) <= (en and not s(3) and s(2) and not s(1) and s(0));
        q(6) <= (en and not s(3) and s(2) and s(1) and not s(0));
        q(7) <= (en and not s(3) and s(2) and s(1) and s(0));
        q(8) <= (en and s(3) and not s(2) and not s(1) and not s(0));
        q(9) <= (en and s(3) and not s(2) and not s(1) and s(0));
       q(10) <= (en and s(3) and not s(2) and s(1) and not s(0));
       q(11) <= (en and s(3) and not s(2) and s(1) and s(0));
       q(12) <= (en and s(3) and s(2) and not s(1) and not s(0));
       q(13) <= (en and s(3) and s(2) and not s(1) and s(0));
       q(14) <= (en and s(3) and s(2) and s(1) and not s(0));
       q(15) <= (en and s(3) and s(2) and s(1) and s(0));

end ckt;