package map.campaign.mediator.molong
{
   import battle.BattleManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.BoxInfoMsg;
   import com.road.yishi.proto.campaign.DragonCampaingnDataMsg;
   import com.road.yishi.proto.campaign.RollInfoMsg;
   import events.ObjectsEvent;
   import flash.events.Event;
   import flash.geom.Point;
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
   import map.campaign.view.ui.molong.BoxCountDown;
   import map.campaign.view.ui.molong.MolongBox;
   import map.campaign.view.ui.molong.MolongSocketOut;
   import map.campaign.view.ui.molong.NextBossTip;
   import map.campaign.view.ui.pvpmap.PvpPlayerRiverView;
   import map.internals.data.CampaignNode;
   import ui.toptoolbar.TopToolsBar;
   import yishi.GlobalConfig;
   import yishi.datas.BattleModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class MolongManager
   {
      
      private static var _instance:MolongManager;
      
      private var _boxArr:Array;
      
      public var startTimeShaizi:Number;
      
      public var startTimeAcceptMolongInfo:Number;
      
      public var reconnectedInfo:DragonCampaingnDataMsg;
      
      private var _restTime:Number = 0;
      
      private var _isBeginning:Boolean = false;
      
      private var _isShowShaiziView:Boolean = false;
      
      protected var _selfArmy:CampaignArmy;
      
      protected var _riverView:PvpPlayerRiverView;
      
      protected var _bossPos:Point;
      
      private const BOX_R:int = 350;
      
      private const BOX_POS:Array = [[0,1],[0.5,0.87],[0.87,0.5],[1,0],[0.87,-0.5],[0.5,-0.87],[0,-1],[-0.5,-0.87],[-0.87,-0.5],[-1,0],[-0.87,0.5],[-0.5,0.87],[-0.6,-0.9],[0,-0.9],[-0.9,0]];
      
      protected var _selfArmyView:CampaignArmyView;
      
      protected var _isShowCannotGetBox:Boolean = false;
      
      protected var _boxCountDown:BoxCountDown;
      
      private var _getedBoxIds:Array = [];
      
      public function MolongManager()
      {
         super();
         try
         {
            _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
            _selfArmy.addEventListener("IS_DIE",__dieHandler);
            StageReferance.stage.addEventListener("resize",__stageResize);
         }
         catch(e:Error)
         {
         }
      }
      
      public static function get instance() : MolongManager
      {
         if(!_instance)
         {
            _instance = new MolongManager();
         }
         return _instance;
      }
      
      public function get isShowShaiziView() : Boolean
      {
         return _isShowShaiziView;
      }
      
      public function set isShowShaiziView(param1:Boolean) : void
      {
         _isShowShaiziView = param1;
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
         var _loc3_:Array = null;
         var _loc2_:CampaignNode = null;
         var _loc4_:int = 0;
         var _loc1_:Date = null;
         TopToolsBar.instance.hideActioveContain();
         if(_bossPos == null)
         {
            if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel)
            {
               _loc3_ = CampaignManager.instance.mapModel.mapNodesData;
               _loc2_ = _loc3_[0] as CampaignNode;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  if(_loc3_[_loc4_].param1 == 2)
                  {
                     _loc2_ = _loc3_[_loc4_] as CampaignNode;
                  }
                  _loc4_++;
               }
               _bossPos = new Point(_loc2_.info.posX,_loc2_.info.posY);
            }
         }
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel)
         {
            _selfArmyView = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
            _selfArmyView.addEventListener("WALK_NEXT",__walkNextHandler);
         }
         MsgMan.addObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",this,doShaizi);
         if(reconnectedInfo != null)
         {
            if(reconnectedInfo.state != 1)
            {
               if(reconnectedInfo.state == 2)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
               }
               else if(reconnectedInfo.state == 5)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
               }
               else if(reconnectedInfo.state == 3)
               {
                  showShaiziView();
                  MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
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
            MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
            countDownInit();
         }
      }
      
      protected function __walkNextHandler(param1:ObjectsEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:MolongBox = null;
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
                        MolongSocketOut.getBox(_loc5_.indexBox);
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
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.campaignTemplate.Types == 13)
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
         var _loc2_:Boolean = false;
         _getedBoxIds = [];
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.rollInfos && CampaignManager.instance.mapModel.rollInfos.length > 0)
         {
            _loc2_ = false;
            for each(var _loc1_:RollInfoMsg in CampaignManager.instance.mapModel.rollInfos)
            {
               if(CampaignManager.instance.mapModel.selfMemberData.userId == _loc1_.userId)
               {
                  _loc2_ = true;
                  break;
               }
            }
            if(_loc2_)
            {
               if(!isShowShaiziView)
               {
                  FrameControllerManager.instance.molongControler.startFrameByType();
               }
            }
         }
      }
      
      protected function doShaizi(param1:String, param2:Array) : void
      {
         if(CampaignManager.instance.mapModel == null)
         {
            return;
         }
         showShaiziView();
         MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
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
      
      private function reconnectedFallBoxes() : void
      {
         var _loc7_:MolongBox = null;
         var _loc4_:BoxInfoMsg = null;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         _isShowCannotGetBox = false;
         _boxArr = [];
         var _loc1_:Array = BOX_POS.concat();
         var _loc9_:Array = [];
         var _loc5_:int = int(reconnectedInfo.boxInfos.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ >= 15)
            {
               break;
            }
            _loc9_.push(_loc1_.splice(NumberViewUtils.randomAtoB(0,_loc1_.length - 1),1));
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            if(_loc6_ >= 15)
            {
               break;
            }
            _loc4_ = reconnectedInfo.boxInfos[_loc6_] as BoxInfoMsg;
            if(_loc4_.statu != 1)
            {
               _loc2_ = _loc9_[_loc6_][0][0] * 350 + _bossPos.x * 20;
               _loc3_ = _loc9_[_loc6_][0][1] * 350 + _bossPos.y * 20;
               _loc7_ = new MolongBox(_loc4_.boxId);
               _loc7_.x = _loc2_;
               _loc7_.y = _loc3_;
               _boxArr.push(_loc7_);
            }
            _loc6_++;
         }
         _boxArr.sort(sortDepth);
         _loc5_ = int(_boxArr.length);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
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
      
      public function disposeCountDown() : void
      {
         ObjectUtils.disposeObject(_riverView);
         _riverView = null;
      }
      
      private function getBoxNumber(param1:RollInfoMsg) : int
      {
         var _loc2_:int = param1.rollNum * 2;
         if(param1.specialNums == 1)
         {
            _loc2_ += 3;
         }
         if(param1.specialNums == 2)
         {
            _loc2_ += 1;
         }
         return _loc2_;
      }
      
      protected function fallBoxes(param1:String, param2:Object) : void
      {
         var _loc9_:MolongBox = null;
         var _loc8_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:RollInfoMsg = param2 as RollInfoMsg;
         var _loc6_:int = getBoxNumber(_loc11_);
         _isShowCannotGetBox = false;
         _boxArr = [];
         var _loc3_:Array = BOX_POS.concat();
         var _loc12_:Array = [];
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(_loc8_ >= 15)
            {
               break;
            }
            _loc12_.push(_loc3_.splice(NumberViewUtils.randomAtoB(0,_loc3_.length - 1),1));
            _loc8_++;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(_loc8_ >= 15)
            {
               break;
            }
            _loc4_ = _loc12_[_loc8_][0][0] * 350 + _bossPos.x * 20;
            _loc5_ = _loc12_[_loc8_][0][1] * 350 + _bossPos.y * 20;
            _loc9_ = new MolongBox(_loc8_ + 1);
            _loc9_.x = _loc4_;
            _loc9_.y = _loc5_;
            _boxArr.push(_loc9_);
            _loc8_++;
         }
         _boxArr.sort(sortDepth);
         var _loc7_:int = int(_boxArr.length);
         _loc10_ = 0;
         while(_loc10_ < _loc7_)
         {
            CampaignMapView(CampaignManager.instance.mapView).mainBuidingLayer.addChild(_boxArr[_loc10_]);
            _loc10_++;
         }
         setTimeout(clearBoxes,30 * 1000);
         initBoxCountDown(30 * 1000);
         if(_loc11_ && !_loc11_.isLast)
         {
            NextBossTip.instance().showTip();
         }
      }
      
      private function sortDepth(param1:MolongBox, param2:MolongBox) : int
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
         for each(var _loc1_:MolongBox in _boxArr)
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
         var _loc2_:Date = null;
         reconnectedInfo = param1;
         startTimeAcceptMolongInfo = getTimer();
         BattleManager.molongLayer = param1.curRound;
         _loc2_ = new Date();
         BattleManager.molongCountDownTime = _loc2_.time + reconnectedInfo.campaignTm;
      }
      
      public function forBattle() : void
      {
         MolongManager.instance.isShowShaiziView = false;
         clearBoxes();
         MsgMan.removeObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",this,doShaizi);
         MsgMan.removeObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
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
         MolongManager.instance.isShowShaiziView = false;
         TopToolsBar.instance.show();
         clearBoxes();
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         MsgMan.removeObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",this,doShaizi);
         MsgMan.removeObserver("map.campaign.view.ui.molong.FALL_BOXES",this,fallBoxes);
         ObjectUtils.disposeObject(_boxCountDown);
         _boxCountDown = null;
         ObjectUtils.disposeObject(_riverView);
         _riverView = null;
         if(reconnectedInfo)
         {
            reconnectedInfo = null;
         }
         if(_bossPos)
         {
            _bossPos = null;
         }
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT",__walkNextHandler);
         }
         _instance = null;
      }
   }
}

