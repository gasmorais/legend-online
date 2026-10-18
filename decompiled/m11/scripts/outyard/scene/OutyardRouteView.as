package outyard.scene
{
   import battle.utils.Int64Utils;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleAreaMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleUserMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.base.OutyardBorderLayer;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardRouteView extends Component implements IEnterFrame
   {
      
      private var _nodeContain:Component;
      
      private var _bg:MovieClip;
      
      private var _borderLayer:OutyardBorderLayer;
      
      private var _slotBg:Bitmap;
      
      private var _occupyLeft:ScaleFrameImage;
      
      private var _occupyRight:ScaleFrameImage;
      
      private var _occupyProgressBar1:MovieClip;
      
      private var _occupyProgressBar2:MovieClip;
      
      private var _coolingStrip:StripView;
      
      private var _coolingBlue:MovieClip;
      
      private var _attackRed:MovieClip;
      
      private var _coolingTxt:FilterFrameText;
      
      private var _coolingNumTxt:FilterFrameText;
      
      private var _attackTxt:FilterFrameText;
      
      private var _leftTower:ScaleFrameImage;
      
      private var _rightTower:ScaleFrameImage;
      
      private var _leftInfoTxt:FilterFrameText;
      
      private var _rightInfoTxt:FilterFrameText;
      
      private var _leftTowerTxt:FilterFrameText;
      
      private var _rightTowerTxt:FilterFrameText;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _battleMsg:HugeHeadNodeBattleFieldMsg;
      
      private var _selfMsg:HugeHeadNodeBattleUserMsg;
      
      private var _rolePoint:HugeHeadNodeBattleAreaMsg;
      
      private var _curNodeView:RouteNodeView;
      
      private var _curPoint:HugeHeadNodeBattleAreaMsg;
      
      private var _nextNode:RouteNodeView;
      
      private var _nextPoint:HugeHeadNodeBattleAreaMsg;
      
      private var _pathDic:Dictionary = new Dictionary();
      
      private var _lineArr:Array = [];
      
      private var _index:int = -1;
      
      private var _timer:Timer;
      
      private var _timerNum:int;
      
      private var _person:*;
      
      public const HUNTER_CLASS_PATH:String = "outyard.RouteHunterView";
      
      public var _cooleingNum:int = 0;
      
      public var _attackNum:int = 0;
      
      public function OutyardRouteView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:RouteNodeView = null;
         _battleMsg = OutyardManager.instance.model.battleNodeMsg;
         _selfMsg = OutyardManager.instance.model.battleSelfMsg;
         _rolePoint = OutyardManager.instance.model.myRoute;
         _nodeContain = new Component();
         _bg = ComponentFactory.Instance.creatCustomObject("asset.outyard.routeBg");
         _slotBg = ComponentFactory.Instance.creatBitmap("asset.outyard.routeSlotBg");
         _occupyLeft = ComponentFactory.Instance.creatComponentByStylename("outyard.routeForce");
         _occupyRight = ComponentFactory.Instance.creatComponentByStylename("outyard.routeForce");
         _occupyProgressBar1 = ComponentFactory.Instance.creatCustomObject("asset.outyard.occupyProgressBar" + _battleMsg.attackForce);
         _occupyProgressBar2 = ComponentFactory.Instance.creatCustomObject("asset.outyard.occupyProgressBar" + _battleMsg.defenceForce);
         _coolingStrip = ComponentFactory.Instance.creatCustomObject("outyard.ProgressCoolingBlueStrip");
         _coolingBlue = ComponentFactory.Instance.creatCustomObject("asset.outyard.ProgressCoolingBlue");
         _attackRed = ComponentFactory.Instance.creatCustomObject("asset.outyard.ProgressAttackRed");
         _leftTower = ComponentFactory.Instance.creatComponentByStylename("outyard.routeOccupyTower");
         _rightTower = ComponentFactory.Instance.creatComponentByStylename("outyard.routeOccupyTower");
         _coolingTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardRouteView.coolingTxt");
         _coolingNumTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardRouteView.coolingNumTxt");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardRouteView.attackTxt");
         _leftTowerTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.leftTowerTxt");
         _rightTowerTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.rightTowerTxt");
         _leftInfoTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.leftInfoTxt");
         _rightInfoTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.rightInfoTxt");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.RouteNodeView.leftTimeTxt");
         _borderLayer = new OutyardBorderLayer(_bg.width,_bg.height);
         var _loc1_:Class = DisplayLoader.Context.applicationDomain.getDefinition("outyard.RouteHunterView") as Class;
         _person = new _loc1_();
         _person.scaleX = _person.scaleY = 0.6;
         var _loc4_:AIBaseInfo = new AIBaseInfo();
         _loc4_.isLiving = true;
         _loc4_.speed = 8;
         _person.info = _loc4_;
         _person.standImp();
         _occupyLeft.setFrame(_battleMsg.attackForce);
         _occupyRight.setFrame(_battleMsg.defenceForce);
         _leftTower.setFrame(_battleMsg.attackForce);
         _rightTower.setFrame(_battleMsg.defenceForce);
         _leftTowerTxt.setFrame(_battleMsg.attackForce);
         _rightTowerTxt.setFrame(_battleMsg.defenceForce);
         _leftInfoTxt.setFrame(_battleMsg.attackForce);
         _rightInfoTxt.setFrame(_battleMsg.defenceForce);
         setPathDic();
         for each(var _loc3_:HugeHeadNodeBattleAreaMsg in _battleMsg.areaList)
         {
            setRowCol(_loc3_);
            _loc2_ = new RouteNodeView();
            _loc2_.x = getPosByPoint(_loc3_).x;
            _loc2_.y = getPosByPoint(_loc3_).y;
            _loc2_.info = _loc3_;
            _nodeContain.addChild(_loc2_);
            if(_rolePoint.pos == _loc3_.pos)
            {
               _curNodeView = _loc2_;
            }
         }
         walkEnd();
         OutyardManager.instance.model.curPos = _rolePoint.pos;
         addChild(_bg);
         addChild(_borderLayer);
         addChild(_nodeContain);
         addChild(_slotBg);
         addChild(_occupyLeft);
         _occupyLeft.x = 441;
         _occupyLeft.y = 0;
         addChild(_occupyRight);
         _occupyRight.x = 891;
         _occupyRight.y = -3;
         addChild(_occupyProgressBar1);
         _occupyProgressBar1.x = 520;
         _occupyProgressBar1.y = -3;
         addChild(_occupyProgressBar2);
         _occupyProgressBar2.x = 755;
         _occupyProgressBar2.y = -3;
         addChild(_coolingBlue);
         addChild(_coolingStrip);
         addChild(_attackRed);
         addChild(_coolingTxt);
         addChild(_coolingNumTxt);
         addChild(_attackTxt);
         addChild(_leftTower);
         _leftTower.x = 662;
         _leftTower.y = 37;
         addChild(_rightTower);
         _rightTower.x = 708;
         _rightTower.y = 37;
         addChild(_leftTowerTxt);
         addChild(_rightTowerTxt);
         addChild(_leftInfoTxt);
         addChild(_rightInfoTxt);
         addChild(_leftTimeTxt);
         _coolingTxt.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.coolingTxt");
         _attackTxt.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.attackTxt");
         _coolingStrip.tipData = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.coolingStrip");
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("ROUTE_BATTLE_FIELD",__battleFieldHandler);
         NotificationManager.instance.addEventListener("ROUTE_SELF_USER",__selfUserHandler);
         NotificationManager.instance.addEventListener("ROUTE_NEXT_CLICK",__nextClickHandler);
         NotificationManager.instance.addEventListener("ROUTE_NODE_ATTACK",__attackClickHandler);
         NotificationManager.instance.addEventListener("AREA_WALK_OVER",__walkOverHandler);
         _attackRed.addFrameScript(_attackRed.totalFrames - 1,end);
         __battleFieldHandler(null);
         __selfUserHandler(null);
         __timerHandler(null);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("ROUTE_BATTLE_FIELD",__battleFieldHandler);
         NotificationManager.instance.removeEventListener("ROUTE_SELF_USER",__selfUserHandler);
         NotificationManager.instance.removeEventListener("ROUTE_NEXT_CLICK",__nextClickHandler);
         NotificationManager.instance.removeEventListener("ROUTE_NODE_ATTACK",__attackClickHandler);
         NotificationManager.instance.removeEventListener("AREA_WALK_OVER",__walkOverHandler);
         _attackRed.addFrameScript(_attackRed.totalFrames - 1,null);
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer = null;
      }
      
      private function __timerHandler(param1:TimerEvent = null) : void
      {
         _timerNum = _timerNum + 1;
         if(_timerNum % 10 == 0)
         {
            OutyardManager.instance.OperateRoute(2);
         }
         _leftTimeTxt.text = leftTime;
         _cooleingNum = _cooleingNum - 1;
         _attackNum = _attackNum - 1;
         if(_cooleingNum <= 0)
         {
            _coolingNumTxt.visible = false;
         }
         else
         {
            _coolingNumTxt.text = "" + DateFormatter.getCountDateByMS(_cooleingNum);
         }
         if(_attackNum <= 0)
         {
            _attackRed.visible = false;
            _attackTxt.visible = false;
         }
      }
      
      private function end() : void
      {
         if(_attackRed)
         {
            _attackRed.stop();
         }
         _attackNum = 0;
      }
      
      private function __battleFieldHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:HugeHeadNodeBattleFieldMsg = OutyardManager.instance.model.battleNodeMsg;
         var _loc5_:int = int(_loc8_.attackScore);
         var _loc6_:int = int(ConfigInfoManager.instance.getHugeHeadBattleMaxScore());
         _loc2_ = _loc5_ / _loc6_ * 100;
         var _loc4_:int = int(_loc8_.defenceScore);
         var _loc7_:int = int(ConfigInfoManager.instance.getHugeHeadBattleMaxScore());
         _loc3_ = _loc4_ / _loc7_ * 100;
         _occupyProgressBar1.gotoAndStop(_loc2_);
         _occupyProgressBar2.gotoAndStop(_loc3_);
         _leftInfoTxt.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.leftInfoTxt",_loc8_.attackCount,_loc8_.attackScore);
         _rightInfoTxt.text = LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.leftInfoTxt",_loc8_.defenceCount,_loc8_.defenceScore);
         _leftTowerTxt.text = "x" + OutyardManager.instance.model.attackTower;
         _rightTowerTxt.text = "x" + OutyardManager.instance.model.defenceTower;
      }
      
      private function __selfUserHandler(param1:NotificationEvent) : void
      {
         var _loc2_:HugeHeadNodeBattleUserMsg = OutyardManager.instance.model.battleSelfMsg;
         if(!_loc2_ || !_curNodeView)
         {
            return;
         }
         _cooleingNum = Math.ceil(_loc2_.coolDown / 1000);
         _coolingNumTxt.text = "" + DateFormatter.getCountDateByMS(_cooleingNum);
         _coolingNumTxt.visible = _cooleingNum > 0;
         if(_curNodeView.info.pos != _loc2_.pos)
         {
            _curNodeView.clearState();
            _curPoint = _curNodeView.info;
            _nextNode = getNextNodeView(_loc2_.pos);
            _nextPoint = _nextNode.info;
            _index = 0;
            _lineArr = getlineArr(_curPoint,_nextPoint);
            _person.x = _lineArr[0][0];
            _person.y = _lineArr[0][1];
            addChild(_person);
            __walkOverHandler(null);
            _curNodeView = _nextNode;
         }
      }
      
      private function __nextClickHandler(param1:NotificationEvent) : void
      {
         var _loc2_:RouteNodeView = param1.data as RouteNodeView;
         var _loc3_:HugeHeadNodeBattleAreaMsg = _loc2_.info;
         if(_curNodeView.info.pos == _loc3_.pos)
         {
            return;
         }
         if(_curNodeView.info.lineArr.indexOf(_loc3_.pos) == -1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.neighborTxt"));
            return;
         }
         if(_loc3_.pos == 10 || _loc3_.pos == 11)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.birthTxt"));
            return;
         }
         if(_battleMsg.nodeState == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.prepareTxt"));
            return;
         }
         if(!checkCooling())
         {
            return;
         }
         OutyardManager.instance.OperateRoute(4,_loc3_.pos);
      }
      
      private function __walkOverHandler(param1:NotificationEvent = null) : void
      {
         if(_index >= _lineArr.length - 1)
         {
            walkEnd();
            return;
         }
         setPos();
      }
      
      public function setPos() : void
      {
         var _loc1_:Point = new Point(_lineArr[_index][0],_lineArr[_index][1]);
         var _loc2_:Point = new Point(_lineArr[_index + 1][0],_lineArr[_index + 1][1]);
         _person.info.pathInfo = [_loc1_,_loc2_];
         _index = _index + 1;
      }
      
      private function walkEnd() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         if(_curNodeView.info.pos == 10)
         {
            _person.x = 110;
            _person.y = -15;
         }
         else
         {
            _person.x = -45;
            _person.y = 0;
         }
         _person.standImp();
         _person.updateAngle(150);
         _curNodeView.personCon.addChild(_person);
         var _loc3_:HugeHeadNodeBattleAreaMsg = _curNodeView.info;
         var _loc2_:int = int(_loc3_.pos);
         _loc1_ = 1;
         while(_loc1_ <= 11)
         {
            _loc4_ = 1;
            while(_loc4_ <= 11)
            {
               if(_bg["s_" + _loc1_ + "_" + _loc4_])
               {
                  _bg["s_" + _loc1_ + "_" + _loc4_].alpha = 0;
               }
               _loc4_++;
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 11)
         {
            if(_loc3_.lineArr.indexOf(_loc1_) != -1)
            {
               if(!(_loc2_ != 10 && _loc2_ != 11 && (_loc1_ == 10 || _loc1_ == 11)))
               {
                  if(_bg["s_" + _loc1_ + "_" + _loc2_])
                  {
                     _bg["s_" + _loc1_ + "_" + _loc2_].alpha = 1;
                  }
                  if(_bg["s_" + _loc2_ + "_" + _loc1_])
                  {
                     _bg["s_" + _loc2_ + "_" + _loc1_].alpha = 1;
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function __attackClickHandler(param1:NotificationEvent) : void
      {
         if(!checkAttack())
         {
            return;
         }
         _attackNum = 10;
         _attackTxt.visible = true;
         _attackRed.visible = true;
         _attackRed.gotoAndPlay(1);
         OutyardManager.instance.OperateRoute(5);
      }
      
      private function checkCooling() : Boolean
      {
         if(_cooleingNum > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.transferTxt"));
            return false;
         }
         if(_attackNum > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.attackCoolTxt"));
            return false;
         }
         return true;
      }
      
      private function checkAttack() : Boolean
      {
         if(_attackNum > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.scene.RouteNodeView.attackCoolTxt"));
            return false;
         }
         return true;
      }
      
      public function get leftTime() : String
      {
         var _loc4_:int = 0;
         var _loc2_:Number = Number(Int64Utils.int64ToNumber(_battleMsg.battleStartTime));
         var _loc1_:Number = Number(Int64Utils.int64ToNumber(_battleMsg.battleEndTime));
         if(_battleMsg.nodeState == 2)
         {
            _loc4_ = _loc2_ / 1000 - playerModel.sysSecond;
         }
         else if(_battleMsg.nodeState == 3)
         {
            _loc4_ = _loc1_ / 1000 - playerModel.sysSecond;
         }
         return DateFormatter.getCountDateByMS(_loc4_);
      }
      
      private function getNextNodeView(param1:int) : RouteNodeView
      {
         var _loc2_:RouteNodeView = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _nodeContain.numChildren)
         {
            _loc2_ = _nodeContain.getChildAt(_loc3_) as RouteNodeView;
            if(_loc2_.info.pos == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function getPosByPoint(param1:HugeHeadNodeBattleAreaMsg) : Point
      {
         return new Point(param1.posArr[0],param1.posArr[1]);
      }
      
      private function getlineArr(param1:HugeHeadNodeBattleAreaMsg, param2:HugeHeadNodeBattleAreaMsg) : Array
      {
         var _loc3_:Array = null;
         if(_pathDic[param1.pos + "_" + param2.pos])
         {
            return _pathDic[param1.pos + "_" + param2.pos];
         }
         if(_pathDic[param2.pos + "_" + param1.pos])
         {
            _loc3_ = _pathDic[param2.pos + "_" + param1.pos];
            _loc3_ = _loc3_.slice(0,_loc3_.length);
            return _loc3_.reverse();
         }
         return [];
      }
      
      private function setPathDic() : void
      {
         _pathDic["1_10"] = [[264,451],[268,523],[397,621]];
         _pathDic["1_2"] = [[306,382],[382,285]];
         _pathDic["1_4"] = [[332,424],[428,484],[538,566]];
         _pathDic["2_3"] = [[471,247],[598,248],[646,206]];
         _pathDic["2_5"] = [[442,285],[551,328],[629,416]];
         _pathDic["3_6"] = [[749,233],[857,294]];
         _pathDic["3_11"] = [[749,199],[876,156],[1088,266]];
         _pathDic["4_10"] = [[531,608],[412,631]];
         _pathDic["4_7"] = [[594,606],[684,666],[801,667]];
         _pathDic["4_5"] = [[621,566],[681,438]];
         _pathDic["5_6"] = [[744,413],[869,317]];
         _pathDic["5_8"] = [[770,446],[962,542]];
         _pathDic["6_11"] = [[932,299],[985,255],[1081,273]];
         _pathDic["6_9"] = [[967,310],[1159,463]];
         _pathDic["7_10"] = [[821,696],[636,738],[490,717],[394,672]];
         _pathDic["7_8"] = [[891,635],[984,572]];
         _pathDic["8_9"] = [[1063,546],[1137,541],[1199,478]];
         _pathDic["9_11"] = [[1245,440],[1221,357],[1174,278]];
      }
      
      public function setRowCol(param1:HugeHeadNodeBattleAreaMsg) : void
      {
         switch(int(param1.pos) - 1)
         {
            case 0:
               param1.posArr = [286,403];
               param1.lineArr = [10,2,4];
               break;
            case 1:
               param1.posArr = [419,253];
               param1.lineArr = [1,3,5];
               break;
            case 2:
               param1.posArr = [706,187];
               param1.lineArr = [2,6,11];
               break;
            case 3:
               param1.posArr = [569,577];
               param1.lineArr = [10,1,7,5];
               break;
            case 4:
               param1.posArr = [714,420];
               param1.lineArr = [2,4,6,8];
               break;
            case 5:
               param1.posArr = [908,295];
               param1.lineArr = [11,3,9,5];
               break;
            case 6:
               param1.posArr = [844,651];
               param1.lineArr = [10,4,8];
               break;
            case 7:
               param1.posArr = [1024,549];
               param1.lineArr = [5,7,9];
               break;
            case 8:
               param1.posArr = [1214,449];
               param1.lineArr = [11,6,8];
               break;
            case 9:
               param1.posArr = [297,643];
               param1.lineArr = [1,4,7];
               break;
            case 10:
               param1.posArr = [1179,214];
               param1.lineArr = [3,6,9];
         }
      }
      
      public function enterFrame() : void
      {
         if(_person && _person.info)
         {
            _person.execute();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_person);
         _person = null;
         ObjectUtils.disposeObject(_nodeContain);
         _nodeContain = null;
         ObjectUtils.disposeViolentMc(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_borderLayer);
         _borderLayer = null;
         ObjectUtils.disposeObject(_slotBg);
         _slotBg = null;
         ObjectUtils.disposeObject(_occupyLeft);
         _occupyLeft = null;
         ObjectUtils.disposeObject(_occupyRight);
         _occupyRight = null;
         ObjectUtils.disposeViolentMc(_occupyProgressBar1);
         _occupyProgressBar1 = null;
         ObjectUtils.disposeViolentMc(_occupyProgressBar2);
         _occupyProgressBar2 = null;
         ObjectUtils.disposeViolentMc(_coolingBlue);
         _coolingBlue = null;
         ObjectUtils.disposeViolentMc(_attackRed);
         _attackRed = null;
         ObjectUtils.disposeObject(_coolingStrip);
         _coolingStrip = null;
         ObjectUtils.disposeObject(_leftTower);
         _leftTower = null;
         ObjectUtils.disposeObject(_rightTower);
         _rightTower = null;
         ObjectUtils.disposeObject(_leftInfoTxt);
         _leftInfoTxt = null;
         ObjectUtils.disposeObject(_rightInfoTxt);
         _rightInfoTxt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_curNodeView);
         _curNodeView = null;
         _battleMsg = null;
         _selfMsg = null;
         _rolePoint = null;
         super.dispose();
      }
   }
}

