package childarena
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ConfigInfoManager;
   import yishi.filter.UIFilter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildArenaRightView extends Component
   {
      
      public static const count:int = 5;
      
      private var guessText:FilterFrameText;
      
      private var warText:FilterFrameText;
      
      private var sortTitleText:FilterFrameText;
      
      private var guessSelfText:FilterFrameText;
      
      private var rewardContiner:Component;
      
      private var btnContiner:Component;
      
      private var lightMc:MovieClip;
      
      private var guessBtn:IconButton;
      
      private var alertText:FilterFrameText;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var costGold:int;
      
      public function ChildArenaRightView()
      {
         super();
         costGold = ConfigInfoManager.instance.getChildPvpBetGold();
         initView();
         initRewardAndBtn();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         guessText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.guessText");
         warText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.warText");
         sortTitleText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.sortTitleText");
         guessSelfText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.guessSelfText");
         rewardContiner = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.rewardContiner");
         btnContiner = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.btnContiner");
         guessBtn = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.guessBtn");
         lightMc = ComponentFactory.Instance.creatCustomObject("ChildArenaRightView.lightMc");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.alertText");
         addChild(guessText);
         addChild(warText);
         addChild(sortTitleText);
         addChild(guessSelfText);
         addChild(rewardContiner);
         addChild(btnContiner);
         addChild(lightMc);
         lightMc.gotoAndStop(1);
         addChild(guessBtn);
         addChild(alertText);
         sortTitleText.text = LanguageMgr.GetTranslation("ChildArenaRightView.sortTitleText.text");
         guessSelfText.text = LanguageMgr.GetTranslation("ChildArenaRightView.guessSelfText.text");
         alertText.text = LanguageMgr.GetTranslation("ChildArenaRightView.alertText.text");
      }
      
      private function initRewardAndBtn() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ChildArenaRewardItem = null;
         var _loc3_:SelectedIconButton = null;
         btnGroup = new SelectedButtonGroup();
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ChildArenaRightView.ChildArenaRewardItem",[_loc1_]);
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ChildArenaRightView.rankSelectBtn" + _loc1_);
            _loc2_.y = _loc1_ * 50;
            _loc3_.x = (_loc1_ - 1) % 3 * 85 + 5;
            _loc3_.y = int((_loc1_ - 1) / 3) * 30 + 5;
            rewardContiner.addChild(_loc2_);
            btnContiner.addChild(_loc3_);
            btnGroup.addSelectItem(_loc3_);
            _loc1_++;
         }
         btnGroup.selectIndex = arenaModel.guessIndex != -1 ? 4 - arenaModel.guessIndex : -1;
      }
      
      private function addEvent() : void
      {
         guessBtn.addEventListener("click",__guessClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(guessBtn)
         {
            guessBtn.removeEventListener("click",__guessClickHandler);
         }
      }
      
      private function __guessClickHandler(param1:MouseEvent) : void
      {
         if(arenaModel.curstate != 2 && arenaModel.curstate != 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.guess.stateAlert"));
            return;
         }
         if(btnGroup.selectIndex == -1)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildArenaSignFrame.guess.noSelectAlert"));
            return;
         }
         SimpleAlertHelper.instance.data = [__alertResponseHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("ChildArenaSignFrame.guess.Content",costGold);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function __alertResponseHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc3_ = 4 - btnGroup.selectIndex;
            _loc4_ = int(ChildArenaModel["GUESS_" + _loc3_]);
            ChildSender.requestChildArenaOp(7,_loc4_);
         }
      }
      
      public function refreshView() : void
      {
         guessText.htmlText = LanguageMgr.GetTranslation("ChildArenaRightView.guessText.text",arenaModel.childPvpTimeArr[2],arenaModel.childPvpTimeArr[3]);
         warText.htmlText = LanguageMgr.GetTranslation("ChildArenaRightView.warText.text",arenaModel.childPvpTimeArr[3],arenaModel.childPvpTimeArr[4]);
         if(isCanGuess())
         {
            btnContiner.filters = [];
            btnContiner.mouseChildren = true;
            guessBtn.enable = true;
            lightMc.gotoAndPlay(2);
            guessBtn.iconStyle = "asset.ChildArenaRightView.guessBtnText1";
            guessBtn.iconInnerRectString = "48,58,12,25,13";
         }
         else
         {
            btnContiner.filters = [UIFilter.getGrayFilter()];
            btnContiner.mouseChildren = false;
            guessBtn.enable = false;
            lightMc.gotoAndStop(1);
            if(arenaModel.guessIndex != -1)
            {
               guessBtn.iconStyle = "asset.ChildArenaRightView.guessBtnText2";
               guessBtn.iconInnerRectString = "36,73,12,25,13";
            }
            else
            {
               guessBtn.iconStyle = "asset.ChildArenaRightView.guessBtnText1";
               guessBtn.iconInnerRectString = "48,58,12,25,13";
            }
         }
      }
      
      private function isCanGuess() : Boolean
      {
         if((arenaModel.curstate == 2 || arenaModel.curstate == 3) && arenaModel.guessIndex == -1 && Boolean(arenaModel.isSign))
         {
            return true;
         }
         return false;
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(guessText);
         guessText = null;
         ObjectUtils.disposeObject(warText);
         warText = null;
         ObjectUtils.disposeObject(sortTitleText);
         sortTitleText = null;
         ObjectUtils.disposeObject(guessSelfText);
         guessSelfText = null;
         ObjectUtils.disposeObject(rewardContiner);
         rewardContiner = null;
         ObjectUtils.disposeObject(btnContiner);
         btnContiner = null;
         ObjectUtils.disposeObject(guessBtn);
         guessBtn = null;
         ObjectUtils.disposeViolentMc(lightMc);
         lightMc = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         btnGroup = null;
         super.dispose();
      }
   }
}

