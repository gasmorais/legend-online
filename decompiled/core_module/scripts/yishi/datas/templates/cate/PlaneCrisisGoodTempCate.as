package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PlaneCrisisDropInfo;
   
   public class PlaneCrisisGoodTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function PlaneCrisisGoodTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc3_:PlaneCrisisDropInfo = null;
         var _loc1_:Array = null;
         var _loc4_:String = null;
         if(_list)
         {
            for each(var _loc2_:XML in _list)
            {
               _loc3_ = createNode(_loc2_,PlaneCrisisDropInfo,_tempXml) as PlaneCrisisDropInfo;
               _loc4_ = _loc2_.@site;
               _loc1_ = _dic[_loc4_];
               if(_loc1_ == null)
               {
                  _loc1_ = [];
                  _dic[_loc4_] = _loc1_;
               }
               _loc1_.push(_loc3_);
            }
         }
         _list = null;
      }
      
      public function getGoodList(param1:int, param2:int) : Array
      {
         var _loc3_:String = param1 + "," + param2;
         return _dic[_loc3_];
      }
   }
}

