package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import mvc.module.dayGuide.DailyItemInfo;
   
   public class ActiveTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function ActiveTemplateCate(param1:XMLList)
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
                  _dic[_loc2_] = createNode(_loc1_,DailyItemInfo,_tempXml);
               }
            }
         }
         _loc2_ = null;
         return _dic;
      }
   }
}

