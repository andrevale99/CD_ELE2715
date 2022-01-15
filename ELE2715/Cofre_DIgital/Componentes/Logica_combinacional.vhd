--========================================
--	LOGICA COMBINACIONAL DA MDE
--========================================

entity LOGEST is
    port(  ONN, ADD, COMPT5, COMPT20, COMPS : in bit;
            S: in bit_vector(3 downto 0);
            TELA, OUTT, R, G, B : out bit;
            N : out bit_vector(3 downto 0));
end LOGEST;

architecture ckt of LOGEST is

    begin

    N(0) <= (ONN and not ADD and (not S(3) and not S(2) and not S(1) and not S(0)))
            or (not S(3) and not S(2) and not S(1) and S(0) and not COMPT5)
            or ((not S(3) and not S(2) and S(1) and not S(0)) and ((ONN and not ADD) or (not ONN and ADD)))
            or (not S(3) and not S(2) and S(1) and S(0) and not COMPT5)
            or (not S(3) and S(2) and not S(1) and not S(0) and ((not ONN and ADD) or (ONN and not ADD))) 
            or (not S(3) and S(2) and not S(1) and S(0) and not COMPT5) 
            or (not S(3) and S(2) and S(1) and not S(0) and ((ONN and not ADD) or ( not ONN and ADD))) 
            or (not S(3) and S(2) and S(1) and S(0) and not COMPT5) 
            or (S(3) and not S(2) and not S(1) and not S(0) and COMPS) 
            or (S(3) and not S(2) and not S(1) and S(0) and not COMPT20) 
            or (S(3) and S(2) and S(1) and S(0) and ( not COMPT5 and( not ONN and not ADD)));

    N(1) <= (not S(3) and not S(2) and not S(1) and S(0) and COMPT5)
            or (not S(3) and not S(2) and S(1) and not S(0) and ((not ONN and not ADD) or (ONN and ADD) or (ONN and not ADD) or (not ONN and ADD)))
            or (not S(3) and not S(2) and S(1) and S(0) and not COMPT5)
            or (not S(3) and S(2) and not S(1) and not S(0) and (ONN and not ADD))
            or (not S(3) and S(2) and not S(1) and S(0) and COMPT5 and (not ONN and not ADD))
            or (not S(3) and S(2) and S(1) and not S(0) and ((ONN and not ADD) or (not ONN and ADD) or (not ONN and not ADD) or (ONN and ADD))) 
            or (not S(3) and S(2) and S(1) and S(0) and not COMPT5) 
            or (S(3) and not S(2) and not S(1) and S(0) and COMPT20) 
            or (S(3) and not S(2) and S(1) and not S(0) and ((not ONN and ADD) or (ONN and not ADD) or (ONN and ADD))) 
            or (S(3) and S(2) and S(1) and S(0) and (not COMPT5 and ( not ONN and not ADD)));

    N(2) <= (not S(3) and not S(2) and S(1) and not S(0) and (ONN and not ADD)) 
            or (not S(3) and not S(2) and S(1) and S(0) and COMPT5 and (not ADD and not ONN)) 
            or (not S(3) and S(2) and not S(1) and not S(0) and ((not ADD and not ONN) or (ADD and ONN) or (ONN and not ADD) or (not ONN and ADD))) 
            or (not S(3) and S(2) and not S(1) and S(0) and (not COMPT5 or COMPT5)) 
            or (not S(3) and S(2) and S(1) and not S(0) and ((ONN and not ADD) or (not ONN and ADD) or (not ONN and not ADD) or (ONN and ADD))) 
            or (not S(3) and S(2) and S(1) and S(0) and not COMPT5) 
            or (S(3) and S(2) and S(1) and S(0) and (not COMPT5 and (not ONN and not ADD)));

    N(3) <= (not S(3) and not S(2) and S(1) and not S(0) and (ONN and not ADD)) 
            or ( not S(3) and S(2) and not S(1) and not S(0) and (ONN and not ADD) )
            or ( not S(3) and S(2) and S(1) and not S(0) and (ONN and not ADD)) 
            or ( not S(3) and S(2) and S(1) and S(0) and COMPT5 and (not ONN and not ADD)) 
            or (S(3) and not S(2) and not S(1) and not S(0) and COMPS) 
            or (S(3) and not S(2) and not S(1) and S(0) and (not COMPT20 or COMPT20)) 
            or (S(3) and not S(2) and S(1) and not S(0) and ((not ONN and ADD) or (ONN and not ADD) or (ONN and ADD)))
            or (S(3) and S(2) and S(1) and S(0) and (not COMPT5 and (not ONN and not ADD)));

    R <= (not S(3) and not S(2) and not S(1) and not S(0)) 
         or (not S(3) and not S(2) and S(1) and not S(0))
         or (not S(3) and S(2) and not S(1) and not S(0))
         or (not S(3) and S(2) and S(1) and not S(0))
         or (S(3) and not S(2) and S(1) and not S(0));

    G <= S(3) and not S(2) and not S(1) and S(0);

    B <= (not S(3) and not S(2) and not S(1) and S(0))
         or (not S(3) and not S(2) and S(1) and S(0))
         or (not S(3) and S(2) and not S(1) and S(0))
         or (not S(3) and S(2) and S(1) and S(0))
         or (S(3) and not S(2) and not S(1) and not S(0))
         or (S(3) and S(2) and S(1) and S(0));

    OUTT <= S(3) and not S(2) and not S(1) and S(0);

    TELA <= S(3) or S(2) or S(1) or S(0);


end ckt;