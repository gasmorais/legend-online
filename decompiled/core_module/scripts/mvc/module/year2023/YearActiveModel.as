package mvc.module.year2023
{
   import manager.LanguageMgr;
   
   public class YearActiveModel
   {
      
      public var opType:int;
      
      public var checkinInfo:String;
      
      public var buyCheckin:Boolean;
      
      public var miniGameState:int;
      
      public var boxInfo:String;
      
      public var boxLevel:int;
      
      public var boxNext:Boolean;
      
      public var eggCount:int;
      
      public var showInfo:String;
      
      public var curDay:int;
      
      public function YearActiveModel()
      {
         super();
         replaceLanKey();
      }
      
      public function replaceLanKey() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("yearactivity.replaceName");
         var _loc2_:String = LanguageMgr.GetTranslation("yearactivity.name");
         LanguageMgr.replaceTranslation("darkmaze.darkMazeSpringFrame.descTxt1",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.darkMazeDemonFrame.descTxt1",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips4",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips5",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips6",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips7",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips8",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.topToolsBar.clickTips9",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.darkMazeMainFrame.helpFrame.title",_loc1_,_loc2_);
         LanguageMgr.replaceTranslation("darkmaze.darkMazeMainFrame.helpFrame.Content",_loc1_,_loc2_);
         LanguageMgr.replaceTansByKey("darkmaze.darkMazeMainFrame.helpFrame.Content","yearactive.darkMazeMainFrame.helpFrame.Content");
      }
   }
}

