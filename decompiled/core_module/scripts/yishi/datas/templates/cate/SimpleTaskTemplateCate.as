package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SimpleTaskTempInfo;
   
   public class SimpleTaskTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SimpleTaskTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TaskId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,SimpleTaskTempInfo,_tempXml);
               }
            }
         }
         _loc2_ = null;
         return _dic;
      }
      
      public function getSimpleTaskTemp(param1:int) : SimpleTaskTempInfo
      {
         return _dic[param1];
      }
   }
}

