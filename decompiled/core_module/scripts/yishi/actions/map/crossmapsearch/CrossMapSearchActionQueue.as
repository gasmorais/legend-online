package yishi.actions.map.crossmapsearch
{
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.space.SpaceManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.scene.SceneManager;
   
   public class CrossMapSearchActionQueue implements IEnterFrame
   {
      
      private static var _instance:CrossMapSearchActionQueue;
      
      private var _actionList:Vector.<CrossMapSearchAction> = new Vector.<CrossMapSearchAction>();
      
      public var map1:Array;
      
      public var map2:Array;
      
      private var _isStart:Boolean = false;
      
      public function CrossMapSearchActionQueue()
      {
         super();
         map1 = [{
            "from":10000,
            "to":20001,
            "by":5
         },{
            "from":20001,
            "to":20002,
            "by":2000102
         },{
            "from":20002,
            "to":20003,
            "by":2000202
         },{
            "from":20003,
            "to":20004,
            "by":2000341
         }];
         map2 = [{
            "from":20004,
            "to":20003,
            "by":2000401
         },{
            "from":20003,
            "to":20002,
            "by":2000301
         },{
            "from":20002,
            "to":20001,
            "by":2000201
         },{
            "from":20001,
            "to":10000,
            "by":2000150
         }];
      }
      
      public static function get instance() : CrossMapSearchActionQueue
      {
         if(!_instance)
         {
            _instance = new CrossMapSearchActionQueue();
         }
         return _instance;
      }
      
      public function searchPath(param1:int, param2:int) : Array
      {
         var _loc8_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         var _loc7_:int = 0;
         for each(var _loc6_:Object in map1)
         {
            if(_loc6_.from == param1)
            {
               _loc4_ = _loc7_;
            }
            if(_loc6_.to == param2)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         if(_loc4_ == -1 || _loc5_ < _loc4_)
         {
            _loc8_ = map2;
         }
         else
         {
            _loc8_ = map1;
         }
         _loc7_ = 0;
         for each(_loc6_ in _loc8_)
         {
            if(_loc6_.from == param1)
            {
               _loc4_ = _loc7_;
            }
            if(_loc6_.to == param2)
            {
               _loc5_ = _loc7_;
            }
            _loc7_++;
         }
         if(_loc4_ >= 0 && _loc5_ >= 0)
         {
            _loc3_ = _loc8_.slice(_loc4_,_loc5_ + 1);
         }
         return _loc3_;
      }
      
      public function addAction(param1:CrossMapSearchAction) : void
      {
         if(!_isStart)
         {
            start();
         }
         _actionList.push(param1);
      }
      
      public function enterFrame() : void
      {
         var _loc2_:CrossMapSearchAction = null;
         var _loc3_:String = null;
         var _loc1_:CampaignMapModel = null;
         if(_actionList.length > 0)
         {
            _loc2_ = _actionList[0];
            _loc3_ = SceneManager.instance.currentType;
            if(_loc3_ == "SPACE_SCENE")
            {
               if(_loc2_.mapId == SpaceManager.instance.mapId)
               {
                  excute();
               }
               return;
            }
            _loc1_ = CampaignManager.instance.mapModel;
            if(_loc1_)
            {
               if(_loc2_.mapId == _loc1_.mapId)
               {
                  excute();
               }
               return;
            }
         }
         else
         {
            stop();
         }
      }
      
      private function excute() : void
      {
         var _loc1_:CrossMapSearchAction = _actionList.shift();
         _loc1_.update();
         if(_actionList.length <= 0)
         {
            stop();
         }
      }
      
      public function clean() : void
      {
         _actionList.length = 0;
         stop();
      }
      
      public function start() : void
      {
         _isStart = true;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function stop() : void
      {
         _isStart = false;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

