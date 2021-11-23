entity meio_soma is
    port(a,b : in bit;
        s, co : out bit);
end meio_soma;

architecture behavior of meio_soma is

    begin
        process(a, b)
        begin
            co <= a and b;
            s <= a xor b;
        end process;

end behavior;