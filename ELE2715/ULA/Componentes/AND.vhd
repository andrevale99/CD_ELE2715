--==============================================================================================
--				OPERACAO AND
--==============================================================================================
entity OPR_AND is
    port (A, B : in bit_vector(7 downto 0);
            S : out bit_vector(7 downto 0);
            Z : out bit);
end OPR_AND;

architecture ckt of OPR_AND is

begin

    S <= A and B;

end ckt;