package yishi.actions.map
{
   import com.road.yishi.proto.simple.FightOverMoiveMsg;
   import mvc.module.armyII.BaseArmy;
   import yishi.scene.SceneManager;
   
   public class BattleGetMoviesAction extends MapBaseAction
   {
      
      private var _msg:FightOverMoiveMsg;
      
      private var _count:int;
      
      private var _total:int;
      
      private var _baseArmy:BaseArmy;
      
      public function BattleGetMoviesAction(param1:BaseArmy, param2:FightOverMoiveMsg)
      {
         super();
         _msg = param2;
         _baseArmy = param1;
         if(_msg.gold > 0)
         {
            _total = _total + 1;
         }
         if(_msg.gp > 0)
         {
            _total = _total + 1;
         }
         if(_msg.strategy > 0)
         {
            _total = _total + 1;
         }
      }
      
      override public function prepare() : void
      {
      }
      
      override public function update() : void
      {
         _count = _count + 1;
         var _loc1_:String = SceneManager.instance.currentType;
         if(_loc1_ != "CAMPAIGN_MAP_SCENE")
         {
            if(_count > 10)
            {
               dispose();
            }
            return;
         }
         if(_count < 400)
         {
            _count = 400;
         }
         if(_count >= 410 && (_count - 410) % 10 == 0)
         {
            run();
         }
         if(_count > 500)
         {
            dispose();
         }
      }
      
      private function run() : void
      {
         if(_msg.gold > 0)
         {
            _baseArmy.battleGold = _msg.gold;
            _msg.gold = 0;
         }
         else if(_msg.gp > 0)
         {
            _baseArmy.battleGp = _msg.gp;
            _msg.gp = 0;
         }
         else if(_msg.strategy > 0)
         {
            _baseArmy.battleStrategy = _msg.strategy;
            _msg.strategy = 0;
         }
         _total = _total - 1;
         if(_total <= 0)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _baseArmy = null;
         _msg = null;
      }
   }
}

