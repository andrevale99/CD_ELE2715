--Circuito para um MUX de 8 bits

entity mux is
    port(s: in bit_vector(2 downto 0);
        i: in bit_vector(7 downto 0);
        d, nd:out bit);
end mux;

architecture behavior of mux is

    begin
        

        process(s, i)
        begin
            d <=(i(0) and (not s(2) and not s(1) and not s(0)))
                or
                (i(1) and (not s(2) and not s(1) and s(0)))
                or
                (i(2) and (not s(2) and s(1) and not s(0)))
                or
                (i(3) and (not s(2) and s(1) and s(0)))
                or
                (i(4) and (s(2) and not s(1) and not s(0)))
                or 
                (i(5) and (s(2) and not s(1) and s(0)))
                or 
                (i(6) and (s(2) and s(1) and not s(0)))
                or
                (i(7) and (s(2) and s(1) and s(0)));

            nd <= not (i(0) and (not s(2) and not s(1) and not s(0)))
                or
                not (i(1) and (not s(2) and not s(1) and s(0)))
                or
                not (i(2) and (not s(2) and s(1) and not s(0)))
                or
                not (i(3) and (not s(2) and s(1) and s(0)))
                or
                not (i(4) and (s(2) and not s(1) and not s(0)))
                or 
                not (i(5) and (s(2) and not s(1) and s(0)))
                or 
                not (i(6) and (s(2) and s(1) and not s(0)))
                or
                not (i(7) and (s(2) and s(1) and s(0)));

        end process;

end behavior;