package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GloryRoadBufferTemplateInfo;
   import yishi.datas.templates.cate.TemplateCate;
   
   public class GloryRoadBufferTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GloryRoadBufferTemplateCate(param1:XMLList)
      {
         super(param1);
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:int = 0;
         if(_list)
         {
            if(!_dic)
            {
               _dic = new Dictionary();
               for each(var _loc1_:XML in _list)
               {
                  _loc2_ = int(_loc1_.@TemplateId);
                  _dic[_loc2_] = createNode(_loc1_,GloryRoadBufferTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
   }
}

