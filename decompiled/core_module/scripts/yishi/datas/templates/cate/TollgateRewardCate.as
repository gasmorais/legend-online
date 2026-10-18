package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.BoxItemTemplate;
   
   public class TollgateRewardCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _arr:Array;
      
      private var _tempXml:XML;
      
      private var isSort:Boolean = false;
      
      private var _score:int = -1;
      
      public function TollgateRewardCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _arr = [];
      }
      
      public function getTemplatesListByNeedScore() : void
      {
         var _loc3_:XMLList = null;
         var _loc4_:BoxItemTemplate = null;
         var _loc1_:Array = null;
         if(_list && !isSort)
         {
            isSort = true;
            _loc3_ = _list;
            for each(var _loc2_:XML in _loc3_)
            {
               _loc4_ = new BoxItemTemplate();
               _loc4_.TemplateId = _loc2_.@ItemId;
               _loc4_.Count = _loc2_.@Count;
               _loc4_.Param1 = _list.@NeedScore;
               if(_score != _loc2_.@NeedScore)
               {
                  _loc1_ = [];
                  _loc1_.push(_loc4_);
                  _arr.push(_loc1_);
                  _score = _loc2_.@NeedScore;
               }
               else
               {
                  _loc1_.push(_loc4_);
               }
            }
         }
      }
      
      public function get arr() : Array
      {
         return _arr;
      }
   }
}

