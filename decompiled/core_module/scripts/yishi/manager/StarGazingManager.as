package yishi.manager
{
   import com.road.yishi.proto.stargazing.StarMapInfoMsg;
   import com.road.yishi.proto.stargazing.StargazingInfoMsg;
   import com.road.yishi.proto.stargazing.StargazingOpMsg;
   import com.road.yishi.proto.stargazing.ZodiacSignInfoMsg;
   import mvc.module.stargazing.StarChartInfo;
   import mvc.module.stargazing.StarGazingModel;
   import mvc.module.stargazing.StarPalaceInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class StarGazingManager
   {
      
      private static var _instance:StarGazingManager;
      
      private var _model:StarGazingModel;
      
      public function StarGazingManager()
      {
         super();
         if(!_model)
         {
            _model = new StarGazingModel();
         }
      }
      
      public static function get instance() : StarGazingManager
      {
         if(!_instance)
         {
            _instance = new StarGazingManager();
         }
         return _instance;
      }
      
      public function get model() : StarGazingModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4687,__starGazingMsgBack);
      }
      
      private function __starGazingMsgBack(param1:SLGSocketEvent) : void
      {
         var _loc7_:StarPalaceInfo = null;
         var _loc6_:StarChartInfo = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:StargazingOpMsg = new StargazingOpMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as StargazingOpMsg;
         var _loc5_:StargazingInfoMsg = _loc2_.infoMsg;
         var _loc8_:Boolean = false;
         model.isTurnChange = false;
         if(_loc5_)
         {
            if(_loc5_.hasStarDebris)
            {
               model.starPieceCount = _loc5_.starDebris;
            }
            if(_loc5_.hasStarDebris)
            {
               if(_loc5_.starDesire != model.starDesire)
               {
                  _loc8_ = true;
               }
               model.starDesire = _loc5_.starDesire;
            }
            if(_loc5_.hasNomalRewardCount)
            {
               if(_loc5_.nomalRewardCount > model.normalWishCount)
               {
                  _loc8_ = true;
               }
               model.normalWishCount = _loc5_.nomalRewardCount;
            }
            if(_loc5_.hasSeniorRewardCount)
            {
               if(_loc5_.seniorRewardCount > model.advanceWishCount)
               {
                  _loc8_ = true;
                  model.isTurnChange = true;
               }
               model.advanceWishCount = _loc5_.seniorRewardCount;
            }
            if(_loc5_.hasTotalProperty && _loc5_.totalProperty)
            {
               model.starChartTotalProperty.attack = _loc5_.totalProperty.attack;
               model.starChartTotalProperty.defence = _loc5_.totalProperty.defence;
               model.starChartTotalProperty.magicAttack = _loc5_.totalProperty.magicAttack;
               model.starChartTotalProperty.magicDefence = _loc5_.totalProperty.magicDefence;
               model.starChartTotalProperty.live = _loc5_.totalProperty.live;
            }
            if(_loc5_.zodiacSign && _loc5_.zodiacSign.length > 0)
            {
               for each(var _loc3_:ZodiacSignInfoMsg in _loc5_.zodiacSign)
               {
                  _loc7_ = model.getPalaceInfoByIndex(_loc3_.index);
                  if(!_loc7_)
                  {
                     _loc7_ = new StarPalaceInfo();
                     model.starPalaceList.push(_loc7_);
                  }
                  _loc7_.index = _loc3_.index;
                  _loc7_.totalLightStar = _loc3_.totalLightStar;
                  _loc7_.starChartInfoList = [];
                  for each(var _loc4_:StarMapInfoMsg in _loc3_.starMapMsg)
                  {
                     _loc6_ = new StarChartInfo();
                     _loc7_.starChartInfoList.push(_loc6_);
                     _loc6_.mapIndex = _loc4_.mapIndex;
                     _loc6_.repeatTimes = _loc4_.repeatTimes;
                     _loc6_.fragmentChar = _loc4_.fragmentBitMap;
                     _loc6_.chartProerty.attack = _loc4_.mapProerty.attack;
                     _loc6_.chartProerty.defence = _loc4_.mapProerty.defence;
                     _loc6_.chartProerty.magicAttack = _loc4_.mapProerty.magicAttack;
                     _loc6_.chartProerty.magicDefence = _loc4_.mapProerty.magicDefence;
                     _loc6_.chartProerty.live = _loc4_.mapProerty.live;
                  }
                  _loc7_.starChartInfoList.sortOn("mapIndex",16);
               }
               model.starPalaceList.sortOn("index",16);
            }
         }
         if(_loc2_.op == 2 && _loc8_)
         {
            MsgMan.notifyObserver("STAR_POWER_CHANGE");
         }
         else if(_loc2_.op == 5)
         {
            MsgMan.notifyObserver("STAR_FORCE_POINT_CHANGE");
         }
         else if(_loc2_.op == 6)
         {
            MsgMan.notifyObserver("STAR_CHART_PIECE_CHANGE",{
               "index":_loc2_.index,
               "mapIndex":_loc2_.mapIndex,
               "fragmentIndex":_loc2_.fragmentIndex
            });
         }
         else
         {
            MsgMan.notifyObserver("STAR_VIEW_DATA_CHANGE");
         }
      }
      
      public function sendStarGazingRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5188);
         var _loc3_:StargazingOpMsg = new StargazingOpMsg();
         _loc3_.op = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendStarGazingWish(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5188);
         var _loc3_:StargazingOpMsg = new StargazingOpMsg();
         _loc3_.op = param1;
         _loc3_.useItem = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendStarGazingForceLittle(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(5188);
         var _loc3_:StargazingOpMsg = new StargazingOpMsg();
         _loc3_.op = 5;
         _loc3_.index = param1;
         _loc3_.useItem = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendStarGazingChartUseItem(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5188);
         var _loc2_:StargazingOpMsg = new StargazingOpMsg();
         _loc2_.op = 6;
         _loc2_.mapItemId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

