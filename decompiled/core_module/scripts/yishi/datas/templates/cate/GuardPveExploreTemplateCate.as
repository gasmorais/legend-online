package yishi.datas.templates.cate
{
   import yishi.datas.templates.GuardPveExploreRewardInfo;
   
   public class GuardPveExploreTemplateCate extends TemplateCate
   {
      
      private var _itemList:Array;
      
      private var _tempXml:XML;
      
      public function GuardPveExploreTemplateCate(param1:XMLList)
      {
         super(param1);
         _itemList = [];
         initTemplates();
      }
      
      private function initTemplates() : void
      {
         if(_itemList)
         {
            for each(var _loc1_:XML in _list)
            {
               _itemList.push(createNode(_loc1_,GuardPveExploreRewardInfo,_tempXml));
            }
         }
      }
      
      public function getDropList(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:GuardPveExploreRewardInfo in _itemList)
         {
            if(_loc4_.isSpirit == param1 && _loc4_.grade == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
   }
}

