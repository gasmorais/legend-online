package battle.control
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.utils.SoundManager;
   import flash.utils.Dictionary;
   import yishi.datas.BattleModel;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   
   public class BattleMapSoundControl
   {
      
      public static var mapMusicRecord:Dictionary = new Dictionary();
      
      public function BattleMapSoundControl()
      {
         super();
      }
      
      public function start() : void
      {
         playMapMusic();
         addHandler();
      }
      
      private function addHandler() : void
      {
      }
      
      private function onBattleMusicOnOff(param1:BattleEvent) : void
      {
         if(SharedManager.instance.allowMusic)
         {
            playMapMusic();
         }
         else
         {
            SoundManager.instance.stopMusic();
         }
      }
      
      private function playMapMusic() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc1_:int = 0;
         var _loc3_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc3_.battleType == 17)
         {
            _loc2_ = 0;
         }
         else if(_loc3_.isBossBattle())
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = TempleteManager.instance.mapTemplateCate.getTemplateByID(_loc3_.mapId).BattleGround + 1;
         }
         var _loc4_:Array = SoundManager.instance.getBattleMapMusics(_loc2_);
         var _loc6_:Array = SoundManager.instance.getMusicListByType("battle");
         if(_loc4_ && _loc4_.length > 0)
         {
            _loc5_ = getMusicIndex(_loc4_,_loc2_);
            _loc7_ = _loc4_[_loc5_];
            _loc1_ = _loc6_.indexOf(_loc7_);
            if(_loc1_ == -1)
            {
               _loc1_ = _loc6_.length - 1;
            }
         }
         else
         {
            _loc1_ = _loc6_.length - 1;
         }
         if(_loc1_ > _loc6_.length - 1)
         {
            _loc1_ = _loc6_.length - 1;
         }
         SoundManager.instance.playMusic("battle",_loc1_);
      }
      
      private function getMusicIndex(param1:Array, param2:int) : int
      {
         if(mapMusicRecord[param2] == undefined)
         {
            mapMusicRecord[param2] = 0;
            return 0;
         }
         var _loc3_:int = int(mapMusicRecord[param2]);
         if(++_loc3_ > param1.length - 1)
         {
            _loc3_ = 0;
         }
         mapMusicRecord[param2] = _loc3_;
         return _loc3_;
      }
      
      public function dispose() : void
      {
      }
   }
}

