package mvc.module.chesspvp
{
   import flash.utils.Dictionary;
   
   public class ChessPvpModel
   {
      
      public var chessTypeDic:Dictionary = new Dictionary();
      
      public var selfGroupInfo:ChessPvpGroupInfo = new ChessPvpGroupInfo();
      
      public var selfInfo:ChesspvpRoleInfo;
      
      public var boradInfo:ChessPvpBoardInfo = new ChessPvpBoardInfo();
      
      public var result:int = -1;
      
      public var needAlertResult:Boolean = false;
      
      public var rankTime:String;
      
      public function ChessPvpModel()
      {
         super();
      }
      
      public function clean() : void
      {
         for(var _loc1_:Object in chessTypeDic)
         {
            delete chessTypeDic[_loc1_];
         }
         boradInfo.clean();
      }
   }
}

