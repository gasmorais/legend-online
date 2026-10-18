package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.SecretEventTemplate;
   
   public class SecretEventCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      public function SecretEventCate(param1:XMLList)
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
               _loc2_ = "" + _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,SecretEventTemplate,_tempXml) as SecretEventTemplate;
            }
         }
         _list = null;
      }
      
      public function getEventTempInfo(param1:int) : SecretEventTemplate
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getEventTempByFunType(param1:int) : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:Array = [];
         for each(var _loc3_:SecretEventTemplate in _dic)
         {
            if(_loc3_.FunType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getEventTempByType(param1:int) : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:Array = [];
         for each(var _loc3_:SecretEventTemplate in _dic)
         {
            if(_loc3_.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

