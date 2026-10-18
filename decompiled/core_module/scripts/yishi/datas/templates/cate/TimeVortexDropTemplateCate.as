package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import mvc.module.timevortex.TimeVortexDropTemplateInfo;
   
   public class TimeVortexDropTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TimeVortexDropTemplateCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Index;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,TimeVortexDropTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

