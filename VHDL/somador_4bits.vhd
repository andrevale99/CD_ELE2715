entity somador_4bits_entity is
end somador_4bits_entity;


architecture behavior of somador_4bits_entity is

    component meio_soma is
        port(a,b : in bit;
            s, co : out bit);
    end component;

    component soma_comp is
        port (a, b, cin : in bit;
             s, co : out bit);
    end component;

    component somador_4bits is
        port(A,B : in bit_vector(3 downto 0);
            r : out bit_vector(3 downto 0));
    end component;

    signal A : bit_vector(3 downto 0);
    signal B : bit_vector(3 downto 0);
    signal s : bit;
    signal co : bit;
    signal cin : bit;

    begin

    process(a, b, co, cin)
    begin

        r(0) <= meio_soma port map (a, b, s);

    end process;

end behavior;