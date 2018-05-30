
create or replace function TO_NUMBER2( I_STRING in varchar2 ) return number deterministic is

/* **************************************************************************************************

    The TO_NUMBER2 is a more flexibe TO_NUMBER function.
    It is unsensitve for decimal and thousand separators and trailing minus sign as well.
    Returns with null if the input is not a number.

    sample:
    -------
    TO_NUMBER2 ( '-545 847 587 464.23' )

    result:
    -------
    -545847587464,23


    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2017.01.06 |  1.0    | Ferenc Toth    | Created 

**************************************************************************************************** */
    V_STRING    varchar2( 1000 );
    V_NUMBER    number;
begin
    V_STRING := replace( I_STRING, ' ', null );  -- remove thousand separators or any other blank chars
    if substr( V_STRING, -1 ) = '-' then         -- trailing minus sign
        V_STRING := '-'||replace( V_STRING, '-', null );
    end if;
    begin
        V_NUMBER := to_number( V_STRING );
    exception when others then
        -- try to exchange the decimal symbol
        V_STRING := translate( V_STRING, ',.', '.,' );
        V_NUMBER := to_number( V_STRING );
    end;
    return V_NUMBER;
exception when others then
    return null;  -- it is not a number
end;
/
