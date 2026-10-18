package mvc.module.demonland
{
   import yishi.datas.templates.DemonLandTemplate;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.TempleteManager;
   
   public class DemonLandModel
   {
      
      public static const CHAPTER_TOTAL_COUNT:int = 30;
      
      public static const CHAPTER_NODE_COUNT:int = 10;
      
      public var selectedChapter:int;
      
      public var selectedNode:int;
      
      public var maxChapterId:int;
      
      public var maxNodeId:int;
      
      public var myStar:int;
      
      public var boxState:String;
      
      public var nodeList:Array;
      
      public var myTear:int;
      
      public var tearBuyCount:int;
      
      public var isChapterEndBoss:Boolean = false;
      
      public var preMaxChapterId:int;
      
      public var isOpenSelectFrame:Boolean = false;
      
      public function DemonLandModel()
      {
         super();
         nodeList = [];
      }
      
      public static function get MAX_TEAR() : int
      {
         var _loc1_:String = TempleteManager.instance.getConfigInfoByConfigName("evilland_goddess_tear_config").ConfigValue;
         return int(_loc1_.split(",")[0]);
      }
      
      public function get isPassed() : Boolean
      {
         var _loc1_:Boolean = false;
         if(selectedChapter < maxChapterId)
         {
            _loc1_ = true;
         }
         else if(selectedChapter == maxChapterId)
         {
            if(selectedNode < maxNodeId)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function checkIsNeedBuyAlert() : Boolean
      {
         var _loc1_:DemonLandTemplate = TempleteManager.instance.demonLandTemplateCate.getTemplateByChapterAndNodeId(selectedChapter,selectedNode);
         var _loc2_:String = TempleteManager.instance.getConfigInfoByConfigName("evilland_goddess_tear_config").ConfigValue;
         var _loc4_:int = OldPlayerReturnManager.instance.model.demonLandCount;
         var _loc3_:int = int(_loc2_.split(",")[2]) + _loc4_ - tearBuyCount;
         if(myTear < _loc1_.Cost && _loc3_ > 0)
         {
            return true;
         }
         return false;
      }
   }
}

