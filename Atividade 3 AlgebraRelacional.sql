1. Valor total de VENDAS do mês 4 do ano de 2024

SELECT SUM(VEN_TOTAL) AS VALOR_TOTAL
FROM MAT_VENDAS
WHERE EXTRACT(MONTH FROM VEN_DATA) = 4
  AND EXTRACT(YEAR FROM VEN_DATA) = 2024;
  
  ALGEBRA RELACIONAL:
  γ SUM(VEN_TOTAL)→VALOR_TOTAL ( σ₍MÊS(VEN_DATA)=4 ∧ ANO(VEN_DATA)=2024₎(MAT_VENDAS) )
  
  ------------------------------------------------------------------------------------------------------------------------------------------
2. Valor total de VENDAS do mês 4 do ano de 2024, por cliente


  SELECT C.CLI_COD, C.CLI_NOME, SUM(V.VEN_TOTAL) AS VALOR_TOTAL
FROM MAT_VENDAS V
JOIN MAT_CLIENTES C ON V.CLI_COD = C.CLI_COD
WHERE EXTRACT(MONTH FROM V.VEN_DATA) = 4
  AND EXTRACT(YEAR FROM V.VEN_DATA) = 2024
GROUP BY C.CLI_COD, C.CLI_NOME;

ALGEBRA RELACIONAL:
γ CLI_COD, CLI_NOME; SUM(VEN_TOTAL)→VALOR_TOTAL
  ( σ₍MÊS(VEN_DATA)=4 ∧ ANO(VEN_DATA)=2024₎
    ( MAT_VENDAS ⨝₍MAT_VENDAS.CLI_COD=MAT_CLIENTES.CLI_COD₎ MAT_CLIENTES ) )

-----------------------------------------------------------------------------------------------------------------------------------------------
3. Código e nome dos produtos com estoque = 0


SELECT PRO_COD, PRO_NOME
FROM MAT_PRODUTOS
WHERE PRO_ESTOQUE = 0;

ALGEBRA RELACIONAL:
π PRO_COD, PRO_NOME ( σ₍PRO_ESTOQUE=0₎(MAT_PRODUTOS) )

-----------------------------------------------------------------------------------------------------------------------------------------------
4. Número da VENDA e data da VENDA com o maior valor mês 4 do ano de 2024

SELECT VEN_COD, VEN_DATA, VEN_TOTAL
FROM MAT_VENDAS
WHERE EXTRACT(MONTH FROM VEN_DATA) = 4
  AND EXTRACT(YEAR FROM VEN_DATA) = 2024
  AND VEN_TOTAL = (
      SELECT MAX(VEN_TOTAL)
      FROM MAT_VENDAS
      WHERE EXTRACT(MONTH FROM VEN_DATA) = 4
        AND EXTRACT(YEAR FROM VEN_DATA) = 2024
  );
  
ALGEBRA RELACIONAL:

π VEN_COD, VEN_DATA, VEN_TOTAL
  ( σ₍VEN_TOTAL=MAXVAL₎(
      σ₍MÊS(VEN_DATA)=4 ∧ ANO(VEN_DATA)=2024₎(MAT_VENDAS)
      ×
      γ MAX(VEN_TOTAL)→MAXVAL ( σ₍MÊS(VEN_DATA)=4 ∧ ANO(VEN_DATA)=2024₎(MAT_VENDAS) )
  ) )