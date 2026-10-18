package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.FinalRoadEventTempInfo;
   
   public class FinalRoadEventTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function FinalRoadEventTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@EventId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,FinalRoadEventTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTempInfoById(param1:int) : FinalRoadEventTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:FinalRoadEventTempInfo in _loc3_)
         {
            if(_loc2_.EventId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

