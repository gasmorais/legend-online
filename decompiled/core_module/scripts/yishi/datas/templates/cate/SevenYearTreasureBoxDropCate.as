package yishi.datas.templates.cate
{
   import yishi.datas.templates.SevenYearTreasureBoxDropTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class SevenYearTreasureBoxDropCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function SevenYearTreasureBoxDropCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:SevenYearTreasureBoxDropTemplate = null;
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@site;
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = [];
               }
               _loc2_ = createNode(_loc1_,SevenYearTreasureBoxDropTemplate,_tempXml) as SevenYearTreasureBoxDropTemplate;
               _dic[_loc3_].push(_loc2_);
            }
         }
         _list = null;
      }
      
      public function getTemplatesByDropId(param1:int) : Array
      {
         return _dic[param1];
      }
      
      public function getTemplates() : SimpleDictionary
      {
         return _dic;
      }
   }
}

