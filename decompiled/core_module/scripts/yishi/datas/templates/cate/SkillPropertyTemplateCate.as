package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SkillPropertyTempInfo;
   
   public class SkillPropertyTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function SkillPropertyTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getTemplateByID(param1:int) : SkillPropertyTempInfo
      {
         var _loc2_:XML = null;
         if(param1 == 0)
         {
            return null;
         }
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,SkillPropertyTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

