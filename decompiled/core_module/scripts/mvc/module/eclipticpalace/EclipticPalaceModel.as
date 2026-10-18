package mvc.module.eclipticpalace
{
   import yishi.utils.MsgMan;
   
   public class EclipticPalaceModel
   {
      
      public var curLayer:int;
      
      public var selectedRoute:int;
      
      public var curSpirit:int;
      
      public var recoverCountDown:int;
      
      public var declineCountDown:int;
      
      public var recoverEndTime:Number;
      
      public var declineEndTime:Number;
      
      public var popEvent:Boolean = false;
      
      public var routeList:Array;
      
      public var rewardList:Array;
      
      public var fightIndex:int;
      
      public var isEventBoss:Boolean;
      
      public var isChallengeOver:Boolean;
      
      public var openEclipticPalaceFrame:Boolean;
      
      private var _selectPath:int = 1;
      
      public function EclipticPalaceModel()
      {
         super();
         routeList = [];
         rewardList = [];
      }
      
      public function get selectPath() : int
      {
         return _selectPath;
      }
      
      public function set selectPath(param1:int) : void
      {
         if(_selectPath == param1)
         {
            return;
         }
         _selectPath = param1;
         setFightIndex();
         MsgMan.notifyObserver("SELECT_PATH");
      }
      
      public function setFightIndex() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:EclipticPalaceBossInfo = null;
         if(routeList.length <= 0)
         {
            return;
         }
         var _loc2_:int = selectedRoute != 0 ? selectedRoute : selectPath;
         var _loc4_:EclipticPalaceRouteInfo = routeList[_loc2_ - 1];
         if(!_loc4_)
         {
            return;
         }
         var _loc1_:Array = _loc4_.bossList;
         if(selectedRoute == 0)
         {
            fightIndex = 0;
            isEventBoss = _loc1_[0].hiddenEvent;
            isChallengeOver = false;
            return;
         }
         _loc5_ = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc6_ = _loc1_[_loc3_];
            if(_loc6_.defeated)
            {
               _loc5_++;
            }
            _loc3_++;
         }
         if(_loc5_ >= _loc1_.length && curLayer == 12)
         {
            isChallengeOver = true;
            fightIndex = -1;
            isEventBoss = false;
         }
         else
         {
            isChallengeOver = false;
            fightIndex = _loc5_;
            isEventBoss = _loc1_[fightIndex].hiddenEvent;
         }
      }
      
      public function get selectRouteInfo() : EclipticPalaceRouteInfo
      {
         var _loc1_:int = selectedRoute != 0 ? selectedRoute : selectPath;
         if(routeList.length < 0)
         {
            return null;
         }
         return routeList[_loc1_ - 1];
      }
   }
}

