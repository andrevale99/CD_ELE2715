--==============================================================================================
--				OPERACAO XOR
--==============================================================================================
entity OPR_XOR is
    port (A, B : in bit_vector(7 downto 0);
            S : out bit_vector(7 downto 0);
            Z : out bit);
end OPR_XOR;

architecture ckt of OPR_XOR is

begin

    S <= A xor B;

end ckt;