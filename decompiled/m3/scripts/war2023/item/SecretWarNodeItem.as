package war2023.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.util.SecretwarBitDataUtil;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SecretWarManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SecretWarNodeItem extends Sprite
   {
      
      private var _houseSp:Sprite;
      
      private var _house:Bitmap;
      
      private var _qzFlg:Bitmap;
      
      private var _progressFlg:Bitmap;
      
      private var _proMask:Shape;
      
      private var _posBg:Bitmap;
      
      private var _stateFlg:Bitmap;
      
      private var _stateTxt:FilterFrameText;
      
      private var _cd:FilterFrameText;
      
      private var _opBtnBox:VBox;
      
      private var _data:SecretWarNodeInfo;
      
      private var _state:int = -1;
      
      private var _type:int = -1;
      
      private var _posState:int = -1;
      
      private var _isMenu:Boolean = false;
      
      private var _npNums:Bitmap;
      
      private var _blueTxt:FilterFrameText;
      
      private var _redTxt:FilterFrameText;
      
      private var _menuSp:Sprite;
      
      private var _scorebar:Bitmap;
      
      private var _scoreSpeed:int;
      
      private var _scorebarMax:int;
      
      private var _moveBtn:IconButton;
      
      private var _occBtn:IconButton;
      
      private var _defBtn:IconButton;
      
      private var _infosBtn:IconButton;
      
      private var _isNodeEvent:Boolean = true;
      
      private var _mc:MovieClip;
      
      public function SecretWarNodeItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _scoreSpeed = int(model.nodeScoreParms[2]);
         _houseSp = new Sprite();
         _menuSp = new Sprite();
         _house = new Bitmap();
         _qzFlg = new Bitmap();
         _progressFlg = new Bitmap();
         _posBg = new Bitmap();
         _stateFlg = new Bitmap();
         _npNums = ComponentFactory.Instance.creatBitmap("asset.secretwar.npNums");
         _opBtnBox = ComponentFactory.Instance.creatCustomObject("ui.secretwar.faceBtnBox");
         _cd = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeCdTxt");
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeNewStateTxt");
         _blueTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeBuleNumTxt");
         _redTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeRedNumTxt");
         _scorebar = ComponentFactory.Instance.creatBitmap("asset.secretwar.scorebar");
         _moveBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.faceBtnMove");
         _occBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.faceBtnOcc");
         _defBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.faceBtnDef");
         _infosBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.faceBtninfos");
         _mc = ComponentFactory.Instance.creatCustomObject("asset.secretwar.scoreFlyTxt");
         _mc.stop();
         _proMask = new Shape();
         _proMask.graphics.beginFill(16711680);
         _proMask.graphics.drawRect(0,0,78,20);
         _proMask.graphics.endFill();
         addChild(_houseSp);
         addChild(_menuSp);
         _houseSp.addChild(_house);
         addChild(_stateFlg);
         addChild(_qzFlg);
         addChild(_progressFlg);
         addChild(_proMask);
         addChild(_posBg);
         addChild(_stateTxt);
         addChild(_cd);
         addChild(_opBtnBox);
         addChild(_scorebar);
         _menuSp.addChild(_npNums);
         _menuSp.addChild(_blueTxt);
         _menuSp.addChild(_redTxt);
         _qzFlg.x = -56;
         _qzFlg.y = 46;
         _progressFlg.x = -8;
         _progressFlg.y = 60;
         _proMask.x = -16;
         _proMask.y = 59;
         _posBg.x = -12;
         _posBg.y = -98;
         _stateFlg.y = 10;
         _progressFlg.mask = _proMask;
         _scorebarMax = _scorebar.width;
      }
      
      public function set isMenu(param1:Boolean) : void
      {
         _isMenu = param1;
      }
      
      public function get data() : SecretWarNodeInfo
      {
         return _data;
      }
      
      public function set data(param1:SecretWarNodeInfo) : void
      {
         _data = param1;
         if(_data)
         {
            type = _data.type;
            this.x = _data.x;
            this.y = _data.y;
            if(_isNodeEvent)
            {
               _isNodeEvent = false;
               _data.addEventListener("secretwarPlayScoreEvent",playScoreMcHandler);
            }
         }
      }
      
      private function playScoreMcHandler(param1:Event) : void
      {
         var _loc2_:int = int(_data.camp);
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         _mc.txtMc.gotoAndStop(_loc2_);
         _mc.txtMc.txt.text = "+" + model.nodeScoreParms[0];
         _mc.gotoAndPlay(1);
         addChild(_mc);
      }
      
      public function set type(param1:int) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
         _house.bitmapData = SecretwarBitDataUtil.getHouse(_type);
         _house.x = -_house.width * 0.5;
         _house.y = -_house.height * 0.5;
      }
      
      private function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         if(_data)
         {
            _data.state = _state;
         }
         switch(_state)
         {
            case 0:
               _stateFlg.bitmapData = SecretwarBitDataUtil.getPeaceFlg(_data.camp);
               _stateFlg.x = -57;
               _stateTxt.text = LanguageMgr.GetTranslation("secretwar.stateNo");
               break;
            case 4:
            case 6:
               _stateFlg.bitmapData = SecretwarBitDataUtil.fightFlg;
               _stateFlg.x = -56;
               _stateTxt.text = LanguageMgr.GetTranslation("secretwar.stateFight");
               break;
            case 5:
               _stateFlg.bitmapData = SecretwarBitDataUtil.getDefFlg(_data.camp);
               _stateFlg.x = -47;
               _stateTxt.text = LanguageMgr.GetTranslation("secretwar.stateNo");
               break;
            default:
               _stateTxt.x = -21;
               _stateTxt.y = 16;
               _stateTxt.text = LanguageMgr.GetTranslation("secretwar.noFight");
         }
      }
      
      private function set posState(param1:int) : void
      {
         if(_posState == param1)
         {
            return;
         }
         _posState = param1;
         switch(_posState)
         {
            case 0:
               _posBg.bitmapData = null;
               break;
            case 3:
               _posBg.bitmapData = SecretwarBitDataUtil.getPosFlg(model.selfPlay.camp);
         }
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Array = null;
         var _loc8_:SecretWarNodeInfo = null;
         var _loc5_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:Number = NaN;
         var _loc4_:* = null;
         var _loc6_:SecretwarPlayInfo = null;
         var _loc1_:Array = null;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc7_:int = 0;
         if(_data == null)
         {
            return;
         }
         type = _data.type;
         if(model.selfPlay.curNodeId == _data.nodeId)
         {
            if(model.selfPlay.state == 3)
            {
               this.posState = 0;
            }
            else
            {
               this.posState = 3;
            }
         }
         else
         {
            this.posState = 0;
         }
         if(_data.camp == model.selfPlay.camp)
         {
            _data.isCan = true;
         }
         else
         {
            _data.isCan = false;
            _loc2_ = _data.connects;
            for each(var _loc3_:String in _loc2_)
            {
               _loc8_ = model.nodeInfos[_loc3_];
               if(_loc8_.camp == model.selfPlay.camp)
               {
                  _data.isCan = true;
                  break;
               }
            }
         }
         switch(int(_data.type))
         {
            case 0:
            case 1:
            case 2:
               if(_data.type != 0)
               {
                  _loc10_ = _data.cdTime / _scoreSpeed;
                  if(_loc10_ > 1)
                  {
                     _loc10_ = 1;
                  }
                  _scorebar.width = _scorebarMax * (1 - _loc10_);
               }
               else
               {
                  _scorebar.width = 0;
               }
               _loc1_ = _data.allPlayerList;
               if(_loc1_.length > 0)
               {
                  _loc1_.sort(sortFun);
                  _loc6_ = _loc1_[0];
                  if(_loc6_.state == 6)
                  {
                     _cd.text = DateFormatter.getCountDate(_loc6_.cdTime,2,2);
                     _progressFlg.bitmapData = SecretwarBitDataUtil.getProBar(_loc6_.camp);
                     _proMask.width = (model.occTime - _loc6_.cdTime) / model.occTime * _progressFlg.width;
                     _qzFlg.bitmapData = SecretwarBitDataUtil.getQz(_loc6_.camp);
                     _data.isFigting = true;
                     this.state = 6;
                  }
                  else
                  {
                     _qzFlg.bitmapData = null;
                     _cd.text = "";
                     _proMask.width = 0;
                     _loc11_ = false;
                     _loc12_ = false;
                     _loc7_ = 0;
                     while(_loc7_ < _loc1_.length)
                     {
                        _loc6_ = _loc1_[_loc7_];
                        if(_loc6_)
                        {
                           if(_loc6_.state == 4)
                           {
                              _loc11_ = true;
                           }
                           else if(_loc6_.state == 5)
                           {
                              _loc12_ = true;
                           }
                        }
                        _loc7_++;
                     }
                     _data.isFigting = _loc11_;
                     _data.isDefand = _loc12_;
                     if(_loc11_)
                     {
                        this.state = 4;
                     }
                     else if(_loc12_)
                     {
                        this.state = 5;
                     }
                     else
                     {
                        this.state = 0;
                     }
                  }
               }
               else
               {
                  _qzFlg.bitmapData = null;
                  _cd.text = "";
                  _proMask.width = 0;
                  _data.isFigting = false;
                  this.state = 0;
               }
               _loc5_ = _data.bluePlayerList;
               _loc9_ = _data.redPlayerList;
               _loc5_.sort(sortFun);
               _loc9_.sort(sortFun);
               break;
            case 3:
               _posBg.x = -12;
               _posBg.y = -155;
               _house.y = -135;
               _scorebar.visible = false;
               _opBtnBox.x = 53;
               state = 9999;
               break;
            case 4:
               _posBg.x = -12;
               _posBg.y = -155;
               _house.y = -135;
               _scorebar.visible = false;
               _opBtnBox.x = 53;
               state = 9999;
         }
         refreshMenu();
      }
      
      private function getListSortFlg(param1:Array) : String
      {
         var _loc5_:SecretwarPlayInfo = null;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc2_ += _loc5_.state + "_";
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function sortFun(param1:SecretwarPlayInfo, param2:SecretwarPlayInfo) : int
      {
         if(param1.state > param2.state)
         {
            return -1;
         }
         if(param1.state == param2.state)
         {
            if(param1.cdTime > param2.cdTime)
            {
               return 1;
            }
            if(param1.cdTime == param2.cdTime)
            {
               if(param1.userId > param2.userId)
               {
                  return 1;
               }
               if(param1.userId == param2.userId)
               {
                  return 0;
               }
               return -1;
            }
            return -1;
         }
         return 1;
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         _houseSp.buttonMode = true;
         _houseSp.addEventListener("click",clickHandler);
         _moveBtn.addEventListener("click",moveHandler);
         _occBtn.addEventListener("click",occHandler);
         _defBtn.addEventListener("click",defHandler);
         _infosBtn.addEventListener("click",infosHandler);
      }
      
      private function removeEvent() : void
      {
         _houseSp.removeEventListener("click",clickHandler);
         if(_moveBtn)
         {
            _moveBtn.removeEventListener("click",moveHandler);
         }
         if(_occBtn)
         {
            _occBtn.removeEventListener("click",occHandler);
         }
         if(_defBtn)
         {
            _defBtn.removeEventListener("click",defHandler);
         }
         if(_infosBtn)
         {
            _infosBtn.removeEventListener("click",infosHandler);
         }
         if(_data)
         {
            _data.removeEventListener("secretwarPlayScoreEvent",playScoreMcHandler);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!_data)
         {
            return;
         }
         if(SecretwarBitDataUtil.currNodeItem != null && SecretwarBitDataUtil.currNodeItem != this)
         {
            SecretwarBitDataUtil.currNodeItem.isMenu = false;
         }
         SecretwarBitDataUtil.currNodeItem = this;
         _isMenu = !_isMenu;
      }
      
      private function refreshMenu() : void
      {
         var _loc4_:IconButton = null;
         if(!_isMenu)
         {
            _opBtnBox.removeAllChild();
            _menuSp.visible = false;
            return;
         }
         var _loc3_:Boolean = _data.connects.indexOf("" + model.selfPlay.curNodeId) != -1;
         var _loc1_:SecretWarNodeInfo = model.nodeInfos[model.selfPlay.curNodeId];
         var _loc2_:Boolean = model.selfPlay.state == 3;
         if(_data.type == 3 || _data.type == 4)
         {
            _menuSp.visible = false;
         }
         else
         {
            _menuSp.visible = true;
            if(_data.isCan)
            {
               _blueTxt.text = "" + _data.bluePlayerList.length;
               _redTxt.text = "" + _data.redPlayerList.length;
            }
            else
            {
               _blueTxt.text = "?";
               _redTxt.text = "?";
            }
         }
         _opBtnBox.beginChanges();
         _opBtnBox.removeAllChild();
         switch(int(_data.type) - 3)
         {
            case 0:
            case 1:
               if(_data.camp == model.selfPlay.camp && _loc3_)
               {
                  _loc4_ = _moveBtn;
                  _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerMove");
                  _loc4_.enable = true;
                  _opBtnBox.addChild(_loc4_);
                  if(_loc2_)
                  {
                     _loc4_.enable = false;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerState3");
                  }
                  else
                  {
                     _loc4_.enable = true;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerMove");
                  }
               }
               break;
            default:
               if(_data.nodeId != model.selfPlay.curNodeId && _loc3_)
               {
                  _loc4_ = _moveBtn;
                  if(_loc1_.camp == model.selfPlay.camp)
                  {
                     _opBtnBox.addChild(_loc4_);
                  }
                  else if(_data.camp == model.selfPlay.camp)
                  {
                     _opBtnBox.addChild(_loc4_);
                  }
                  if(_loc2_)
                  {
                     _loc4_.enable = false;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerState3");
                  }
                  else
                  {
                     _loc4_.enable = true;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerMove");
                  }
               }
               if(_data.camp == model.selfPlay.camp)
               {
                  _loc4_ = _defBtn;
                  if(_data.nodeId == model.selfPlay.curNodeId)
                  {
                     _loc4_.enable = true;
                     if(model.selfPlay.state == 5)
                     {
                        _loc4_.text = LanguageMgr.GetTranslation("secretwar.cancelDef");
                     }
                     else
                     {
                        _loc4_.text = LanguageMgr.GetTranslation("secretwar.def");
                     }
                     _opBtnBox.addChild(_loc4_);
                  }
                  else if(_loc3_)
                  {
                     _loc4_.enable = true;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.def");
                     _opBtnBox.addChild(_loc4_);
                  }
                  if(_loc2_)
                  {
                     _loc4_.enable = false;
                  }
                  break;
               }
               _loc4_ = _occBtn;
               if(_data.nodeId == model.selfPlay.curNodeId)
               {
                  _opBtnBox.addChild(_loc4_);
                  if(model.selfPlay.state == 6)
                  {
                     _loc4_.enable = false;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playerState6.occupy");
                  }
                  else
                  {
                     _loc4_.enable = true;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playOcc");
                  }
               }
               else if(_loc3_)
               {
                  if(_loc1_.camp == model.selfPlay.camp)
                  {
                     _loc4_.enable = true;
                     _loc4_.text = LanguageMgr.GetTranslation("secretwar.playOcc");
                     _opBtnBox.addChild(_loc4_);
                  }
               }
               if(_loc2_)
               {
                  _loc4_.enable = false;
               }
         }
         _loc4_ = _infosBtn;
         _loc4_.text = LanguageMgr.GetTranslation("secretwar.infosBtn");
         _opBtnBox.addChild(_loc4_);
         _opBtnBox.commitChanges();
      }
      
      private function moveHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!model.warInfo.gameIsStart)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.noStartGame"));
            return;
         }
         if(model.selfPlay.state == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.wait.river"));
            return;
         }
         if(model.selfPlay.state == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.moving"));
            return;
         }
         if(model.selfPlay.state == 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.occingTip"));
            return;
         }
         if(model.selfPlay.state == 5)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("secretwar.forceMove");
            SimpleAlertHelper.instance.data = [forceMove];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
         else
         {
            SecretWarManager.Instance.gameOp(3,_data.nodeId);
         }
      }
      
      private function forceMove(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            SecretWarManager.Instance.gameOp(3,_data.nodeId);
         }
      }
      
      private function occHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(model.selfPlay.state == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.moving"));
            return;
         }
         if(model.selfPlay.state == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.wait.river"));
            return;
         }
         if(model.selfPlay.state == 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.occingTip"));
            return;
         }
         if(model.selfPlay.state == 5)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("secretwar.moveToOcc");
            SimpleAlertHelper.instance.data = [moveToOcc];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
         else
         {
            SecretWarManager.Instance.gameOp(4,_data.nodeId);
         }
      }
      
      private function moveToOcc(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            SecretWarManager.Instance.gameOp(4,_data.nodeId);
         }
      }
      
      private function defHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(model.selfPlay.state == 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.moving"));
            return;
         }
         if(model.selfPlay.state == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.wait.river"));
            return;
         }
         if(model.selfPlay.state == 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("secretwar.occingTip"));
            return;
         }
         if(model.selfPlay.state == 5)
         {
            if(model.selfPlay.curNodeId == _data.nodeId)
            {
               SecretWarManager.Instance.gameOp(5,_data.nodeId,1);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("public.confirm");
               _loc3_ = LanguageMgr.GetTranslation("public.cancel");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               _loc5_ = LanguageMgr.GetTranslation("secretwar.changeDefNodeTip");
               SimpleAlertHelper.instance.data = [changeDefNode];
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
            }
         }
         else
         {
            SecretWarManager.Instance.gameOp(5,_data.nodeId);
         }
      }
      
      private function changeDefNode(param1:Boolean, param2:Boolean = false) : void
      {
         if(param1)
         {
            SecretWarManager.Instance.gameOp(5,_data.nodeId);
         }
      }
      
      private function infosHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("secretwar",1,_data);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_cd);
         _cd = null;
         ObjectUtils.disposeObject(_npNums);
         _npNums = null;
         ObjectUtils.disposeObject(_stateTxt);
         _stateTxt = null;
         ObjectUtils.disposeObject(_blueTxt);
         _blueTxt = null;
         ObjectUtils.disposeObject(_redTxt);
         _redTxt = null;
         ObjectUtils.disposeObject(_scorebar);
         _scorebar = null;
         ObjectUtils.disposeObject(_moveBtn);
         _moveBtn = null;
         ObjectUtils.disposeObject(_occBtn);
         _occBtn = null;
         ObjectUtils.disposeObject(_defBtn);
         _defBtn = null;
         ObjectUtils.disposeObject(_infosBtn);
         _infosBtn = null;
         ObjectUtils.disposeObject(_opBtnBox);
         _opBtnBox = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_proMask);
         _proMask = null;
         ObjectUtils.disposeObject(_houseSp);
         _houseSp = null;
         ObjectUtils.disposeObject(_menuSp);
         _menuSp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

