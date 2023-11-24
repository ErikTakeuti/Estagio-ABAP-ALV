# Estagio-ABAP-ALV

### INCLUDE TOP - ALV

```abap
TABLES: zvendas_02,
        zprodutos_02.

TYPE-POOLS: slis.

TYPES: BEGIN OF vl_vendas,

         venda        TYPE zvendas_02-venda,
         item         TYPE zvendas_02-item,
         produto      TYPE zvendas_02-produto,
         desc_produto TYPE zprodutos_02-desc_produto,
         quantidade   TYPE zvendas_02-quantidade,
         preco        TYPE zvendas_02-preco,
         data         TYPE zvendas_02-data,
         hora         TYPE zvendas_02-hora,

       END OF vl_vendas.
**********************************************************************

DATA: gt_saida    TYPE STANDARD TABLE OF vl_vendas,
      ls_saida    LIKE LINE OF gt_saida,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      g_repid     TYPE sy-repid.
```
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### INCLUDE TELA DE SELEÇÃO - ALV

```abap
SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: sl_venda FOR  zvendas_02-venda,
                sl_prod FOR zvendas_02-produto,
                sl_data FOR zvendas_02-data.
SELECTION-SCREEN END OF BLOCK a1.
```

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### INCLUDE FO1 - ROTINAS - ALV

```abap
FORM z_sapgui_progress_indicator USING VALUE(pv_text).

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
*     PERCENTAGE = 0
      text = pv_text.

ENDFORM.

**********************************************************************

FORM z_select_data.

PERFORM z_sapgui_progress_indicator
USING 'Selecionando dados. Aguarde...'.

SELECT cv~venda "SELECIONA OS VALORES
       cv~item
       cv~produto
       cp~desc_produto
       cv~quantidade
       cv~preco
       cv~data
       cv~hora
  INTO CORRESPONDING FIELDS OF TABLE gt_saida "PUXA A TABELA
  FROM  zvendas_02 AS cv "TABELA CORRESPONDENTE A VVARIAVEL
  INNER JOIN zprodutos_02 AS cp ON cp~produto = cv~produto "USAR O INNER JOIN PARA PUXAR A TABELA E COLOCAR UM CAMPO
  WHERE cv~venda IN sl_venda
  AND cv~produto IN sl_prod
  AND cv~data IN sl_data."PUXAR DA TELA DE SELEÇÃO

ENDFORM.

**********************************************************************
FORM z_list_display.
  PERFORM z_sapgui_progress_indicator
  USING 'Estruturando a lista. Aguarde...'.
  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
      i_callback_program = g_repid
*     i_structure_name   = 'VBAK'
      it_fieldcat        = gt_fieldcat
      i_save             = 'A'
    TABLES
      t_outtab           = gt_saida
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
* Verificar processamento da função
  IF sy-subrc NE 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

 ENDFORM.



 FORM z_fielcat USING pt_fieldcat TYPE slis_t_fieldcat_alv.

  DATA: lf_fieldcat TYPE slis_fieldcat_alv.

  CLEAR pt_fieldcat[].


  lf_fieldcat-fieldname = 'VENDA'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'ITEM'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'PRODUTO'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'DESC_PRODUTO'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZPRODUTOS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'QUANTIDADE'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'PRECO'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'DATA'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

  lf_fieldcat-fieldname = 'HORA'. " Nome do Campo
  lf_fieldcat-ref_tabname = 'ZVENDAS_02'. " Tab. de Referência
  APPEND lf_fieldcat TO pt_fieldcat. " Gravar na tab. config.

ENDFORM.
```
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### PROGRAMA FINAL - ALV

```abap
REPORT zprog_011_02.

**********************************************************************

INCLUDE ZPROG_011_02_TOP. "VARIÁVEIS

**********************************************************************

INCLUDE ZPROG_011_02_TELA. "TELA

**********************************************************************

INCLUDE ZPROG_011_02_F01. "ROTINAS

**********************************************************************

INITIALIZATION.
  g_repid = sy-repid.

**********************************************************************

START-OF-SELECTION.

  PERFORM z_select_data.

  PERFORM z_fielcat USING gt_fieldcat.

END-OF-SELECTION.

  PERFORM z_list_display.
```
