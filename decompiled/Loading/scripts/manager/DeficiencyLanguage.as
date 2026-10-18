package manager
{
   import com.pickgliss.loader.LanguageAnalyzer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class DeficiencyLanguage extends EventDispatcher
   {
      
      public static const CHANGE_EVENT:String = "change_event";
      
      private static var _instance:DeficiencyLanguage;
      
      private var _isInit:Boolean;
      
      private var _analyzer:LanguageAnalyzer;
      
      private var _dic:Dictionary;
      
      private var _deficiencyLanguageKeysVec:Vector.<String>;
      
      public function DeficiencyLanguage()
      {
         super();
      }
      
      public static function get instance() : DeficiencyLanguage
      {
         return _instance || (_instance = new DeficiencyLanguage());
      }
      
      public function init() : void
      {
         if(_isInit)
         {
            return;
         }
         _deficiencyLanguageKeysVec = new Vector.<String>();
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.addEventListener("complete",onComplete,false,0,true);
         _loc1_.addEventListener("ioError",onError,false,0,true);
         _loc1_.load(new URLRequest("../../debug/src/Script/language_main.txt"));
         _isInit = true;
      }
      
      public function saveDeficiencyKey(param1:String) : void
      {
         if(!_dic)
         {
            return;
         }
         var _loc2_:String = param1 + ":" + _dic[param1];
         if(_deficiencyLanguageKeysVec.indexOf(_loc2_) > -1)
         {
            return;
         }
         _deficiencyLanguageKeysVec.push(_loc2_);
         this.dispatchEvent(new Event("change_event"));
      }
      
      public function get deficiencyLanguageKeysLen() : int
      {
         return _deficiencyLanguageKeysVec.length;
      }
      
      public function get deficiencyLanguageKeys() : String
      {
         return "当前记录缺失字总数：" + _deficiencyLanguageKeysVec.length + "  ，分别是：\n" + _deficiencyLanguageKeysVec.join("\n");
      }
      
      private function onComplete(param1:Event) : void
      {
         param1.currentTarget.removeEventListener("complete",onComplete);
         param1.currentTarget.removeEventListener("ioError",onError);
         var _loc2_:String = param1.target.data;
         _analyzer = new LanguageAnalyzer(setup);
         _analyzer.analyze(_loc2_);
      }
      
      private function onError(param1:IOErrorEvent) : void
      {
         param1.currentTarget.removeEventListener("complete",onComplete);
         param1.currentTarget.removeEventListener("ioError",onError);
         throw new Error("加载主干翻译包错误,请检查路径与文件名是否为  ui/zh_cn/language_main.txt \n" + param1);
      }
      
      private function setup(param1:LanguageAnalyzer) : void
      {
         _dic = param1.languages;
      }
   }
}

