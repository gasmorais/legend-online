package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import yishi.datas.templates.MagicCardSuiteTemplateInfo;
   
   public class MagicCardSuiteTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function MagicCardSuiteTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _tempXml = describeType(MagicCardSuiteTemplateInfo);
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
                  _dic[_loc2_] = createNode(_loc1_,MagicCardSuiteTemplateInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getTemplateByID(param1:int) : MagicCardSuiteTemplateInfo
      {
         var _loc2_:XML = null;
         if(!_dic[param1] && _list)
         {
            _loc2_ = _list.(@TemplateId == param1)[0];
            if(_loc2_)
            {
               _dic[param1] = createNode(_loc2_,MagicCardSuiteTemplateInfo,_tempXml);
            }
         }
         return _dic[param1] as MagicCardSuiteTemplateInfo;
      }
   }
}

