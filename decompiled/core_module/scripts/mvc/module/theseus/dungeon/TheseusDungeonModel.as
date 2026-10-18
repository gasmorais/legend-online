package mvc.module.theseus.dungeon
{
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.TheseusDungeonInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class TheseusDungeonModel
   {
      
      public var blockInfo:Array = [];
      
      public var tasks:Array = [];
      
      public var skillIdList:Array = [];
      
      public var level:int;
      
      public var dayPurchasableActionNum:int;
      
      public var freeActionNum:int;
      
      public var buyActionNum:int;
      
      public var maxUnlockedLevel:int;
      
      public function TheseusDungeonModel()
      {
         super();
      }
      
      private function getCurrentDay() : int
      {
         var _loc1_:Date = null;
         var _loc2_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc2_.castle_offset == -1)
         {
            _loc1_ = _loc2_.sysCurtime;
         }
         else
         {
            _loc1_ = DateFormatter.getTimezoneOffsetDate(_loc2_.castle_offset);
         }
         return _loc1_.date;
      }
      
      public function getCurrentUnlockedLevel() : int
      {
         var _loc3_:int = getCurrentDay();
         var _loc2_:int = 0;
         var _loc4_:Array = TempleteManager.instance.theseusDungeonCate.getAlltemps();
         for each(var _loc1_:TheseusDungeonInfo in _loc4_)
         {
            if(_loc3_ >= _loc1_.TimeUnlock)
            {
               if(_loc1_.TemplateId > _loc2_)
               {
                  _loc2_ = int(_loc1_.TemplateName);
               }
            }
         }
         return _loc2_;
      }
   }
}

