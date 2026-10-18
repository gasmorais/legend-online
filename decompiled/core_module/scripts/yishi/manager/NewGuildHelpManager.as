package yishi.manager
{
   public class NewGuildHelpManager
   {
      
      public static var newGuildHelpXml:XML;
      
      private static var _instance:NewGuildHelpManager;
      
      private static var _hasSetup:Boolean = false;
      
      private var frameXmlList:XMLList;
      
      private var viewXmlList:XMLList;
      
      public function NewGuildHelpManager()
      {
         super();
      }
      
      public static function get Instance() : NewGuildHelpManager
      {
         if(!_instance)
         {
            _instance = new NewGuildHelpManager();
         }
         return _instance;
      }
      
      public static function get hasSetup() : Boolean
      {
         return _hasSetup;
      }
      
      public function setup(param1:XML) : void
      {
         newGuildHelpXml = param1;
         frameXmlList = newGuildHelpXml..frame;
         _hasSetup = true;
      }
      
      public function getFrameDataByFrameName(param1:String) : XML
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < frameXmlList.length())
         {
            if(param1 == frameXmlList[_loc2_].@frameName)
            {
               return frameXmlList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getViewDataByViewIndex(param1:String) : XMLList
      {
         var _loc2_:XML = getFrameDataByFrameName(param1);
         var _loc3_:int = ArmyManager.instance.thane.grades;
         var _loc4_:* = _loc4_ = _loc2_.view.(@isShow == true).(@minGrade <= _loc3_);
         if(_loc4_)
         {
            return _loc4_;
         }
         return null;
      }
   }
}

