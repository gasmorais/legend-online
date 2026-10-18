package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretEventInfo;
   import mvc.module.secret.SecretMapInfo;
   import secretadventure.util.SecretHexagonTool;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SecretEventTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretHexagon extends Sprite
   {
      
      private var _father:SecretHexagon = null;
      
      private var _neighbors:Array = [];
      
      private var _gValue:int = 999;
      
      private var _hValue:int = 999;
      
      private var _hexagonId:int = 0;
      
      private var _node:SecretNode;
      
      private var _tmask:MovieClip;
      
      private var _mapType:int;
      
      private var _mapDataId:int;
      
      private var _eventTemp:SecretEventTemplate;
      
      private var _eventInfo:SecretEventInfo;
      
      private var _firstPass:Boolean;
      
      private var _river:SecretRiverNode;
      
      private var _bgBit:Bitmap;
      
      private var _newArrow:SecretNewArrowItem;
      
      private var _countTime:Number = 0;
      
      private var _noRollList:Array = [3,8,9,10,11,12,13,14];
      
      public function SecretHexagon(param1:int, param2:int)
      {
         super();
         _mapType = param1;
         _mapDataId = param2;
         this.mouseChildren = false;
         initView();
      }
      
      private function initView() : void
      {
         _bgBit = new Bitmap();
         addChild(_bgBit);
         _node = new SecretNode(_mapType);
         addChild(_node);
      }
      
      public function updateRiver() : void
      {
         if(model.frameInfo.isDie)
         {
            if(!_river)
            {
               _river = new SecretRiverNode();
            }
            addChild(_river);
         }
         else
         {
            ObjectUtils.disposeObject(_river);
            _river = null;
         }
      }
      
      public function setThitArea(param1:Sprite) : void
      {
         var _loc2_:Sprite = new Sprite();
         param1.addChild(_loc2_);
         _loc2_.visible = false;
         _loc2_.mouseEnabled = false;
         _tmask = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.maskMc");
         _tmask.x += this.x;
         _tmask.y += this.y;
         _loc2_.addChild(_tmask);
         this.hitArea = _loc2_;
         doCopyBit(_tmask.x + 6,_tmask.y + 6);
      }
      
      private function doCopyBit(param1:int, param2:int) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:BitmapData = SecretComBitData.Instance.getBitMap(_mapType);
         var _loc10_:Bitmap = SecretComBitData.Instance.copyBit;
         var _loc12_:BitmapData = _loc10_.bitmapData;
         var _loc14_:Rectangle = new Rectangle(param1,param2,_loc10_.width,_loc10_.height);
         var _loc3_:Point = new Point(0,0);
         var _loc11_:int = _loc10_.width - 2;
         var _loc5_:int = _loc10_.height - 2;
         var _loc6_:BitmapData = new BitmapData(_loc11_,_loc5_);
         var _loc4_:BitmapData = new BitmapData(_loc11_,_loc5_);
         _loc6_.copyPixels(_loc13_,_loc14_,_loc3_);
         _bgBit.x = -_loc11_ / 2;
         _bgBit.y = -_loc5_ / 2;
         _loc8_ = 0;
         while(_loc8_ < _loc11_)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc5_)
            {
               _loc7_ = int(_loc12_.getPixel32(_loc8_,_loc9_));
               if(_loc7_ != 0)
               {
                  _loc7_ = int(_loc6_.getPixel32(_loc8_,_loc9_));
                  _loc4_.setPixel32(_loc8_,_loc9_,_loc7_);
               }
               else
               {
                  _loc4_.setPixel32(_loc8_,_loc9_,0);
               }
               _loc9_++;
            }
            _loc8_++;
         }
         _bgBit.bitmapData = _loc4_;
      }
      
      public function nodeEventId(param1:int) : void
      {
         var _loc2_:Array = null;
         if(_eventTemp == null)
         {
            _eventTemp = TempleteManager.instance.secretEventCate.getEventTempInfo(param1);
            updateNodeState();
            _node.eventTemp = _eventTemp;
            _loc2_ = [7,16];
            if(_loc2_.indexOf(_eventTemp.FunType) == -1)
            {
               initEvent();
            }
            else
            {
               this.mouseEnabled = this.mouseChildren = false;
            }
            if(_eventTemp.FunType == 10)
            {
               if(_newArrow == null && Boolean(model.frameInfo.isFirst))
               {
                  _newArrow = ComponentFactory.Instance.creatCustomObject("ui.secret.newArrowItem");
                  addChild(_newArrow);
               }
            }
         }
         else
         {
            updateNodeState();
         }
      }
      
      private function updateNodeState() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SecretMapInfo = null;
         if(_eventInfo && _eventTemp)
         {
            if(_eventTemp.FunType == 9 || _eventTemp.FunType == 8)
            {
               _loc2_ = int(_eventInfo.params);
               _node.state = _loc2_;
            }
            else if(_eventTemp.FunType == 10)
            {
               if(_eventInfo.state == 1)
               {
                  _loc1_ = model.secenInfo.getMapInfo(_mapDataId);
                  if(_loc1_)
                  {
                     _loc1_.hasGetTask = true;
                  }
                  NotificationManager.instance.sendNotification("SecretAdEvent.getTask",_mapDataId);
               }
            }
            else
            {
               _node.state = _eventInfo.state;
            }
         }
      }
      
      public function set eventInfo(param1:SecretEventInfo) : void
      {
         _eventInfo = param1;
         if(_eventInfo)
         {
            nodeEventId(_eventInfo.eventId);
         }
      }
      
      public function getNeighborList() : Array
      {
         return this._neighbors;
      }
      
      public function setFatherHexagon(param1:SecretHexagon) : void
      {
         this._father = param1;
      }
      
      public function getFatherHexagon() : SecretHexagon
      {
         return this._father;
      }
      
      public function canPass() : Boolean
      {
         if(model.frameInfo.isDie)
         {
            return false;
         }
         if(_firstPass)
         {
            return _firstPass;
         }
         return _node.canPass;
      }
      
      public function computeGValue(param1:SecretHexagon) : int
      {
         return 1;
      }
      
      public function setgValue(param1:int) : void
      {
         this._gValue = param1;
      }
      
      public function getgValue() : int
      {
         return this._gValue;
      }
      
      public function sethValue(param1:int) : void
      {
         this._hValue = param1;
      }
      
      public function gethValue() : int
      {
         return this._hValue;
      }
      
      public function computeHValue(param1:SecretHexagon) : int
      {
         var _loc2_:Point = new Point(this._node.x,this._node.y);
         var _loc3_:Point = new Point(param1._node.x,param1._node.y);
         return int(Point.distance(_loc2_,_loc3_));
      }
      
      public function setId(param1:int) : void
      {
         this._hexagonId = param1;
      }
      
      public function getId() : int
      {
         return this._hexagonId;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseDown",mouseDownHandler);
         this.addEventListener("mouseUp",mouseUpHandler);
         this.addEventListener("rollOut",rollOutHandler);
         this.addEventListener("rollOver",rollOverHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseDown",mouseDownHandler);
         this.removeEventListener("mouseUp",mouseUpHandler);
         this.removeEventListener("rollOut",rollOutHandler);
         this.removeEventListener("rollOver",rollOverHandler);
      }
      
      private function rollOutHandler(param1:MouseEvent) : void
      {
         if(_eventTemp)
         {
            _node.doRollOut();
         }
      }
      
      private function rollOverHandler(param1:MouseEvent) : void
      {
         if(_eventTemp && _noRollList.indexOf(_eventTemp.FunType) == -1)
         {
            if(_eventTemp.FunType == 1 || _eventInfo && _eventInfo.state == 1)
            {
               _node.doRollOver();
            }
         }
      }
      
      private function mouseDownHandler(param1:MouseEvent) : void
      {
         _countTime = getTimer();
      }
      
      private function mouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer() - _countTime;
         if(_loc2_ < 200)
         {
            clickHandler();
         }
      }
      
      private function clickHandler(param1:MouseEvent = null) : void
      {
         var _loc11_:String = null;
         var _loc5_:int = 0;
         var _loc4_:Date = null;
         var _loc10_:PlayerModel = null;
         var _loc6_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:int = 0;
         trace("CLIKC==>",this._hexagonId);
         if(!_eventTemp)
         {
            return;
         }
         ObjectUtils.disposeObject(_newArrow);
         _newArrow = null;
         if(model.secenInfo.currMapDataId != _mapDataId)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         if(model.pinfo.lastStandNodeId == this._hexagonId)
         {
            if(model.frameInfo.isDie)
            {
               _loc5_ = int(TempleteManager.instance.getConfigValue("secretexplore_revive_cost_diamonds"));
               _loc10_ = PlayerManager.instance.currentPlayerModel;
               if(_loc10_.castle_offset == -1)
               {
                  _loc4_ = _loc10_.sysCurtime;
               }
               else
               {
                  _loc4_ = DateFormatter.getTimezoneOffsetDate(_loc10_.castle_offset);
               }
               _loc6_ = _loc4_.time;
               _loc8_ = Number(DateFormatter.parse(model.frameInfo.remainTime,"YYYY-MM-DD hh:mm:ss").time);
               _loc7_ = Math.ceil((_loc8_ - _loc6_) * 0.001 / 3600);
               if(_loc7_ < 0)
               {
                  _loc7_ = 0;
               }
               _loc11_ = LanguageMgr.GetTranslation("secret.reiver.tip",_loc5_ * _loc7_);
               SimpleAlertHelper.instance.data = [doRiver,_loc5_];
               SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc11_,_loc2_,_loc3_,false,true);
            }
            return;
         }
         if(model.pinfo.armyData.isMoving)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardAreaDiceView.isMove"));
            return;
         }
         model.pinfo.walkCallBack = null;
         if(checkIsNear())
         {
            doDealEvent();
         }
         else
         {
            doFindPath();
         }
      }
      
      private function doRiver(param1:Boolean, param2:Boolean = false, param3:int = 10) : void
      {
         if(param1)
         {
            if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            SecretAdventerManager.Instance.opCommon(4);
         }
      }
      
      private function doFindPath() : void
      {
         var _loc5_:Boolean = false;
         var _loc11_:Array = null;
         var _loc2_:SecretHexagon = null;
         var _loc4_:Array = null;
         var _loc3_:Point = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:Array = null;
         if(!this.canPass())
         {
            _firstPass = true;
            _loc5_ = true;
         }
         var _loc10_:SecretHexagon = model.getNode(_mapDataId,model.pinfo.lastStandNodeId) as SecretHexagon;
         if(this.canPass())
         {
            _loc11_ = SecretHexagonTool.searchPath(_loc10_,this);
            _loc4_ = [];
            _loc6_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc11_.length)
            {
               _loc2_ = _loc11_[_loc7_];
               _loc3_ = new Point();
               _loc3_.x = _loc2_.x / 20;
               _loc3_.y = _loc2_.y / 20;
               _loc4_.push(_loc3_);
               _loc6_.push(_loc2_.getId());
               _loc7_++;
            }
            trace("寻路ids=>",_loc6_);
            if(_loc4_.length > 0)
            {
               if(_loc5_)
               {
                  _loc4_.pop();
                  _loc6_.pop();
                  _loc8_ = _loc6_.length - 1;
                  if(_loc8_ >= 0)
                  {
                     _loc9_ = int(_loc6_[_loc8_]);
                     model.pinfo.standNodeId = _loc9_;
                     model.pinfo.walkCallBack = doDealEvent;
                  }
               }
               else
               {
                  _loc1_ = [13,14];
                  if(_loc1_.indexOf(_eventTemp.FunType) != -1)
                  {
                     model.pinfo.walkCallBack = doSpecialEvent;
                  }
                  _node.showWalkClick();
                  model.pinfo.standNodeId = this._hexagonId;
               }
               model.dispatchEvent(new NotificationEvent("SecretAdEvent.moveTo",_loc4_));
            }
            else
            {
               doShowEventDes();
            }
         }
         else
         {
            doShowEventDes();
         }
         _firstPass = false;
      }
      
      private function doShowEventDes() : void
      {
         var _loc1_:Array = [7,9,12,13,16];
         if(_loc1_.indexOf(_eventTemp.FunType) == -1)
         {
            if(model.frameInfo.isDie)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.need.river"));
            }
            else if(_eventTemp.FunType == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.noPath"));
            }
            else if(!_node.canPass)
            {
               FrameControllerManager.instance.openControllerByInfo("secretadventure",1,[_eventInfo,false,_mapDataId]);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.noPath"));
            }
         }
      }
      
      private function doDealEvent() : void
      {
         var _loc5_:String = null;
         if(model.frameInfo.isDie)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secret.need.river"));
            return;
         }
         if(this.canPass())
         {
            doFindPath();
            return;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:int = int(_eventTemp.FunType);
         switch(_loc3_ - 2)
         {
            case 0:
            case 9:
               FrameControllerManager.instance.openControllerByInfo("secretadventure",3,_eventInfo);
               break;
            case 1:
               FrameControllerManager.instance.openControllerByInfo("secretadventure",2,_eventInfo);
               break;
            case 3:
               _loc5_ = LanguageMgr.GetTranslation("secret.organ");
               SimpleAlertHelper.instance.data = [confromBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,false,true);
               break;
            case 8:
            case 12:
            case 13:
               FrameControllerManager.instance.openControllerByInfo("secretadventure",1,[_eventInfo,true,_mapDataId]);
               break;
            case 11:
               if(_eventInfo.state == 0)
               {
                  _loc5_ = LanguageMgr.GetTranslation("secret.exit");
                  SimpleAlertHelper.instance.data = [exitSecretGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,true);
               }
               break;
            case 15:
               _loc5_ = LanguageMgr.GetTranslation("secret.xiaoguai.battle");
               SimpleAlertHelper.instance.data = [confromBack];
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,false,true);
               break;
            default:
               requestServer();
         }
      }
      
      private function doSpecialEvent() : void
      {
         var _loc5_:String = null;
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:int = int(_eventTemp.FunType);
         switch(_loc3_ - 13)
         {
            case 0:
               if(_eventInfo.state == 0)
               {
                  _loc5_ = LanguageMgr.GetTranslation("secret.exit");
                  SimpleAlertHelper.instance.data = [exitSecretGame];
                  SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,true);
               }
               break;
            case 1:
               FrameControllerManager.instance.openControllerByInfo("secretadventure",1,[_eventInfo,true,_mapDataId]);
         }
      }
      
      private function exitSecretGame(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Object = null;
         if(param1)
         {
            requestServer();
            _loc3_ = {};
            _loc3_.isShowLoading = true;
            _loc3_.isSecretAdventure = true;
            SwitchPageHelp.returnToSpace(_loc3_);
         }
      }
      
      private function requestServer() : void
      {
         if(model.isTest)
         {
            if(_eventInfo)
            {
               _eventInfo.state = 1;
               eventInfo = _eventInfo;
            }
         }
         else
         {
            SecretAdventerManager.Instance.opEvent(_mapDataId,_hexagonId);
         }
      }
      
      private function confromBack(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            requestServer();
         }
      }
      
      private function checkIsNear() : Boolean
      {
         var _loc2_:int = int(model.pinfo.lastStandNodeId);
         for each(var _loc1_:SecretHexagon in _neighbors)
         {
            if(_loc1_.getId() == _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hideWalkFlg() : void
      {
         var _loc1_:int = 0;
         if(_eventTemp && _eventInfo)
         {
            _loc1_ = int(_eventTemp.FunType);
            if((_loc1_ == 13 || _loc1_ == 14) && _eventInfo.state == 1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("secreat.advance.pass"));
            }
         }
         _node.dispearWalkClick();
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function clearToGray() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tmask);
         _tmask = null;
         ObjectUtils.disposeObject(_river);
         _river = null;
         ObjectUtils.disposeObject(_newArrow);
         _newArrow = null;
         _node.clearToGray();
         _eventTemp = null;
         _eventInfo = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tmask);
         _tmask = null;
         ObjectUtils.disposeObject(_river);
         _river = null;
         ObjectUtils.disposeObject(_node);
         _node = null;
         ObjectUtils.disposeObject(_newArrow);
         _newArrow = null;
         ObjectUtils.disposeObject(_bgBit);
         _bgBit = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _eventTemp = null;
         _eventInfo = null;
         _father = null;
         _neighbors = null;
         _noRollList = null;
      }
   }
}

