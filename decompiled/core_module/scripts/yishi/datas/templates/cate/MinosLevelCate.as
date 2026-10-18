package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.MinosLevelTempInfo;
   
   public class MinosLevelCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function MinosLevelCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,MinosLevelTempInfo);
               }
            }
         }
         _loc2_ = null;
      }
      
      public function getTemplateByID(param1:int) : MinosLevelTempInfo
      {
         return _dic["" + param1];
      }
      
      public function getAllLevels() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MinosLevelTempInfo in _dic)
         {
            _loc1_.push(_loc2_);
         }
         _loc1_.sortOn("Id",16);
         return _loc1_;
      }
   }
}

