package yishi.manager
{
   import yishi.datas.templates.GloryRoadDropTemplateInfo;
   import yishi.datas.templates.cate.TemplateCate;
   import yishi.utils.SimpleDictionary;
   
   public class GloryRoadDropTemplateCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function GloryRoadDropTemplateCate(param1:XMLList)
      {
         super(param1);
      }
      
      public function getTemplates() : SimpleDictionary
      {
         var _loc2_:GloryRoadDropTemplateInfo = null;
         if(_list)
         {
            if(!_dic)
            {
               _dic = new SimpleDictionary();
               for each(var _loc1_:XML in _list)
               {
                  _loc2_ = createNode(_loc1_,GloryRoadDropTemplateInfo,_tempXml) as GloryRoadDropTemplateInfo;
                  _dic.add(_loc2_.id,_loc2_);
               }
            }
         }
         return _dic;
      }
   }
}

