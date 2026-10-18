package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.StarGazingDropTemplateInfo;
   
   public class StarGazingDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function StarGazingDropTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplatesByTypeAndDay(param1:int, param2:int) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc3_:StarGazingDropTemplateInfo in getTemplates())
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
                  _dic[_loc2_] = createNode(_loc1_,StarGazingDropTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

