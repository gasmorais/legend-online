package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PlaneCrisisEventTempInfo;
   
   public class PlaneCrisisEventTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function PlaneCrisisEventTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@EventId;
               _dic[_loc2_] = createNode(_loc1_,PlaneCrisisEventTempInfo,_tempXml) as PlaneCrisisEventTempInfo;
            }
         }
         _list = null;
      }
      
      public function getEventTempInfo(param1:int) : PlaneCrisisEventTempInfo
      {
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getEventTempInfoByType(param1:int) : PlaneCrisisEventTempInfo
      {
         for each(var _loc2_:PlaneCrisisEventTempInfo in _dic)
         {
            if(_loc2_ && _loc2_.EventType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

