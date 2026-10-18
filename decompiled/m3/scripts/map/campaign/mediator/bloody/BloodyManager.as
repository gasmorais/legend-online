package map.campaign.mediator.bloody
{
   import battle.BattleManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bloodyrealm.EggInfoMsg;
   import com.road.yishi.proto.campaign.BoxInfoMsg;
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.ui.bloody.BloodyBox;
   import map.campaign.view.ui.bloody.BloodySocketOut;
   import map.campaign.view.ui.molong.BoxCountDown;
   import map.campaign.view.ui.pvpmap.PvpPlayerRiverView;
   import ui.toptoolbar.TopToolsBar;
   import yishi.GlobalConfig;
   import yishi.datas.BattleModel;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class BloodyManager
   {
      
      private static var _instance:BloodyManager;
      
      private var _boxArr:Array;
      
      public var startTimeShaizi:Number;
      
      public var waveAlreadyShowDic:Dictionary;
      
      public var expireTime:Number;
      
      public var eggInfo:Array;
      
      public var startTimeAcceptMolongInfo:Number;
      
      public var reconnectedInfo:DragonCampaingnDataMsg;
      
      private var _restTime:Number = 0;
      
      private var _isBeginning:Boolean = false;
      
      protected var _selfArmy:CampaignArmy;
      
      protected var _riverView:PvpPlayerRiverView;
      
      protected var _bornPoint:Point;
      
      private const BOX_POS:Array = [[10,-60],[10,60]];
      
      protected var _selfArmyView:CampaignArmyView;
      
      protected var _isShowCannotGetBox:Boolean = false;
      
      protected var _boxCountDown:BoxCountDown;
      
      protected const AREA_ID:int = 304;
      
      public var myClickEggIndex:int = -1;
      
      public var posInfo:Array;
      
      private var _getedBoxIds:Array = [];
      
      private var states:Array = [0,2201,2202,2203,2200,2210];
      
      public function BloodyManager()
      {
         super();
         try
         {
            posInfo = [0,0,0,0,0,0,0,0,0,0,0,0];
            _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
            _selfArmy.addEventListener("IS_DIE",__dieHandler);
            StageReferance.stage.addEventListener("resize",__stageResize);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function get instance() : BloodyManager
      {
         if(!_instance)
         {
            _instance = new BloodyManager();
         }
         return _instance;
      }
      
      public function getRandomEmptyPos() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = Math.random() * 12;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = (_loc3_ + _loc1_) % 12;
            if(_loc2_ != myClickEggIndex && posInfo[_loc2_] == 0)
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getPosByUserId(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < posInfo.length)
         {
            if(posInfo[_loc2_] == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      protected function __stageResize(param1:Event) : void
      {
         if(_riverView)
         {
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 72;
         }
      }
      
      public function molongInit() : void
      {
         var _loc1_:Date = null;
         waveAlreadyShowDic = new Dictionary(true);
         TopToolsBar.instance.hideActioveContain();
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel)
         {
            _selfArmyView = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
            _bornPoint = new Point(_selfArmyView.x,_selfArmyView.y);
            _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         }
         MsgMan.addObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",this,doShaizi);
         if(reconnectedInfo != null)
         {
            if(reconnectedInfo.state != 1)
            {
               if(reconnectedInfo.state == 2)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
               }
               else if(reconnectedInfo.state == 5)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
               }
               else if(reconnectedInfo.state == 3)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
               }
               else if(reconnectedInfo.state == 4)
               {
                  reconnectedFallBoxes();
               }
            }
            _loc1_ = new Date();
            _restTime = _loc1_.time + reconnectedInfo.campaignTm;
            if(_restTime == 0)
            {
               _isBeginning = true;
            }
            countDownInit();
         }
         else
         {
            if(_restTime == 0 && BattleManager.molongCountDownTime > 0)
            {
               _restTime = BattleManager.molongCountDownTime;
            }
            showShaiziView();
            MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
            countDownInit();
         }
      }
      
      protected function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:BloodyBox = null;
         var _loc2_:Point = null;
         var _loc6_:Point = null;
         var _loc4_:int = 0;
         if(_boxArr && _boxArr.length > 0)
         {
            _loc3_ = int(_boxArr.length);
            _loc2_ = new Point();
            _loc6_ = new Point(CampaignManager.instance.mapModel.selfMemberData.curPosX * 20,CampaignManager.instance.mapModel.selfMemberData.curPosY * 20);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = _boxArr[_loc4_];
               _loc2_.x = _loc5_.x;
               _loc2_.y = _loc5_.y;
               if(Point.distance(_loc2_,_loc6_) < 80)
               {
                  if(GlobalConfig.isGet)
                  {
                     if(_getedBoxIds.indexOf(_loc5_.indexBox) == -1)
                     {
                        _getedBoxIds.push(_loc5_.indexBox);
                        BloodySocketOut.pickUpBox(_loc5_.indexBox);
                        _loc5_.dispose();
                     }
                  }
                  else if(!_isShowCannotGetBox)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.ui.molong.isNotGetTip"));
                     _isShowCannotGetBox = true;
                  }
               }
               _loc4_++;
            }
         }
      }
      
      protected function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.campaignTemplate.AreaId == 304)
         {
            if(CampaignArmyState.checkDied(_selfArmy.isDie))
            {
               if(!_riverView)
               {
                  _riverView = new PvpPlayerRiverView();
               }
               _riverView.riverTime = _selfArmy.riverTime / 1000 - 2;
               LayerManager.Instance.addToLayer(_riverView,4,false);
               _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
               _riverView.y = StageReferance.stageHeight - _riverView.height - 72;
            }
            else
            {
               ObjectUtils.disposeObject(_riverView);
               _riverView = null;
            }
         }
      }
      
      private function showShaiziView() : void
      {
         _getedBoxIds = [];
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.bloodyRollInfos && CampaignManager.instance.mapModel.bloodyRollInfos.length > 0)
         {
            if(!waveAlreadyShowDic[CampaignManager.instance.bloodyCurrentWave])
            {
               myClickEggIndex = -1;
               posInfo = [0,0,0,0,0,0,0,0,0,0,0,0];
               FrameControllerManager.instance.bloodyControl.startFrameByType();
               waveAlreadyShowDic[CampaignManager.instance.bloodyCurrentWave] = true;
            }
         }
      }
      
      protected function doShaizi(param1:String, param2:Array) : void
      {
         if(CampaignManager.instance.mapModel == null || SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         showShaiziView();
         MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
      }
      
      protected function initBoxCountDown(param1:Number) : void
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         if(_boxCountDown == null)
         {
            _loc2_ = new Date();
            _loc3_ = _loc2_.time + param1;
            _boxCountDown = new BoxCountDown(_loc3_);
            _boxCountDown.show();
         }
      }
      
      public function disposeCountDown() : void
      {
         ObjectUtils.disposeObject(_boxCountDown);
         _boxCountDown = null;
         ObjectUtils.disposeObject(_riverView);
         _riverView = null;
      }
      
      private function reconnectedFallBoxes() : void
      {
         var _loc6_:BloodyBox = null;
         var _loc3_:BoxInfoMsg = null;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         _isShowCannotGetBox = false;
         _boxArr = [];
         var _loc4_:int = int(reconnectedInfo.boxInfos.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = reconnectedInfo.boxInfos[_loc5_] as BoxInfoMsg;
            if(_loc3_.statu != 1)
            {
               _loc1_ = BOX_POS[_loc5_][0] + _bornPoint.x;
               _loc2_ = BOX_POS[_loc5_][1] + _bornPoint.y;
               _loc7_ = int(states[eggInfo.state]);
               if(eggInfo.source == 1)
               {
                  _loc7_ = 2210;
               }
               _loc6_ = new BloodyBox(_loc3_.boxId,_loc7_);
               _loc6_.x = _loc1_;
               _loc6_.y = _loc2_;
               _boxArr.push(_loc6_);
            }
            _loc5_++;
         }
         _boxArr.sort(sortDepth);
         _loc4_ = int(_boxArr.length);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            CampaignMapView(CampaignManager.instance.mapView).mainBuidingLayer.addChild(_boxArr[_loc8_]);
            _loc8_++;
         }
         setTimeout(clearBoxes,reconnectedInfo.stateTm);
         initBoxCountDown(reconnectedInfo.stateTm);
      }
      
      public function countDownInit() : void
      {
         var _loc1_:Date = null;
         var _loc2_:int = 0;
         if(BattleModel.battleStartTimePoint != 0)
         {
            if(_isBeginning && _restTime == 0)
            {
               _isBeginning = false;
               _loc1_ = new Date();
               _restTime = _loc1_.time + 1200000 - (getTimer() - BattleModel.battleStartTimePoint);
            }
         }
      }
      
      protected function fallBoxes(param1:String, param2:Object) : void
      {
         var _loc8_:BloodyBox = null;
         CampaignManager.instance.mapModel.bloodyRollInfos = null;
         _isShowCannotGetBox = false;
         var _loc6_:EggInfoMsg = param2 as EggInfoMsg;
         var _loc7_:int = int(_loc6_.id);
         var _loc3_:int = BOX_POS[_loc7_ - 1][0] + _bornPoint.x;
         var _loc4_:int = BOX_POS[_loc7_ - 1][1] + _bornPoint.y;
         var _loc9_:int = int(states[_loc6_.state]);
         if(_loc6_.source == 1)
         {
            _loc9_ = 2210;
         }
         _loc8_ = new BloodyBox(_loc7_,_loc9_);
         _loc8_.x = _loc3_;
         _loc8_.y = _loc4_;
         if(!_boxArr)
         {
            _boxArr = [];
         }
         _boxArr.push(_loc8_);
         var _loc5_:CampaignMapView = CampaignManager.instance.mapView as CampaignMapView;
         _loc5_ && _loc5_.mainBuidingLayer && _loc5_.mainBuidingLayer.addChild(_loc8_);
         setTimeout(clearBoxes,30 * 1000);
         initBoxCountDown(30 * 1000);
      }
      
      private function sortDepth(param1:BloodyBox, param2:BloodyBox) : int
      {
         if(param1.y < param2.y)
         {
            return -1;
         }
         if(param1.x == param2.x && param1.y == param2.y)
         {
            return 0;
         }
         if(param1.y == param2.y && param1.x < param2.x)
         {
            return -1;
         }
         return 1;
      }
      
      protected function clearBoxes() : void
      {
         for each(var _loc1_:BloodyBox in _boxArr)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         _boxArr = [];
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.rollInfos)
         {
            CampaignManager.instance.mapModel.rollInfos = null;
         }
         ObjectUtils.disposeObject(_boxCountDown);
         _boxCountDown = null;
      }
      
      public function acceptedServerInfo(param1:DragonCampaingnDataMsg) : void
      {
         reconnectedInfo = param1;
         startTimeAcceptMolongInfo = getTimer();
         BattleManager.molongLayer = param1.curRound;
         var _loc2_:Date = new Date();
         BattleManager.molongCountDownTime = _loc2_.time + reconnectedInfo.campaignTm;
      }
      
      public function forBattle() : void
      {
         clearBoxes();
         MsgMan.removeObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",this,doShaizi);
         MsgMan.removeObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
         if(reconnectedInfo)
         {
            reconnectedInfo = null;
         }
         BattleManager.molongCountDownTime = _restTime;
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         _isShowCannotGetBox = false;
         ObjectUtils.disposeObject(_boxCountDown);
         _boxCountDown = null;
      }
      
      public function dispose() : void
      {
         _isShowCannotGetBox = false;
         TopToolsBar.instance.show();
         clearBoxes();
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         MsgMan.removeObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",this,doShaizi);
         MsgMan.removeObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,fallBoxes);
         ObjectUtils.disposeObject(_boxCountDown);
         _boxCountDown = null;
         ObjectUtils.disposeObject(_riverView);
         _riverView = null;
         if(reconnectedInfo)
         {
            reconnectedInfo = null;
         }
         if(_bornPoint)
         {
            _bornPoint = null;
         }
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         _instance = null;
      }
   }
}

