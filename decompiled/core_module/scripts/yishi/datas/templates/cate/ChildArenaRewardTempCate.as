package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ChildArenaRewardTemplateInfo;
   
   public class ChildArenaRewardTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ChildArenaRewardTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByTypeAndRank(param1:int, param2:int) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_:ChildArenaRewardTemplateInfo in getTemplates())
         {
            if(_loc3_.site == param1 && _loc3_.para2 == param2)
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc4_.sortOn("id",16);
         return _loc4_;
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,ChildArenaRewardTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

