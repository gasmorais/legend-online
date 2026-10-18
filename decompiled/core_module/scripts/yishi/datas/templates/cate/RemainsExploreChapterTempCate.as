package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RemainsExploreChaterTempInfo;
   
   public class RemainsExploreChapterTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreChapterTempCate(param1:XMLList)
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
                  _dic[_loc2_] = createNode(_loc1_,RemainsExploreChaterTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getChapterName(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc3_:RemainsExploreChaterTempInfo in _loc4_)
         {
            if(_loc3_.ChapterId == param1)
            {
               _loc2_ = _loc3_.ChapterName;
               break;
            }
         }
         return _loc2_;
      }
      
      public function get count() : int
      {
         var _loc1_:int = 0;
         var _loc3_:Dictionary = getTemplates();
         for each(var _loc2_:RemainsExploreChaterTempInfo in _loc3_)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}

