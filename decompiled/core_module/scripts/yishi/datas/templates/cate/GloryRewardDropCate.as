package yishi.datas.templates.cate
{
   import yishi.datas.templates.GloryRewardTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class GloryRewardDropCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function GloryRewardDropCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:GloryRewardTemplate = null;
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@site;
               _loc2_ = createNode(_loc1_,GloryRewardTemplate,_tempXml) as GloryRewardTemplate;
               _dic[_loc3_] = _loc2_;
            }
         }
         _list = null;
      }
      
      public function getTemplatesByIndex(param1:int) : GloryRewardTemplate
      {
         if(_dic[param1])
         {
            return _dic[param1];
         }
         return new GloryRewardTemplate();
      }
   }
}

