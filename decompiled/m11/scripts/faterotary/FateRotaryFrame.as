package faterotary
{
   import chat.datas.ChatData;
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.fate.FateEditMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.faterotary.FateRotaryModel;
   import mvc.module.faterotary.FateRotarySkillInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class FateRotaryFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _back:Bitmap;
      
      private var _splice2:Bitmap;
      
      private var _fateValue:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _back5:Image;
      
      private var _back6:ScaleLeftRightImage;
      
      private var _runBtn:IconButton;
      
      private var _mutiRunBtn:IconButton;
      
      private var _runCircle:Image;
      
      private var _point:Bitmap;
      
      private var _checkBox:SelectedButton;
      
      private var _shieldTxt:FilterFrameText;
      
      private var _freeOpen:FilterFrameText;
      
      private var _costOpen:FilterFrameText;
      
      private var _costIcon1:Image;
      
      private var _costIcon2:Image;
      
      private var _overImg:Image;
      
      private var _maxCount:int = 0;
      
      private var _currentSkill:FateRotarySkillItem;
      
      private var _skillContain:VBox;
      
      private var _group:SelectedButtonGroup;
      
      private var _getItemCountList:Array;
      
      private var _lastCount:int = 0;
      
      private var _play:Boolean;
      
      private var _timeId:int;
      
      private var _mainTimeLine:TimelineMax;
      
      private var refreshId:int;
      
      public function FateRotaryFrame()
      {
         super();
         _rect = new Rectangle(0,0,780,500);
         _maxCount = int(TempleteManager.instance.getConfigInfoByConfigName("Fate_FreeCount").ConfigValue);
         initView();
         initEvent();
         initSkill();
         refreshView();
         titleText = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FrameTitle");
         refreshRunCircleView();
      }
      
      public static function getStoneId(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 208024;
            case 1:
               return 211001;
            case 2:
               return 3300101;
            default:
               return 208024;
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.faterotary.FrameBack");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("faterotary.HelpBtn");
         _splice2 = ComponentFactory.Instance.creatBitmap("asset.faterotary.Splice_2");
         _back5 = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateRotaryRunBack2");
         _back6 = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateRotaryRunBack1");
         _runBtn = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateRotaryRunBtn");
         _mutiRunBtn = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateRotaryMutiRunBtn");
         _runCircle = ComponentFactory.Instance.creatComponentByStylename("faterotary.RunCircle");
         _point = ComponentFactory.Instance.creatBitmap("asset.faterotary.Point");
         _checkBox = ComponentFactory.Instance.creatComponentByStylename("faterotary.CheckBtn");
         _shieldTxt = ComponentFactory.Instance.creatComponentByStylename("faterotary.ShieldTxt");
         _freeOpen = ComponentFactory.Instance.creatComponentByStylename("faterotary.FreeOpenTxt");
         _costOpen = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostOpenTxt");
         _costIcon1 = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostIcon");
         _costIcon2 = ComponentFactory.Instance.creatComponentByStylename("faterotary.CostIcon2");
         _fateValue = ComponentFactory.Instance.creatComponentByStylename("faterotary.FateValue");
         _skillContain = ComponentFactory.Instance.creatCustomObject("faterotary.SkillContain");
         _overImg = ComponentFactory.Instance.creatComponentByStylename("faterotary.SelectedImg");
         addToContent(_back);
         addToContent(_back5);
         addToContent(_back6);
         addToContent(_splice2);
         addToContent(_runCircle);
         addToContent(_point);
         addToContent(_runBtn);
         addToContent(_mutiRunBtn);
         addToContent(_checkBox);
         addToContent(_shieldTxt);
         addToContent(_freeOpen);
         addToContent(_costOpen);
         addToContent(_costIcon1);
         addToContent(_costIcon2);
         addToContent(_skillContain);
         _overImg.mouseChildren = _overImg.mouseEnabled = false;
         _helpBtn.tipData = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.helpTipData");
         _checkBox.selected = false;
         _shieldTxt.htmlText = LanguageMgr.GetTranslation("faterotary.ShieldTxt",int(TempleteManager.instance.getConfigInfoByConfigName("Fate_LockTurn").ConfigValue));
         _costOpen.htmlText = LanguageMgr.GetTranslation("faterotary.Costopen",3);
         _runCircle.display["mask_shape"].visible = false;
         _runCircle.display["multiEffect"]["visible"] = false;
         disableRunCircleEffect();
      }
      
      private function disableRunCircleEffect() : void
      {
         _runCircle.display["effect_2"].visible = false;
         _runCircle.display["effect_4"].visible = false;
         _runCircle.display["effect_6"].visible = false;
         _runCircle.display["effect_8"].visible = false;
         _runCircle.display["effect_20"].visible = false;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : FateRotaryModel
      {
         return FrameControllerManager.instance.fateRotaryControler.model;
      }
      
      private function compare(param1:FateRotarySkillInfo, param2:FateRotarySkillInfo) : Number
      {
         if(param1.templateId > param2.templateId)
         {
            return 1;
         }
         if(param1.templateId == param2.templateId)
         {
            return 0;
         }
         return -1;
      }
      
      private function initSkill() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FateRotarySkillItem = null;
         var _loc3_:Vector.<FateRotarySkillInfo> = ArmyManager.instance.thane.fateRotarySkillList;
         _loc3_.sort(compare);
         _group = new SelectedButtonGroup();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new FateRotarySkillItem(FateRotaryModel.index[_loc2_] - 1,getStoneId(_loc2_));
            if(_loc2_ < _loc3_.length)
            {
               _loc1_.data = _loc3_[_loc2_];
               _loc1_.refreshRunCircleView();
               _loc1_.addEventListener("mouseOver",__overHandler);
               _loc1_.addEventListener("mouseOut",__outHandler);
               _group.addSelectItem(_loc1_);
            }
            else
            {
               _loc1_.data = null;
            }
            _skillContain.addChild(_loc1_);
            _loc2_++;
         }
         _skillContain.refreshChildPos();
         _group.addEventListener("change",__selectedSkillChangeHandler);
         _group.selectIndex = 0;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.selected)
         {
            param1.currentTarget.addChild(_overImg);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_overImg.parent)
         {
            _overImg.parent.removeChild(_overImg);
         }
      }
      
      private function __selectedSkillChangeHandler(param1:Event) : void
      {
         _runCircle.display["mask_shape"].visible = false;
         _currentSkill = _group.getSelectedItem() as FateRotarySkillItem;
         _skillContain.refreshChildPos();
         _currentSkill.refreshRunCircleView();
         _currentSkill.removeAllNextPoints();
         var _loc2_:int = int(FateRotaryModel.index[_group.selectIndex]);
         var _loc3_:MovieClip = _runCircle.display as MovieClip;
         MovieClip(_loc3_.back).gotoAndStop(_loc2_);
         MovieClip(_loc3_.textmc).gotoAndStop(_loc2_);
         refreshView();
         _checkBox.selected = false;
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_maxCount - currentFateCount > 0)
         {
            if(_freeOpen)
            {
               _freeOpen.htmlText = LanguageMgr.GetTranslation("faterotary.Freeopen",toArialBold(_maxCount - currentFateCount + " / " + _maxCount));
               _freeOpen.visible = true;
            }
            if(_costOpen)
            {
               _costOpen.visible = false;
            }
            if(_costIcon2)
            {
               _costIcon2.visible = false;
            }
         }
         else
         {
            if(_freeOpen)
            {
               _freeOpen.visible = false;
            }
            if(_costOpen && _costIcon2)
            {
               _costOpen.visible = true;
               _costIcon2.visible = true;
               _loc1_ = _maxCount - currentFateCount;
               _loc2_ = int(FrameControllerManager.instance.fateRotaryControler.getPointByLeftTime(_loc1_,1,FateRotaryModel.index[_group.selectIndex] - 1));
               _costOpen.htmlText = LanguageMgr.GetTranslation("faterotary.Costopen",_loc2_);
               _costIcon2.x = _costOpen.x + _costOpen.textWidth + 5;
            }
         }
      }
      
      private function get currentFateCount() : int
      {
         if(_group.selectIndex == 0)
         {
            return playerModel.faterotaryCount;
         }
         if(_group.selectIndex == 1)
         {
            return playerModel.faterotaryCount1;
         }
         return playerModel.faterotaryCount2;
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _runBtn.addEventListener("click",__startHandler);
         _mutiRunBtn.addEventListener("click",__mutiStartHandler);
         _checkBox.addEventListener("click",__clickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4545,__resuleHandler);
      }
      
      private function removeEvent() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DisplayObject = null;
         removeEventListener("response",__frameResponse);
         _runBtn.removeEventListener("click",__startHandler);
         _checkBox.removeEventListener("click",__clickHandler);
         _mutiRunBtn.removeEventListener("click",__mutiStartHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4545,__resuleHandler);
         var _loc2_:int = int(_skillContain.numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _skillContain.getChildAt(_loc3_);
            _loc1_.removeEventListener("mouseOver",__overHandler);
            _loc1_.removeEventListener("mouseOut",__outHandler);
            _loc3_++;
         }
         if(_group)
         {
            _group.removeEventListener("change",__selectedSkillChangeHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _runCircle.display["mask_shape"].visible = _checkBox.selected;
      }
      
      private function __mutiStartHandler(param1:MouseEvent) : void
      {
         setEnabale(false);
         var _loc2_:int = _maxCount - currentFateCount;
         var _loc3_:int = int(FrameControllerManager.instance.fateRotaryControler.getPointByLeftTime(_loc2_,10,FateRotaryModel.index[_group.selectIndex] - 1));
         if(_checkBox.selected)
         {
            _loc3_ += 1200;
         }
         var _loc4_:String = LanguageMgr.GetTranslation("faterotary.Costopen.Alert2",_loc3_,10);
         if(_loc2_ > 0)
         {
            _loc4_ = LanguageMgr.GetTranslation("faterotary.Costopen.Alert1",_loc3_,_loc2_);
         }
         SoundManager.instance.play("022");
         showAlert(_loc3_,10,_loc4_);
      }
      
      private function __startHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         setEnabale(false);
         SoundManager.instance.play("022");
         var _loc2_:int = _maxCount - currentFateCount;
         if(_loc2_ > 0)
         {
            if(_checkBox.selected)
            {
               _loc4_ = LanguageMgr.GetTranslation("faterotary.Costopen.Alert2",120,1);
               showAlert(_loc3_,1,_loc4_);
            }
            else
            {
               FrameControllerManager.instance.fateRotaryControler.runFateRotary(1,_checkBox.selected,FateRotaryModel.index[_group.selectIndex]);
            }
         }
         else
         {
            _loc3_ = int(FrameControllerManager.instance.fateRotaryControler.getPointByLeftTime(_loc2_,1,FateRotaryModel.index[_group.selectIndex] - 1));
            if(_checkBox.selected)
            {
               _loc3_ += 120;
            }
            _loc4_ = LanguageMgr.GetTranslation("faterotary.Costopen.Alert2",_loc3_,1);
            showAlert(_loc3_,1,_loc4_);
         }
      }
      
      private function showAlert(param1:int, param2:int, param3:String) : void
      {
         SimpleAlertHelper.instance.data = [activeAlertBack,param2,param1];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,param3,_loc4_,_loc5_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function activeAlertBack(param1:Boolean, param2:Boolean, param3:int, param4:String) : void
      {
         if(param1)
         {
            if(param2)
            {
               if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < int(param4))
               {
                  RechargeAlertMannager.show();
                  setEnabale(true);
               }
               else
               {
                  FrameControllerManager.instance.fateRotaryControler.runFateRotary(param3,_checkBox.selected,FateRotaryModel.index[_group.selectIndex],2);
               }
            }
            else if(PlayerManager.instance.currentPlayerModel.playerInfo.point < int(param4))
            {
               RechargeAlertMannager.show();
               setEnabale(true);
            }
            else
            {
               FrameControllerManager.instance.fateRotaryControler.runFateRotary(param3,_checkBox.selected,FateRotaryModel.index[_group.selectIndex],1);
            }
         }
         else
         {
            setEnabale(true);
         }
      }
      
      private function updateFaterotaryCurrentCount(param1:int) : void
      {
         if(_group.selectIndex == 0)
         {
            playerModel.faterotaryCount = param1;
         }
         else if(_group.selectIndex == 1)
         {
            playerModel.faterotaryCount1 = param1;
         }
         else if(_group.selectIndex == 2)
         {
            playerModel.faterotaryCount2 = param1;
         }
      }
      
      private function __resuleHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:FateEditMsg = new FateEditMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FateEditMsg;
         _getItemCountList = _loc2_.count;
         _play = int(_loc2_.param2) > 0;
         if(_loc2_.isSuccess)
         {
            _lastCount = _getItemCountList[_getItemCountList.length - 1];
            updateFaterotaryCurrentCount(_loc2_.currCount);
            _loc3_ = model.raceDic[_lastCount] + 2160 + Math.random() * (model.rndDic[_lastCount] - 5);
            if(_loc2_.turnNum > 1)
            {
               _runCircle.display["multiEffect"]["visible"] = true;
               TweenMax.to(_runCircle,3,{
                  "rotation":_loc3_,
                  "onComplete":mutiCompleteHandler
               });
               _timeId = setTimeout(mutiUpdate,1000);
            }
            else
            {
               _runCircle.display["multiEffect"]["visible"] = false;
               TweenMax.to(_runCircle,3,{
                  "rotation":_loc3_,
                  "onComplete":completeHandler
               });
            }
         }
         else
         {
            setEnabale(true);
         }
         refreshView();
      }
      
      private function mutiCompleteHandler() : void
      {
         if(!_runCircle)
         {
            return;
         }
         TweenMax.killTweensOf(_runCircle);
         _runCircle.display["multiEffect"]["visible"] = false;
         disableRunCircleEffect();
         _runCircle.display["gotoAndStop"](1);
         _play = false;
      }
      
      private function mutiUpdate() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Point = null;
         clearTimeout(_timeId);
         _timeId = 0;
         if(_play)
         {
            _loc2_ = _container.globalToLocal(_runBtn.localToGlobal(new Point(-15,-15)));
            _loc1_ = _container.globalToLocal(_currentSkill.getFlyTarget());
            playGetEffect(_getItemCountList,_loc2_,_loc1_,FateRotaryModel.index[_group.selectIndex] - 1);
         }
         else
         {
            setEnabale(true);
         }
      }
      
      private function completeHandler() : void
      {
         if(!_runCircle)
         {
            return;
         }
         TweenMax.killTweensOf(_runCircle);
         if(_getItemCountList[_getItemCountList.length - 1] <= 10)
         {
            _runCircle.display["effect_" + _lastCount].visible = true;
            _runCircle.display["gotoAndPlay"](1);
            _runCircle.display["mask_shape"].visible = _checkBox.selected;
         }
         _timeId = setTimeout(timeOut,2000);
      }
      
      private function timeOut() : void
      {
         var _loc2_:Point = null;
         var _loc1_:Point = null;
         disableRunCircleEffect();
         _runCircle.display["gotoAndStop"](1);
         clearTimeout(_timeId);
         _timeId = 0;
         if(_play)
         {
            _loc2_ = _container.globalToLocal(_runBtn.localToGlobal(new Point(-15,-15)));
            _loc1_ = _container.globalToLocal(_currentSkill.getFlyTarget());
            playGetEffect(_getItemCountList,_loc2_,_loc1_,FateRotaryModel.index[_group.selectIndex] - 1);
         }
         else
         {
            setEnabale(true);
         }
         _play = false;
      }
      
      public function setEnabale(param1:Boolean) : void
      {
         enterEnable = escEnable = param1;
         _runBtn.enable = param1;
         _mutiRunBtn.enable = param1;
         _closeButton.enable = param1;
         _checkBox.enable = param1;
         _container.mouseChildren = param1;
         if(KeyBoardRegister.instance.keyEnable != param1)
         {
            KeyBoardRegister.instance.keyEnable = param1;
         }
      }
      
      public function refreshRunCircleView() : void
      {
         var _loc2_:SkillTempInfo = null;
         var _loc1_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc9_:FateRotarySkillInfo = null;
         var _loc7_:Vector.<FateRotarySkillInfo> = ArmyManager.instance.thane.fateRotarySkillList;
         _loc7_.sort(compare);
         var _loc8_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc5_];
            _loc2_ = _loc9_.template;
            _loc1_ = LanguageMgr.GetTranslation("public.grade") + "  " + _loc9_.grades;
            _loc3_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip","  " + _loc2_.TemplateName);
            _loc6_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip",_loc1_);
            _loc8_.addItem(_loc3_ + "       " + _loc6_,null);
            _loc4_ += _loc9_.totalGp;
            _loc5_++;
         }
         _loc1_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FateTip1",_loc4_ * 10);
         _loc8_.addItemAt(_loc1_,null);
         _fateValue.text = (_loc4_ * 10).toString();
         if(_currentSkill)
         {
            _currentSkill.refreshRunCircleView();
         }
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("faterotary.HelperFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function playGetEffect(param1:Array, param2:Point, param3:Point, param4:int) : void
      {
         var _loc5_:MovieClip = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:TimelineMax = null;
         if(_mainTimeLine)
         {
            _mainTimeLine.currentProgress = 1;
         }
         setEnabale(false);
         var _loc11_:Array = [];
         _mainTimeLine = new TimelineMax({
            "onComplete":onTweenComplete,
            "onCompleteParams":[_loc11_,param1,param4]
         });
         var _loc6_:int = int(param1.length);
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc5_ = ComponentFactory.Instance.creat("asset.faterotary.FlyEffect");
            MovieClip(_loc5_.icon).gotoAndStop(FateRotaryModel.index[_group.selectIndex]);
            _loc5_.mouseEnabled = _loc5_.mouseChildren = false;
            _loc5_["txt"].text = "+" + param1[_loc9_];
            _loc5_.x = param2.x;
            _loc5_.y = param2.y;
            _loc5_.alpha = 0;
            _loc5_.scaleX = 0.83;
            _loc5_.scaleY = 0.83;
            addToContent(_loc5_);
            _loc7_ = param2.x + (param3.x - param2.x) / 3;
            _loc8_ = param2.y + (param3.y - param2.y) / 2;
            _loc10_ = new TimelineMax();
            _loc10_.insert(TweenMax.to(_loc5_,0.4,{
               "alpha":1,
               "x":_loc7_,
               "y":_loc8_,
               "scaleX":1,
               "scaleY":1
            }),0);
            _loc10_.insert(TweenMax.to(_loc5_,0.5,{
               "alpha":0,
               "x":param3.x,
               "y":param3.y,
               "scaleX":0.83,
               "scaleY":0.83
            }),0.4);
            _mainTimeLine.insert(_loc10_,_loc9_ * 0.2);
            _loc11_.push(_loc5_);
            _loc9_++;
         }
         _mainTimeLine.play();
      }
      
      private function onTweenComplete(param1:Array, param2:Array, param3:int) : void
      {
         var _loc7_:String = null;
         setEnabale(true);
         if(_mainTimeLine)
         {
            _mainTimeLine.kill();
            _mainTimeLine = null;
         }
         while(param1 && param1.length != 0)
         {
            ObjectUtils.disposeObject(param1.pop());
         }
         if(!parent)
         {
            return;
         }
         var _loc4_:int = 0;
         for each(var _loc5_:int in param2)
         {
            _loc4_ += _loc5_;
         }
         if(param3 == 0)
         {
            _loc7_ = LanguageMgr.GetTranslation("faterotary.Costopen.GetStoneAlert",_loc4_);
         }
         else if(param3 == 1)
         {
            _loc7_ = LanguageMgr.GetTranslation("faterotary.Costopen.GetStoneAlert1",_loc4_);
         }
         else if(param3 == 2)
         {
            _loc7_ = LanguageMgr.GetTranslation("faterotary.Costopen.GetStoneAlert2",_loc4_);
         }
         var _loc6_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc6_)
         {
            _loc6_.channel = 3;
            _loc6_.msg = _loc7_;
            _loc6_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc6_);
            MessageTipManager.instance().show(_loc7_);
         }
         if(isDie)
         {
            return;
         }
         if(refreshId > 0)
         {
            clearTimeout(refreshId);
         }
         refreshId = 0;
         refreshId = setTimeout(refreshRunCircleView,700);
         refreshView();
         if(_currentSkill)
         {
            _currentSkill.playAddMovie();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      override public function dispose() : void
      {
         if(!KeyBoardRegister.instance.keyEnable)
         {
            KeyBoardRegister.instance.keyEnable = true;
         }
         if(_mainTimeLine)
         {
            _mainTimeLine.currentProgress = 1;
            _mainTimeLine = null;
         }
         removeEvent();
         if(_timeId > 0)
         {
            clearTimeout(_timeId);
         }
         _timeId = 0;
         if(refreshId > 0)
         {
            clearTimeout(refreshId);
         }
         refreshId = 0;
         TweenMax.killChildTweensOf(this);
         ObjectUtils.disposeObject(_fateValue);
         _fateValue = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_mutiRunBtn);
         _mutiRunBtn = null;
         ObjectUtils.disposeObject(_runBtn);
         _runBtn = null;
         ObjectUtils.disposeObject(_runCircle);
         _runCircle = null;
         ObjectUtils.disposeObject(_point);
         _point = null;
         ObjectUtils.disposeObject(_checkBox);
         _checkBox = null;
         ObjectUtils.disposeObject(_shieldTxt);
         _shieldTxt = null;
         ObjectUtils.disposeObject(_freeOpen);
         _freeOpen = null;
         ObjectUtils.disposeObject(_costOpen);
         _costOpen = null;
         ObjectUtils.disposeObject(_costIcon1);
         _costIcon1 = null;
         ObjectUtils.disposeObject(_costIcon2);
         _costIcon2 = null;
         _currentSkill = null;
         super.dispose();
      }
   }
}

