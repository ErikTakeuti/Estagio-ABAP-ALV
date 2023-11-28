REPORT zprog_011_02.

**********************************************************************

INCLUDE ZPROG_011_02_TOP. "VARIÁVEIS

**********************************************************************

INCLUDE ZPROG_011_02_TELA. "TELA

**********************************************************************

INCLUDE ZPROG_011_02_F01. "ROTINAS

**********************************************************************

INITIALIZATION.
  g_repid = sy-repid. "evento INITIALIZATION para inicializar algumas variáveis

**********************************************************************

START-OF-SELECTION.

  PERFORM z_select_data. "SELEÇÃO DE DADOS

  PERFORM z_fielcat USING gt_fieldcat. "FIELDCAT

END-OF-SELECTION.

  PERFORM z_list_display. "DISPLAY PARA IMPRIMIR A LISTA
