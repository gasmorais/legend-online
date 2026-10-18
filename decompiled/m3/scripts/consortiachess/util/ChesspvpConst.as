package consortiachess.util
{
   public class ChesspvpConst
   {
      
      public static const PAWN:int = 1;
      
      public static const ROOK:int = 2;
      
      public static const KNIGHT:int = 3;
      
      public static const BISHOP:int = 4;
      
      public static const QUEEN:int = 5;
      
      public static const KING:int = 6;
      
      public static const ROLE_STATE_STAND:int = 0;
      
      public static const ROLE_STATE_MOVE:int = 1;
      
      public static const ROLE_STATE_FIGHT:int = 2;
      
      public static const ROLE_STATE_DIE:int = 3;
      
      public static const PAWN_RULES_KILL_1:Array = [{
         "x":-1,
         "y":-1
      },{
         "x":1,
         "y":-1
      }];
      
      public static const PAWN_RULES_MOVE_1:Array = [{
         "x":0,
         "y":-1
      },{
         "x":0,
         "y":-2
      }];
      
      public static const PAWN_RULES_KILL_2:Array = [{
         "x":-1,
         "y":1
      },{
         "x":1,
         "y":1
      }];
      
      public static const PAWN_RULES_MOVE_2:Array = [{
         "x":0,
         "y":1
      },{
         "x":0,
         "y":2
      }];
      
      public static const ROOK_RULES:Array = [{
         "x":0,
         "y":-1
      },{
         "x":0,
         "y":1
      },{
         "x":-1,
         "y":0
      },{
         "x":1,
         "y":0
      }];
      
      public static const KNIGHT_RULES:Array = [{
         "x":-2,
         "y":-1
      },{
         "x":-2,
         "y":1
      },{
         "x":-1,
         "y":-2
      },{
         "x":-1,
         "y":2
      },{
         "x":1,
         "y":-2
      },{
         "x":1,
         "y":2
      },{
         "x":2,
         "y":-1
      },{
         "x":2,
         "y":1
      }];
      
      public static const BISHOP_RULES:Array = [{
         "x":-1,
         "y":-1
      },{
         "x":1,
         "y":-1
      },{
         "x":-1,
         "y":1
      },{
         "x":1,
         "y":1
      }];
      
      public static const QUEEN_RULES:Array = [{
         "x":-1,
         "y":-1
      },{
         "x":0,
         "y":-1
      },{
         "x":1,
         "y":-1
      },{
         "x":-1,
         "y":0
      },{
         "x":1,
         "y":0
      },{
         "x":-1,
         "y":1
      },{
         "x":0,
         "y":1
      },{
         "x":1,
         "y":1
      }];
      
      public static const KING_RULES:Array = [{
         "x":-1,
         "y":-1
      },{
         "x":0,
         "y":-1
      },{
         "x":1,
         "y":-1
      },{
         "x":-1,
         "y":0
      },{
         "x":1,
         "y":0
      },{
         "x":-1,
         "y":1
      },{
         "x":0,
         "y":1
      },{
         "x":1,
         "y":1
      }];
      
      public function ChesspvpConst()
      {
         super();
      }
   }
}

