package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.FinalRoadGroupTempInfo;
   
   public class FinalRoadGroupTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function FinalRoadGroupTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@GroupId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,FinalRoadGroupTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTempInfoById(param1:int) : FinalRoadGroupTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:FinalRoadGroupTempInfo in _loc3_)
         {
            if(_loc2_.GroupId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getTempInfoByChapterLevel(param1:int, param2:int) : FinalRoadGroupTempInfo
      {
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:FinalRoadGroupTempInfo in _loc4_)
         {
            if(_loc3_.BelongChapter == param1 && _loc3_.Sort == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getMaxByChapter(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:FinalRoadGroupTempInfo in _loc4_)
         {
            if(_loc3_.BelongChapter == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_ * 5;
      }
   }
}

