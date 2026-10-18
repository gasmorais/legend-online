package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.NewActiveLeedInfo;
   
   public class NewActiveLeedCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NewActiveLeedCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,NewActiveLeedInfo,_tempXml) as NewActiveLeedInfo;
            }
         }
         _list = null;
      }
      
      public function getInfoArrByType(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:NewActiveLeedInfo in _dic)
         {
            if(_loc4_.MasterType == param1 && _loc4_.SonType == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         _loc3_.sort(sortByStateAndId);
         return _loc3_;
      }
      
      public function getInfoByTaskType(param1:int, param2:int, param3:int) : NewActiveLeedInfo
      {
         var _loc4_:Array = getInfoArrByType(param1,param2);
         for each(var _loc5_:NewActiveLeedInfo in _loc4_)
         {
            if(_loc5_.TaskType == param3)
            {
               return _loc5_;
            }
         }
         return null;
      }
      
      private function sortByStateAndId(param1:NewActiveLeedInfo, param2:NewActiveLeedInfo) : int
      {
         if(!param1.isComplete && param2.isComplete)
         {
            return -1;
         }
         if(param1.isComplete && !param2.isComplete)
         {
            return 1;
         }
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         if(param1.Sort > param2.Sort)
         {
            return 1;
         }
         return 0;
      }
   }
}

