entity comp is
end comp;

architecture behavior of comp is

    component comp_cp is
        port(a, b : in bit_vector(3 downto 0);
        a_maior_b : out bit;
        a_menor_b : out bit;
        a_igual_b : out bit);
    end component;

    signal a : bit_vector(3 downto 0);
    signal b : bit_vector(3 downto 0);
    signal a_maior_b : bit;
    signal a_igual_b : bit;
    signal a_menor_b : bit;

    begin 

    process(a, b)
    begin 

        a_maior_b <= (a(3) and not b(3)) 
                    or 
                    (a(2) and not b(2) and (a(3) xnor b(3))) 
                    or 
                    (a(1) and not b(1) and ((a(3) xnor b(3))) and (a(2) xnor b(2))) 
                    or 
                    (a(0) and not b(0) 
                    and 
                    (a(3) xnor b(3)) 
                    and 
                    (a(2) xnor b(2)) 
                    and 
                    (a(1) xnor b(1)));

        a_igual_b <= ((a(3) xnor b(3)) and (a(2) xnor b(2)) and (a(1) xnor b(1)) and (a(1) xnor b(1)) and (a(0) xnor b(0)));   

        a_menor_b <= a_igual_b nor a_maior_b;

    end process;

end behavior;