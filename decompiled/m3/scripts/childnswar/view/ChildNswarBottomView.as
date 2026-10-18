package childnswar.view
{
   import battle.BattleManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildNswarManager;
   import mvc.module.childnswar.ChildNswarModel;
   import mvc.module.childnswar.ChildNswarSeasonInfo;
   import mvc.module.childnswar.ChildNswarUserInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildNswarTempInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ProgressPanel;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNswarBottomView extends Sprite
   {
      
      public var _bottomIcon:ScaleFrameImage;
      
      public var _bottomBg:Bitmap;
      
      public var _bottomTagright:Image;
      
      public var _bottomTagLeft:Image;
      
      public var _bottomNextStepTxt:FilterFrameText;
      
      public var _bottomProTxt:FilterFrameText;
      
      public var _bottomBtnBg:Bitmap;
      
      public var _bottomFreeTxt:FilterFrameText;
      
      private var _matchBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _stepTxt:GradientText;
      
      private var _progress:ProgressPanel;
      
      private var _jImg:Image;
      
      private var _buyBtn:BaseButton;
      
      private var _numBack:Image;
      
      private var _macthMc:MovieClip;
      
      private var _seasonStartTimeDate:Date;
      
      private var _seasonOverTimeDate:Date;
      
      private var _matchOpenTimeDate:Date;
      
      private var _matchEndTimeDate:Date;
      
      private var _configBuyDic:Dictionary = new Dictionary();
      
      private var _maxBuyTime:int;
      
      public function ChildNswarBottomView()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         _bottomIcon = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.bottomIcon");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.bottomBg");
         _bottomTagright = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomTagright");
         _bottomTagLeft = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomTagLeft");
         _bottomNextStepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomNextStepTxt");
         _bottomProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomProTxt");
         _bottomBtnBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.bottomBtnBg");
         _bottomFreeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.bottomFreeTxt");
         _matchBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.matchBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.cancelMatchBtn");
         _stepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.sceneBottomStepTxt");
         _jImg = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.buyIcon");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.buyJBtn");
         _numBack = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.numBack");
         _macthMc = ComponentFactory.Instance.creatCustomObject("asset.theseuspvp.matchMC");
         _progress = new ProgressPanel();
         _progress.initView("asset.theseuspvp.bottomBarBg","asset.theseuspvp.bottomBar","ui.theseuspvp.bottomProTxt");
         _progress.x = 109;
         _progress.y = 282;
         addChild(_bottomIcon);
         addChild(_bottomBg);
         addChild(_bottomTagright);
         addChild(_bottomTagLeft);
         addChild(_bottomNextStepTxt);
         addChild(_bottomProTxt);
         addChild(_bottomBtnBg);
         addChild(_numBack);
         addChild(_bottomFreeTxt);
         addChild(_matchBtn);
         addChild(_cancelBtn);
         addChild(_stepTxt);
         addChild(_progress);
         addChild(_jImg);
         addChild(_buyBtn);
         addChild(_macthMc);
         _cancelBtn.visible = false;
         _numBack.visible = false;
         _macthMc.visible = false;
         _macthMc.stop();
         _macthMc.mouseEnabled = false;
         _jImg.buttonMode = true;
         _jImg.tipData = LanguageMgr.GetTranslation("theseuspvp.useTip");
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("child_pvp_buy_count_points");
         if(_loc1_)
         {
            _loc2_ = _loc1_.ConfigValue.split("|");
            _maxBuyTime = _loc2_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc3_];
               if(_loc5_.length >= 2)
               {
                  _loc4_ = _loc5_.split(",");
                  _configBuyDic[int(_loc4_[0])] = int(_loc4_[1]);
               }
               _loc3_++;
            }
         }
         refreshCD();
      }
      
      private function refreshCD() : void
      {
         var _loc1_:ChildNswarSeasonInfo = model.seasonTimeInfo;
         _seasonStartTimeDate = DateFormatter.parse(_loc1_.seasonStartDate,"YYYY-MM-DD hh:mm:ss");
         _seasonOverTimeDate = DateFormatter.parse(_loc1_.seasonStopDate,"YYYY-MM-DD hh:mm:ss");
         _matchOpenTimeDate = DateFormatter.parse(_loc1_.matchStartDate,"YYYY-MM-DD hh:mm:ss");
         _matchEndTimeDate = DateFormatter.parse(_loc1_.matchStopDate,"YYYY-MM-DD hh:mm:ss");
      }
      
      private function refreshView() : void
      {
         updateInfos();
         updateMatchState();
      }
      
      private function updateInfos() : void
      {
         var _loc1_:ChildNswarTempInfo = null;
         var _loc2_:ChildNswarUserInfo = model.selfUserInfo;
         var _loc3_:ChildNswarTempInfo = TempleteManager.instance.childNswarCate.getTempById(_loc2_.pvpId);
         if(_loc3_)
         {
            _stepTxt.text = _loc3_.Name;
            _bottomIcon.setFrame(_loc3_.MainType);
            _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(_loc3_.MainType,_loc3_.SonType + 1);
            if(_loc1_ == null)
            {
               _loc1_ = TempleteManager.instance.childNswarCate.getTempByType(_loc3_.MainType + 1,1);
            }
            if(_loc1_)
            {
               _progress.progressValue(_loc2_.integral,_loc1_.NeedIntegral);
               _bottomNextStepTxt.text = LanguageMgr.GetTranslation("theseuspvp.nextStep",_loc1_.Name);
            }
            else
            {
               _bottomNextStepTxt.text = "";
               _progress.showMax();
               _progress.setValueText(_loc2_.integral + "/" + _loc3_.NeedIntegral);
            }
         }
         var _loc4_:int = _loc2_.freeCount + _loc2_.addCount;
         _buyBtn.visible = true;
         _numBack.visible = true;
         _bottomFreeTxt.text = LanguageMgr.GetTranslation("theseuspvp.leftTime",_loc4_);
      }
      
      public function sesonChange() : void
      {
         refreshCD();
      }
      
      public function updateMatchState() : void
      {
         var _loc2_:ChildNswarMatchView = null;
         var _loc1_:ChildNswarMatchView = null;
         if(BattleManager.getInstance().isLockChildnswar)
         {
            visible = false;
            MainToolBar.instance.switchToolsBarState(3);
            if(model.matchState == 2)
            {
               _loc2_ = new ChildNswarMatchView();
               _loc2_.show();
            }
         }
         else
         {
            visible = true;
            if(model.matchState == 1)
            {
               _matchBtn.visible = true;
               _cancelBtn.visible = false;
               _macthMc.visible = false;
               _macthMc.stop();
               MainToolBar.instance.switchToolsBarState(4);
            }
            else if(model.matchState == 0)
            {
               _matchBtn.visible = false;
               _cancelBtn.visible = true;
               _macthMc.visible = true;
               _macthMc.gotoAndPlay(1);
               MainToolBar.instance.switchToolsBarState(3);
            }
            else if(model.matchState == 2)
            {
               visible = false;
               _loc1_ = new ChildNswarMatchView();
               _loc1_.show();
            }
         }
      }
      
      private function get model() : ChildNswarModel
      {
         return ChildNswarManager.Instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initEvent() : void
      {
         _matchBtn.addEventListener("click",matchHandler);
         _cancelBtn.addEventListener("click",cancelHandler);
         _buyBtn.addEventListener("click",buyClickHandler);
         _jImg.addEventListener("click",useAddTimeHandler);
         NotificationManager.instance.addEventListener("childnswarUserInfoEvent",userChangeHandler);
         NotificationManager.instance.addEventListener("childNswarLockChange",lockChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _matchBtn.removeEventListener("click",matchHandler);
         _cancelBtn.removeEventListener("click",cancelHandler);
         _buyBtn.removeEventListener("click",buyClickHandler);
         _jImg.removeEventListener("click",useAddTimeHandler);
         NotificationManager.instance.removeEventListener("childnswarUserInfoEvent",userChangeHandler);
         NotificationManager.instance.removeEventListener("childNswarLockChange",lockChangeHandler);
      }
      
      private function lockChangeHandler(param1:NotificationEvent) : void
      {
         updateMatchState();
      }
      
      private function useAddTimeHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("childnswar","BUY_TIME");
      }
      
      private function userChangeHandler(param1:NotificationEvent) : void
      {
         updateInfos();
      }
      
      private function buyClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc5_:ChildNswarUserInfo = model.selfUserInfo;
         var _loc7_:int = _loc5_.buyCount + 1;
         if(_configBuyDic[_loc7_])
         {
            _loc6_ = int(_configBuyDic[_loc7_]);
            if(_loc6_ > 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("theseuspvp.buyAlert",_loc6_,_maxBuyTime);
               SimpleAlertHelper.instance.data = [confirmChoose];
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.cancel");
               _loc8_ = LanguageMgr.GetTranslation("public.prompt");
               SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc2_,_loc3_,_loc4_,true,true);
            }
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.buyMax"));
         }
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            ChildNswarManager.Instance.doSomething(3);
         }
      }
      
      private function matchHandler(param1:MouseEvent) : void
      {
         var _loc12_:String = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc11_:ChildNswarSeasonInfo = model.seasonTimeInfo;
         var _loc5_:Number = Number(playerModel.sysCurTimeBySecond);
         var _loc7_:Number = _seasonStartTimeDate.time / 1000 - _loc5_;
         if(_loc7_ > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnswar.wait.start"));
            return;
         }
         var _loc8_:Number = _seasonOverTimeDate.time / 1000 - _loc5_;
         if(_loc8_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.inCounting"));
            return;
         }
         if(!(_matchOpenTimeDate.time / 1000 <= _loc5_ && _loc5_ < _matchEndTimeDate.time / 1000))
         {
            _loc12_ = _loc11_.matchStartDate.substr(11);
            _loc4_ = _loc11_.matchStopDate.substr(11);
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnswar.match.tip",_loc12_,_loc4_));
            return;
         }
         var _loc2_:ChildNswarUserInfo = model.selfUserInfo;
         var _loc9_:int = _loc2_.freeCount + _loc2_.addCount;
         if(_loc9_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.fightNeedGood"));
            return;
         }
         var _loc10_:Array = _loc2_.fightInfo.split(",");
         var _loc3_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            if(int(_loc10_[_loc6_]) > 0)
            {
               _loc3_ = true;
               break;
            }
            _loc6_++;
         }
         if(!_loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childnswar.match.needTeam"));
            return;
         }
         ChildNswarManager.Instance.doSomething(4);
      }
      
      private function cancelHandler(param1:MouseEvent) : void
      {
         ChildNswarManager.Instance.doSomething(5);
      }
      
      public function resize(param1:int, param2:int) : void
      {
         this.x = (param1 - this.width) * 0.5;
         this.y = param2 - this.height - 158;
      }
      
      public function dispose() : void
      {
         removeEvent();
         MainToolBar.instance.switchToolsBarState(4);
         ObjectUtils.disposeObject(_bottomIcon);
         _bottomIcon = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_bottomTagright);
         _bottomTagright = null;
         ObjectUtils.disposeObject(_bottomTagLeft);
         _bottomTagLeft = null;
         ObjectUtils.disposeObject(_bottomNextStepTxt);
         _bottomNextStepTxt = null;
         ObjectUtils.disposeObject(_bottomProTxt);
         _bottomProTxt = null;
         ObjectUtils.disposeObject(_bottomBtnBg);
         _bottomBtnBg = null;
         ObjectUtils.disposeObject(_bottomFreeTxt);
         _bottomFreeTxt = null;
         ObjectUtils.disposeObject(_matchBtn);
         _matchBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_jImg);
         _jImg = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_numBack);
         _numBack = null;
         ObjectUtils.disposeViolentMc(_macthMc);
         _macthMc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         model.matchState = 1;
         _seasonOverTimeDate = null;
         _matchOpenTimeDate = null;
         _matchEndTimeDate = null;
      }
   }
}

