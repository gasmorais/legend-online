package yishi.datas.templates.cate
{
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.utils.SimpleDictionary;
   
   public class SecretMapLevelCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      public function SecretMapLevelCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         var _loc3_:SecretMapLevelTemplate = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@MapId;
               _loc3_ = createNode(_loc1_,SecretMapLevelTemplate,_tempXml) as SecretMapLevelTemplate;
               _dic.add(_loc2_,_loc3_);
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : SecretMapLevelTemplate
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getTempList() : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         return _dic.getList();
      }
   }
}

