package slot
{
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.SoundManager;
   import events.SlotEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.SlotManager;
   import mvc.module.slot.SlotModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.component.MovieButton2;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SlotFrame extends Frame implements IManualSize
   {
      
      public static const RESULTCOL:int = 7;
      
      private var _helpBtn:BaseButton;
      
      private var _rewardTxtImage:Image;
      
      private var _valueBg:Image;
      
      private var _getRewardBtn:IconButton;
      
      private var _daysbmp:Bitmap;
      
      private var _addBtn:IconButton;
      
      private var _numBmpData:BitmapData;
      
      private var _slotResultArr:Array;
      
      private var _pullBtn:MovieButton2;
      
      private var _partticipateDayTxt:FilterFrameText;
      
      private var _lightMc:MovieClip;
      
      private var _rewardIcon:ScaleFrameImage;
      
      private var _noticeTxt:GradientText;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _rewardValueBmtArr:Array;
      
      private var _rewardValuePosXArr:Array = [97,155,190,228,285,323,357];
      
      private var _rewardValuePosY:int = 280;
      
      private var _regExp:RegExp;
      
      private var _participateDay:int = 0;
      
      private var _currentIndex:int = 99;
      
      private var _noticeArr:Array;
      
      private var _noticeStrs:String;
      
      private var _rewardIndex:int;
      
      private var _rect:Sprite;
      
      private var _gradientRect1:Shape;
      
      private var _gradientRect2:Shape;
      
      private var _intervalId:int;
      
      private var tempParam:int = 0;
      
      public function SlotFrame()
      {
         super();
         initView();
         initEvent();
         SlotManager.Instance.sendSlotReq(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,549,472);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.helpBtn");
         _rewardTxtImage = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.rewardTxtImage");
         _valueBg = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.rewardValueBg");
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.getRewardBtn");
         _daysbmp = ComponentFactory.Instance.creatBitmap("asset.slot.slotFrame.daysbmp");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.addBtn");
         _pullBtn = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.pullBtn");
         _partticipateDayTxt = ComponentFactory.Instance.creatComponentByStylename("slot.slotFrame.participateDayTxt");
         _lightMc = ComponentFactory.Instance.creatCustomObject("asset.slot.light");
         _rewardIcon = ComponentFactory.Instance.creatComponentByStylename("slot.rewardType");
         _noticeTxt = ComponentFactory.Instance.creatComponentByStylename("slot.noticeTxt");
         _numBmpData = ComponentFactory.Instance.creatBitmapData("asset.slot.numberpng").clone();
         _effect = new MainToolBtnGlowEffect(_getRewardBtn);
         _effect.stop();
         addToContent(_helpBtn);
         addToContent(_rewardTxtImage);
         addToContent(_valueBg);
         addToContent(_getRewardBtn);
         _getRewardBtn.enable = false;
         addToContent(_daysbmp);
         addToContent(_addBtn);
         addToContent(_pullBtn);
         addToContent(_partticipateDayTxt);
         addToContent(_rewardIcon);
         var _loc1_:TextField = new TextField();
         _loc1_.wordWrap = true;
         _loc1_.height = 40;
         _loc1_.width = 350;
         _loc1_.selectable = false;
         var _loc4_:TextFormat = new TextFormat(null,13,null,true);
         _loc1_.defaultTextFormat = _loc4_;
         _noticeTxt.textField = _loc1_;
         addToContent(_noticeTxt);
         _regExp = /[0-9]/;
         titleText = LanguageMgr.GetTranslation("slot.slotFrame.title");
         _helpBtn.tipData = LanguageMgr.GetTranslation("slot.slotFrame.helpBtnTip");
         KeyBoardRegister.instance.keyEnable = false;
         _rewardValueBmtArr = [];
         _slotResultArr = [];
         _rect = new Sprite();
         _rect.graphics.beginFill(16777215,0);
         _rect.graphics.drawRect(0,0,55,75);
         _rect.graphics.endFill();
         _rect.x = 390;
         _rect.y = 200;
         addToContent(_rect);
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _slotResultArr[_loc2_] = ComponentFactory.Instance.creatCustomObject("asset.slot.slotResult_" + _loc2_);
            addToContent(_slotResultArr[_loc2_]);
            (_slotResultArr[_loc2_] as MovieClip).gotoAndStop("pointStart");
            _loc2_++;
         }
         var _loc3_:Matrix = new Matrix();
         _loc3_.createGradientBox(330,50,3.141592653589793 / 2);
         _gradientRect1 = new Shape();
         _gradientRect1.graphics.clear();
         _gradientRect1.graphics.beginGradientFill("linear",[0,0],[0.8,0],[0,255],_loc3_);
         _gradientRect1.graphics.drawRoundRect(0,0,330,50,10);
         _gradientRect1.graphics.endFill();
         _gradientRect2 = new Shape();
         _gradientRect2.graphics.clear();
         _gradientRect2.graphics.beginGradientFill("linear",[0,0],[0,0.8],[0,255],_loc3_);
         _gradientRect2.graphics.drawRoundRect(0,0,330,50,10);
         _gradientRect2.graphics.endFill();
         addToContent(_gradientRect1);
         _gradientRect1.x = 66;
         _gradientRect1.y = 84;
         addToContent(_gradientRect2);
         _gradientRect2.x = 66;
         _gradientRect2.y = 142;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
         _getRewardBtn.addEventListener("click",__getRewardHandler);
         _addBtn.addEventListener("click",__addHandler);
         SlotManager.Instance.addEventListener("SLOTINFO",__slotInfoHandler);
         _pullBtn.addEventListener("click",__pullHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
         _getRewardBtn.removeEventListener("click",__getRewardHandler);
         _addBtn.removeEventListener("click",__addHandler);
         SlotManager.Instance.removeEventListener("SLOTINFO",__slotInfoHandler);
         _pullBtn.removeEventListener("click",__pullHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.slotHelpFrame");
         _loc2_.show();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!slotModel.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.activityOver"));
            return;
         }
         setCurrentIndexByAdd();
         SimpleAlertHelper.instance.data = [sendAdd];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("slot.slotFrame.findCost",slotModel.findCost);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function setCurrentIndexByAdd() : void
      {
         var _loc1_:int = 0;
         _loc1_ = slotModel.slotResult.length - 1;
         while(_loc1_ >= 0)
         {
            if(slotModel.slotResult.charAt(_loc1_) == "+" || slotModel.slotResult.charAt(_loc1_) == "*")
            {
               _currentIndex = _loc1_;
               break;
            }
            _loc1_--;
         }
      }
      
      private function sendAdd(param1:Boolean = true, param2:Boolean = true) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < slotModel.findCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            (_slotResultArr[_currentIndex] as MovieClip).gotoAndPlay("roll");
            SlotManager.Instance.sendSlotReq(11);
            _addBtn.enable = false;
            _pullBtn.mouseChildren = _pullBtn.mouseEnabled = false;
            if(_getRewardBtn.enable)
            {
               _getRewardBtn.mouseChildren = _getRewardBtn.mouseEnabled = false;
            }
            this.closeButton.enable = false;
         }
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(!slotModel.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.activityOver"));
            return;
         }
         if(_participateDay < getAllDays())
         {
            SimpleAlertHelper.instance.data = [sendGetReward];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("slot.slotFrame.getRewardWarn");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
         }
         else
         {
            SlotManager.Instance.sendSlotReq(3);
         }
      }
      
      private function sendGetReward(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SlotManager.Instance.sendSlotReq(3);
         }
      }
      
      private function __pullHandler(param1:MouseEvent) : void
      {
         if(!slotModel.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.activityOver"));
            return;
         }
         if(slotModel.status == 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.gotRewardNotice"));
            return;
         }
         setCurrentIndex();
         if(_currentIndex == 99)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.noTimes"));
            return;
         }
         SoundManager.instance.play("022");
         SlotManager.Instance.sendSlotReq(2);
         _slotResultArr[_currentIndex].gotoAndPlay("roll");
         _pullBtn.mouseChildren = _pullBtn.mouseEnabled = false;
         _addBtn.enable = false;
         if(_getRewardBtn.enable)
         {
            _getRewardBtn.mouseChildren = _getRewardBtn.mouseEnabled = false;
         }
         this.closeButton.enable = false;
      }
      
      private function __slotComplete(param1:Event) : void
      {
         (_slotResultArr[_currentIndex] as MovieClip).removeEventListener("complete",__slotComplete);
         _lightMc.x = _slotResultArr[_currentIndex].x;
         _lightMc.y = _slotResultArr[_currentIndex].y - 60;
         addToContent(_lightMc);
         _lightMc.addEventListener("complete",__lightComplete);
         _lightMc.play();
      }
      
      private function __lightComplete(param1:Event) : void
      {
         _lightMc.removeEventListener("complete",__lightComplete);
         _lightMc.parent.removeChild(_lightMc);
         moveResult();
      }
      
      private function __slotInfoHandler(param1:SlotEvent) : void
      {
         switch(int(slotModel.op))
         {
            case 0:
               doNothing();
               break;
            case 1:
               __refreshView();
               break;
            case 2:
            case 10:
            case 11:
               _intervalId = setTimeout(slotRoll,2000);
               break;
            case 3:
               getReward();
         }
      }
      
      private function get slotModel() : SlotModel
      {
         return SlotManager.Instance.model;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         TweenMax.killAll(true);
         if(!slotModel.slotRefuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!slotModel.slotRefuseInvitation)
         {
            SharedManager.instance.refuseInvitation = slotModel.slotRefuseInvitation;
            SharedManager.instance.save();
         }
         if(!slotModel.slotRefuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function doNothing() : void
      {
      }
      
      private function slotRoll() : void
      {
         if(_intervalId != 0)
         {
            clearTimeout(_intervalId);
         }
         var _loc2_:String = slotModel.slotResult;
         var _loc1_:int = int(_loc2_.charAt(_currentIndex));
         var _loc3_:String = getResultStr(_loc1_);
         _slotResultArr[_currentIndex].gotoAndStop("pointStart");
         NumberViewUtils.refreshValueY(_loc3_,_slotResultArr[_currentIndex]["n1"],_numBmpData,29,53,53,53,"1234567890");
         NumberViewUtils.refreshValueY(_loc3_,_slotResultArr[_currentIndex]["n2"],_numBmpData,29,53,53,53,"1234567890");
         _slotResultArr[_currentIndex].play();
         (_slotResultArr[_currentIndex] as MovieClip).addEventListener("complete",__slotComplete);
      }
      
      private function checkPartDays() : void
      {
         var _loc1_:int = 0;
         _participateDay = 0;
         _loc1_ = 0;
         while(_loc1_ < slotModel.slotResult.length)
         {
            if(slotModel.slotResult.charAt(_loc1_).match(_regExp))
            {
               _participateDay = _participateDay + 1;
            }
            _loc1_++;
         }
      }
      
      private function moveResult() : void
      {
         var _loc1_:int = int(slotModel.slotResult.charAt(_currentIndex));
         var _loc3_:Point = new Point(_slotResultArr[_currentIndex].x,_slotResultArr[_currentIndex].y);
         var _loc4_:Point = new Point(_rewardValuePosXArr[_currentIndex],_rewardValuePosY);
         var _loc2_:Bitmap = NumberViewUtils.getNumberBitMap(_loc1_,_numBmpData,29,53,53,"1234567890");
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         TweenMax.to(_loc2_,2,{
            "bezierThrough":[{
               "x":_loc4_.x,
               "y":_loc4_.y - 50
            },{
               "x":_loc4_.x,
               "y":_loc4_.y
            }],
            "onStart":__moveStart,
            "onStartParams":[_loc2_],
            "onComplete":__moveComplete,
            "onCompleteParams":[_loc2_]
         });
      }
      
      private function __moveStart(param1:Bitmap) : void
      {
         if(!param1.parent && param1)
         {
            addToContent(param1);
         }
      }
      
      private function __moveComplete(param1:Bitmap) : void
      {
         var _loc2_:int = int(slotModel.slotResult.charAt(_currentIndex));
         checkPartDays();
         _partticipateDayTxt.text = _participateDay + "/" + getAllDays();
         _pullBtn.mouseChildren = _pullBtn.mouseEnabled = true;
         if(_getRewardBtn.enable)
         {
            _getRewardBtn.mouseChildren = _getRewardBtn.mouseEnabled = true;
         }
         this.closeButton.enable = true;
         setCurrentIndex();
         setButtonState();
         showNotice();
      }
      
      private function showNotice() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < slotModel.slotResult.length)
         {
            if(slotModel.slotResult.charAt(_loc4_) == "*")
            {
               _loc3_++;
            }
            if(slotModel.slotResult.charAt(_loc4_) == "+")
            {
               _loc2_++;
            }
            if(slotModel.slotResult.charAt(_loc4_) == "-")
            {
               _loc5_++;
            }
            _loc4_++;
         }
         if(_loc3_ != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.pullTimesNotice",_loc3_));
            return;
         }
         if(_loc2_ != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.addTimesNotice",_loc2_));
            return;
         }
         if(_loc5_ != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("slot.slotFrame.conTomorrowNotice"));
            return;
         }
      }
      
      private function addRewardValueBmp(param1:int, param2:int) : void
      {
         var _loc3_:Bitmap = _rewardValueBmtArr[param1] as Bitmap;
         if(!_loc3_)
         {
            _loc3_ = NumberViewUtils.getNumberBitMap(param2,_numBmpData,29,53,53,"1234567890");
            addToContent(_loc3_);
            _loc3_.x = _rewardValuePosXArr[param1];
            _loc3_.y = _rewardValuePosY;
         }
      }
      
      private function __refreshView() : void
      {
         var _loc2_:String = null;
         var _loc5_:String = null;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = slotModel.slotResult;
         setHelpNotice();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ = _loc3_.charAt(_loc4_);
            if(_loc2_.match(_regExp))
            {
               _loc1_ = int(_loc2_);
               addRewardValueBmp(_loc4_,_loc1_);
               _loc1_ = (_loc1_ + 1) % 10;
               _loc5_ = getResultStr(_loc1_);
               NumberViewUtils.refreshValueY(_loc5_,_slotResultArr[_loc4_]["n1"],_numBmpData,29,53,53,53,"1234567890");
               NumberViewUtils.refreshValueY(_loc5_,_slotResultArr[_loc4_]["n2"],_numBmpData,29,53,53,53,"1234567890");
            }
            if(_loc2_ == "#")
            {
               (_slotResultArr[_loc4_] as MovieClip).filters = [new ColorMatrixFilter([0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0.1,0.59,0.11,0,0,0,0,0,1,0])];
            }
            _loc4_++;
         }
         setRewardIcon();
         setCurrentIndex();
         checkPartDays();
         _partticipateDayTxt.text = _participateDay + "/" + getAllDays();
         setButtonState();
      }
      
      private function setHelpNotice() : void
      {
         if(slotModel.type == 1)
         {
            _noticeStrs = LanguageMgr.GetTranslation("slot.slotFrame.noticeArrNewS");
         }
         else if(slotModel.type == 2)
         {
            _noticeStrs = LanguageMgr.GetTranslation("slot.slotFrame.noticeArrOldS");
         }
         _noticeArr = _noticeStrs.split("|");
         _noticeTxt.text = LanguageMgr.GetTranslation("slot.slotFrame.notice") + getNotice();
      }
      
      private function setRewardIcon() : void
      {
         switch(slotModel.rewardTemplateId)
         {
            case -100:
               _rewardIcon.setFrame(1);
               break;
            case -300:
               _rewardIcon.setFrame(2);
               break;
            case -600:
               _rewardIcon.setFrame(3);
               break;
            case -500:
               _rewardIcon.setFrame(4);
         }
      }
      
      private function setButtonState() : void
      {
         if(slotModel.status == 1)
         {
            _getRewardBtn.enable = true;
            _effect.play();
         }
         if(slotModel.type == 1)
         {
            _addBtn.enable = false;
         }
         _addBtn.enable = checkAddChance();
      }
      
      private function checkAddChance() : Boolean
      {
         var _loc1_:int = 0;
         if(slotModel.status == 2)
         {
            return false;
         }
         _loc1_ = slotModel.slotResult.length - 1;
         while(_loc1_ >= 0)
         {
            if(slotModel.slotResult.charAt(_loc1_) == "+")
            {
               return true;
            }
            _loc1_--;
         }
         return false;
      }
      
      private function getAllDays() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < slotModel.slotResult.length)
         {
            if(slotModel.slotResult.charAt(_loc2_) != "#")
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function setCurrentIndex() : void
      {
         _currentIndex = 99;
         if(slotModel.type == 2)
         {
            setCurrentIndexOldServer();
         }
         else if(slotModel.type == 1)
         {
            setCurrentIndexNewServer();
         }
      }
      
      private function setCurrentIndexNewServer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = 0;
         while(_loc2_ < slotModel.slotResult.length)
         {
            _loc1_ = slotModel.slotResult.charAt(_loc2_);
            if(_loc1_ == "*")
            {
               _currentIndex = _loc2_;
               break;
            }
            _loc2_++;
         }
      }
      
      private function setCurrentIndexOldServer() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         _loc2_ = slotModel.slotResult.length - 1;
         while(_loc2_ >= 0)
         {
            _loc1_ = slotModel.slotResult.charAt(_loc2_);
            if(_loc1_ == "*")
            {
               _currentIndex = _loc2_;
               break;
            }
            _loc2_--;
         }
      }
      
      private function getReward() : void
      {
         _effect.stop();
         _getRewardBtn.enable = false;
         _addBtn.enable = false;
      }
      
      private function getResultStr(param1:int) : String
      {
         var _loc2_:int = 0;
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc3_ += ((param1 + _loc2_ + 9) % 10).toString();
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function getNotice() : String
      {
         var _loc1_:int = Math.floor(Math.random() * 10) % 3;
         return _noticeArr[_loc1_];
      }
   }
}

