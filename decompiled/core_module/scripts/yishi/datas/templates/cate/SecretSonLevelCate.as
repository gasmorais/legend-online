package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SecretSonLevelTemplate;
   
   public class SecretSonLevelCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      public function SecretSonLevelCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@LevelId;
               _dic[_loc2_] = createNode(_loc1_,SecretSonLevelTemplate,_tempXml) as SecretSonLevelTemplate;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : SecretSonLevelTemplate
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getSonLvsByMapId(param1:int) : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:Array = [];
         for each(var _loc3_:SecretSonLevelTemplate in _dic)
         {
            if(_loc3_.MapId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

