package mvc.module.chesspvp
{
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   
   public class ChessPvpBoardInfo
   {
      
      public var boardUid:String;
      
      public var currTime:String;
      
      public var teamDic:SimpleDictionary = new SimpleDictionary();
      
      public var boxDic:SimpleDictionary = new SimpleDictionary();
      
      public var roleDic:SimpleDictionary = new SimpleDictionary();
      
      private var _endTime:String;
      
      private var _endDate:Date;
      
      public function ChessPvpBoardInfo()
      {
         super();
      }
      
      public function clean() : void
      {
         var _loc1_:Array = roleDic.getList();
         for each(var _loc2_:ChesspvpRoleInfo in _loc1_)
         {
            _loc2_.clean();
         }
         roleDic.clear();
      }
      
      public function initBoxChangeState() : void
      {
         var _loc1_:Array = boxDic.getList();
         for each(var _loc2_:ChesspvpBoxInfo in _loc1_)
         {
            _loc2_.isChange = false;
         }
      }
      
      public function set endTime(param1:String) : void
      {
         if(_endTime == param1)
         {
            return;
         }
         _endTime = param1;
         _endDate = DateFormatter.parse(_endTime,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function get endDate() : Date
      {
         return _endDate;
      }
   }
}

