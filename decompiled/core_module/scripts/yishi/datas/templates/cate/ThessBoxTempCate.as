package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ThessBoxTempInfo;
   
   public class ThessBoxTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function ThessBoxTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function getTempByChapterId(param1:int) : ThessBoxTempInfo
      {
         return _dic["" + param1];
      }
      
      public function getAllCapters() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:ThessBoxTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id",16);
         return _loc1_;
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         var _loc3_:ThessBoxTempInfo = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@Id + "";
               _loc3_ = createNode(_loc1_,ThessBoxTempInfo,null) as ThessBoxTempInfo;
               _dic[_loc2_] = _loc3_;
            }
         }
         _list = null;
      }
   }
}

