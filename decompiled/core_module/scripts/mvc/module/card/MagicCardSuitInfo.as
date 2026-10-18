package mvc.module.card
{
   import yishi.datas.templates.MagicCardSuiteTemplateInfo;
   
   public class MagicCardSuitInfo
   {
      
      private var _suiteId:int;
      
      public var suiteBuffs:Array = [];
      
      public var cardInfos:Array = [];
      
      private var magicCardSuiteTemplate:MagicCardSuiteTemplateInfo;
      
      public var icon:String;
      
      public function MagicCardSuitInfo()
      {
         super();
      }
      
      public function get suiteId() : int
      {
         return _suiteId;
      }
      
      public function set suiteId(param1:int) : void
      {
      }
   }
}

