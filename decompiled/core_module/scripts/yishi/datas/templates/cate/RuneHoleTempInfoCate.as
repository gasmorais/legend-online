package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RuneHoleTempInfo;
   
   public class RuneHoleTempInfoCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RuneHoleTempInfoCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,RuneHoleTempInfo,_tempXml) as RuneHoleTempInfo;
            }
         }
         _list = null;
      }
      
      public function getGroupList(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:RuneHoleTempInfo in _dic)
         {
            if(_loc3_.Length >= param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("Id",16);
         return _loc2_;
      }
      
      public function getInfoById(param1:int) : RuneHoleTempInfo
      {
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
   }
}

