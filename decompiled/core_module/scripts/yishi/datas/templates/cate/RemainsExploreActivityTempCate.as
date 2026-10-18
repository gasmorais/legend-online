package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RemainsExploreActivityInfo;
   
   public class RemainsExploreActivityTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreActivityTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,RemainsExploreActivityInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByType(param1:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Dictionary = getTemplates();
         for each(var _loc2_:RemainsExploreActivityInfo in _loc4_)
         {
            if(_loc2_.MasterType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
   }
}

