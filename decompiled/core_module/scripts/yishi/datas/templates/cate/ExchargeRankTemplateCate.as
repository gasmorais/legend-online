package yishi.datas.templates.cate
{
   import yishi.datas.templates.ExchargeRankTemplate;
   
   public class ExchargeRankTemplateCate extends TemplateCate
   {
      
      private var _arr:Array;
      
      private var _day:int = -1;
      
      private var isSort:Boolean;
      
      public function ExchargeRankTemplateCate(param1:XMLList)
      {
         super(param1);
      }
      
      public function getExchargeRank() : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:ExchargeRankTemplate = null;
         var _loc1_:Array = null;
         if(_list && !isSort)
         {
            isSort = true;
            _loc3_ = _list;
            for each(var _loc2_:XML in _loc3_)
            {
               _loc4_ = new ExchargeRankTemplate();
               _loc4_.day = _loc2_.@day;
               _loc4_.uid = _loc2_.@uid;
               _loc4_.userId = _loc2_.@userId;
               _loc4_.serverName = _loc2_.@serverName;
               _loc4_.nickName = _loc2_.@nickName;
               _loc4_.level = _loc2_.@level;
               _loc4_.fightPower = _loc2_.@fightPower;
               _loc4_.rank = _loc2_.@rank;
               if(_day != _loc2_.@day)
               {
                  _loc1_ = [];
                  _loc1_.push(_loc4_);
                  _arr.push(_loc1_);
                  _day = _loc2_.@day;
               }
               else
               {
                  _loc1_.push(_loc4_);
               }
            }
         }
      }
      
      public function getTemplatesListByDay(param1:int) : Array
      {
         return _arr[param1 - 1];
      }
   }
}

