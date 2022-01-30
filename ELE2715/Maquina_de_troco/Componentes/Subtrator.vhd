--==============================================================================================
--				LOGICA DO SUBTRATOR COMPLETO
--==============================================================================================
entity COMPSUB is
    port ( a, b : in bit;
            Ti : in bit;
            Tout : out bit;
            S : out bit);
end COMPSUB;

architecture ckt of COMPSUB is

begin

    Tout <= (not a and b) or (not a and Ti) or (b and Ti);
    S <= (a xor b) xor Ti;

end ckt;

--==============================================================================================
--				SUBTRATOR DE 6 BITS
--==============================================================================================
entity SUB6 is
    port (A, B : in bit_vector(5 downto 0);
            Ti : in bit;
            Tout : out bit;
            S : out bit_vector(5 downto 0));
end SUB6;

architecture ckt of SUB6 is

    component COMPSUB is
        port ( a, b : in bit;
                Ti : in bit;
                Tout : out bit;
                S : out bit);
    end component;

    signal borrow : bit_vector(4 downto 0);

begin

    Q1 : COMPSUB port map (A(0), B(0), Ti, borrow(0), S(0));
    Q2 : COMPSUB port map (A(1), B(1), borrow(0), borrow(1), S(1));
    Q3 : COMPSUB port map (A(2), B(2), borrow(1), borrow(2), S(2));
    Q4 : COMPSUB port map (A(3), B(3), borrow(2), borrow(3), S(3));
    Q5 : COMPSUB port map (A(4), B(4), borrow(3), borrow(4), S(4));
    Q6 : COMPSUB port map (A(5), B(5), borrow(4), Tout, S(5));

end ckt;

--==============================================================================================
--				SUBTRATOR DE 10 BITS
--==============================================================================================
entity SUB10 is
    port (A, B : in bit_vector(9 downto 0);
            Ti : in bit;
            Tout : out bit;
            S : out bit_vector(9 downto 0));
end SUB10;

architecture ckt of SUB10 is

    component COMPSUB is
        port ( a, b : in bit;
                Ti : in bit;
                Tout : out bit;
                S : out bit);
    end component;

    signal borrow : bit_vector(8 downto 0);

begin

    Q1 : COMPSUB port map (A(0), B(0), Ti, borrow(0), S(0));
    Q2 : COMPSUB port map (A(1), B(1), borrow(0), borrow(1), S(1));
    Q3 : COMPSUB port map (A(2), B(2), borrow(1), borrow(2), S(2));
    Q4 : COMPSUB port map (A(3), B(3), borrow(2), borrow(3), S(3));
    Q5 : COMPSUB port map (A(4), B(4), borrow(3), borrow(4), S(4));
    Q6 : COMPSUB port map (A(5), B(5), borrow(4), borrow(5), S(5));
	Q7 : COMPSUB port map (A(6), B(6), borrow(5), borrow(6), S(6));
	Q8 : COMPSUB port map (A(7), B(7), borrow(6), borrow(7), S(7));
	Q9 : COMPSUB port map (A(8), B(8), borrow(7), borrow(8), S(8));
   Q10 : COMPSUB port map (A(9), B(9), borrow(8), Tout, S(9));

end ckt;