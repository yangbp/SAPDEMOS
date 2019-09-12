FUNCTION demo_rfm_classic_exception.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  EXCEPTIONS
*"      CLASSIC_EXCEPTION
*"----------------------------------------------------------------------

  MESSAGE e888(sabapdemos) WITH text-cle RAISING classic_exception.


ENDFUNCTION.
