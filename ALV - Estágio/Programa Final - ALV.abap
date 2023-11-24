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