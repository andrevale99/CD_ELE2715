entity ckt is 
    port(A,B: in bit;
        X: out bit);
end ckt;

architecture ckt_arch of ckt is
    begin
    process (A,B)
        begin
        X <= A and B;
    end process;
end ckt_arch;