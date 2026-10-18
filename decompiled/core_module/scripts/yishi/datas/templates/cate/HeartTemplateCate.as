package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.HeartTemplateData;
   
   public class HeartTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      public function HeartTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      private function initDic() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,HeartTemplateData);
               }
            }
         }
      }
      
      public function getTemplatesById(param1:int) : HeartTemplateData
      {
         initDic();
         return _dic[param1];
      }
   }
}

