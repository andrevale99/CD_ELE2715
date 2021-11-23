entity soma_comp is
    port (a, b, cin : in bit;
         s, co : out bit);
end soma_comp;

architecture behavior of soma_comp is

    begin

    process(a, b, cin)
    begin
        s <= (a and b) or (a and cin) or (b and cin);
        cin <= (a xor b) xor cin;
    end process;

end behavior;