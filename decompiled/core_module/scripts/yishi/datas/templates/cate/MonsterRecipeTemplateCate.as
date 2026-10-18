package yishi.datas.templates.cate
{
   import yishi.datas.templates.MonsterRecipeTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class MonsterRecipeTemplateCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function MonsterRecipeTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
      }
      
      public function getTemplateByID(param1:int) : MonsterRecipeTempInfo
      {
         var _loc2_:XML = null;
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic.add(param1,createNode(_loc2_,MonsterRecipeTempInfo,_tempXml));
               }
            }
         }
         return _dic[param1];
      }
      
      public function getRecipeList() : Array
      {
         var _loc1_:Array = getTemplates().getList();
         if(_loc1_.length > 0)
         {
            _loc1_.sortOn("TemplateId",16);
         }
         return _loc1_;
      }
      
      public function getTemplates() : SimpleDictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@TemplateId;
               if(!_dic[_loc2_])
               {
                  _dic.add(_loc2_,createNode(_loc1_,MonsterRecipeTempInfo,_tempXml));
               }
            }
         }
         return _dic;
      }
   }
}

