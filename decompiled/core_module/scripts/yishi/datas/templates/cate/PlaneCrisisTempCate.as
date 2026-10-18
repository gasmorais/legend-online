package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   
   public class PlaneCrisisTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function PlaneCrisisTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@MapId + "_" + _loc1_.@NodeId;
               _dic[_loc2_] = createNode(_loc1_,PlaneCrisisTempInfo,_tempXml) as PlaneCrisisTempInfo;
            }
         }
         _list = null;
      }
      
      public function getNodeTempInfo(param1:int, param2:int) : PlaneCrisisTempInfo
      {
         var _loc3_:String = param1 + "_" + param2;
         return _dic[_loc3_];
      }
      
      public function getOneMapNodes(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:PlaneCrisisTempInfo in _dic)
         {
            if(_loc3_.MapId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

