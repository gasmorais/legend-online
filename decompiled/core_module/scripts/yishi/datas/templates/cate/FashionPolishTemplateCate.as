package yishi.datas.templates.cate
{
   import yishi.datas.templates.FashionPolishTemplateInfo;
   import yishi.utils.SimpleDictionary;
   
   public class FashionPolishTemplateCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      public function FashionPolishTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@SonType + "/" + _loc1_.@Level;
               _dic[_loc2_] = createNode(_loc1_,FashionPolishTemplateInfo,_tempXml) as FashionPolishTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTemplates() : SimpleDictionary
      {
         return _dic;
      }
      
      public function getTemplatesByNeedCount() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:FashionPolishTemplateInfo in _dic)
         {
            if(_loc2_.NeedCount > 0)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn(4,"NeedCount");
         return _loc1_;
      }
      
      public function getTeamplateByLevel(param1:int) : FashionPolishTemplateInfo
      {
         var _loc3_:FashionPolishTemplateInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = getTemplatesByNeedCount().reverse();
         var _loc4_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc5_];
            if(_loc3_.Level >= param1)
            {
               return _loc3_;
            }
            _loc5_ += 1;
         }
         return null;
      }
      
      public function getTemplatesByLevelAndPos(param1:int, param2:int) : FashionPolishTemplateInfo
      {
         var _loc3_:String = param2 + "/" + param1;
         return _dic[_loc3_];
      }
   }
}

