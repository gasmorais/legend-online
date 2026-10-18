package mvc.module.chesspvp
{
   public class ChessPvpOp
   {
      
      public static var EVENT_OP_FUN:String = "chesspvp.OP_FUN";
      
      public static var EVENT_CHESS_UPDATE:String = "chesspvp.CHESS_UPDATE";
      
      public static var ENENT_CHESS_RESULT:String = "chesspvp.CHESS_RESULT";
      
      public static var OP_OPEN:int = 1;
      
      public static var OP_CLOSE:int = 2;
      
      public static var OP_SIGN:int = 3;
      
      public static var OP_EDIT:int = 4;
      
      public static var OP_FIGHT:int = 5;
      
      public static var OP_VIEW_RANK:int = 6;
      
      public static var OP_VIEW_RECORD:int = 7;
      
      public static var BOARD_OP_ROLE_LEAVE:int = 1;
      
      public static var BOARD_OP_ROLE_MOVE:int = 2;
      
      public static var BOARD_OP_ROLE_CHANGE:int = 3;
      
      public function ChessPvpOp()
      {
         super();
      }
   }
}

