package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.FinalRoadChapterTempInfo;
   
   public class FinalRoadChapterTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function FinalRoadChapterTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@ChapterId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,FinalRoadChapterTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getTempInfoById(param1:int) : FinalRoadChapterTempInfo
      {
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:FinalRoadChapterTempInfo in _loc3_)
         {
            if(_loc2_.ChapterId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getChapterCount() : int
      {
         var _loc1_:int = 1;
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:FinalRoadChapterTempInfo in _loc3_)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

