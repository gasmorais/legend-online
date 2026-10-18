package manager
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LanguageAnalyzer;
   import flash.utils.Dictionary;
   
   public class LanguageMgr
   {
      
      private static var _dic:Dictionary;
      
      private static var _hasSetup:Boolean = false;
      
      private static var _reg:RegExp = /\{(\d+)\}/;
      
      public function LanguageMgr()
      {
         super();
      }
      
      public static function get hasSetup() : Boolean
      {
         return _hasSetup;
      }
      
      public static function setup(param1:LanguageAnalyzer) : void
      {
         _dic = param1.languages;
         _hasSetup = true;
      }
      
      public static function GetTranslation(param1:String, ... rest) : String
      {
         var _loc5_:int = 0;
         if(!_hasSetup)
         {
            return "";
         }
         var _loc3_:String = _dic[param1] ? _dic[param1] : "";
         var _loc4_:Object = _reg.exec(_loc3_);
         while(_loc4_ && rest.length > 0)
         {
            _loc5_ = int(_loc4_[1]);
            if(_loc5_ >= 0 && _loc5_ < rest.length)
            {
               _loc3_ = _loc3_.replace(_reg,rest[_loc5_]);
            }
            else
            {
               _loc3_ = _loc3_.replace(_reg,"{}");
            }
            _loc4_ = _reg.exec(_loc3_);
         }
         if(DisplayLoader.isDebug)
         {
            if(_loc3_ == "")
            {
               DeficiencyLanguage.instance.saveDeficiencyKey(param1);
            }
         }
         return _loc3_;
      }
      
      public static function replaceTranslation(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:RegExp = null;
         var _loc5_:String = _dic[param1];
         if(_loc5_ != null)
         {
            _loc4_ = new RegExp(param2,"ig");
            _loc5_ = _loc5_.replace(_loc4_,param3);
            _dic[param1] = _loc5_;
         }
      }
      
      public static function replaceTansByKey(param1:String, param2:String) : void
      {
         _dic[param1] = _dic[param2];
      }
   }
}

