package map.campaign.view.ui.monopoly
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import mvc.module.monopoly.MonopolyModel;
   import mvc.module.pet.PetData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class MonopolyTeamView extends Component
   {
      
      private var _bg:Image;
      
      private var _list:Array;
      
      private var _optipTxt:FilterFrameText;
      
      private var _adjustBtnMC:MovieClip;
      
      private var _adjustBtnQuickMC:QuickenMovieClip;
      
      private var _adjustBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _resetBtn:IconButton;
      
      private var _model:MonopolyModel;
      
      private var _playCount:int = 0;
      
      private var _playMax:int = 10;
      
      public function MonopolyTeamView()
      {
         super();
         _model = MonopolyManager.instance.model;
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc1_:MonopolyTeamItemView = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamItemView.bg");
         _optipTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamView.optipTxt");
         _adjustBtnMC = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyTeamView.adjustBtnMC");
         _adjustBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamView.adjustBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamView.helpBtn");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamView.resetBtn");
         _adjustBtnQuickMC = new QuickenMovieClip(_adjustBtnMC);
         _adjustBtnMC.gotoAndStop(1);
         _adjustBtnMC["pos"].addChild(_adjustBtn);
         addChild(_bg);
         addChild(_optipTxt);
         addChild(_adjustBtnQuickMC);
         addChild(_helpBtn);
         addChild(_resetBtn);
         _adjustBtnQuickMC.gotoAndStop(0);
         _adjustBtnQuickMC.addFrameScript(_adjustBtnQuickMC.totalFrames - 1,adjuctBtnQuickCallBack);
         _list = [];
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new MonopolyTeamItemView();
            addChild(_loc1_);
            _loc1_.y = 38 + _loc2_ * 55;
            _loc1_.x = 5;
            _list[_loc2_] = _loc1_;
            _loc2_++;
         }
         _optipTxt.text = LanguageMgr.GetTranslation("PetChallengeTeamView.optipTxt");
         if(_model.position == 1)
         {
            _adjustBtnQuickMC.gotoAndPlay(1);
         }
      }
      
      private function adjuctBtnQuickCallBack() : void
      {
         _playCount = _playCount + 1;
         if(_playCount >= 10)
         {
            _adjustBtnQuickMC.gotoAndStop(0);
         }
         else
         {
            _adjustBtnQuickMC.gotoAndPlay(1);
         }
      }
      
      private function uninitView() : void
      {
         var _loc1_:MonopolyTeamItemView = null;
         for each(_loc1_ in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_optipTxt);
         _optipTxt = null;
         ObjectUtils.disposeObject(_adjustBtnMC);
         _adjustBtnMC = null;
         ObjectUtils.disposeObject(_adjustBtnQuickMC);
         _adjustBtnQuickMC = null;
         ObjectUtils.disposeObject(_adjustBtn);
         _adjustBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _list = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
         _adjustBtn.addEventListener("click",__openFormationHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _resetBtn.addEventListener("click",__resetBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
         if(_adjustBtn)
         {
            _adjustBtn.removeEventListener("click",__openFormationHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         if(_resetBtn)
         {
            _resetBtn.removeEventListener("click",__resetBtnClickHandler);
         }
      }
      
      private function __petformationChangeHandler(param1:PlayerEvent) : void
      {
         refresh();
      }
      
      private function __openFormationHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.monopolyController.openFormationFrame();
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Frame = ComponentFactory.Instance.creatComponentByStylename("monopoly.HelpFrame");
         _loc2_["show"]();
      }
      
      private function __resetBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         if(_model.campaignCount == 0)
         {
            SimpleAlertHelper.instance.data = [resetBtnClickCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.prompt");
            _loc6_ = LanguageMgr.GetTranslation("MonopolyManager.ResetBtnClickTip02");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true);
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("MonopolyManager.ResetBtnClickTip01");
            MessageTipManager.instance().show(_loc4_);
         }
      }
      
      private function resetBtnClickCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            MonopolySocketOutManager.sendLeaveCampaign(0);
         }
      }
      
      public function refresh() : void
      {
         var _loc5_:PetData = null;
         var _loc3_:Array = [];
         for each(var _loc1_:String in playerInfo.petMonopolyFormationOfArray)
         {
            if(_loc1_)
            {
               _loc5_ = playerInfo.getPet(int(_loc1_));
               if(_loc5_)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         _loc3_.sortOn("fightPower",0x10 | 2);
         var _loc4_:int = 0;
         for each(var _loc2_:MonopolyTeamItemView in _list)
         {
            _loc2_.data = _loc3_[_loc4_];
            _loc4_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function get width() : Number
      {
         return 208;
      }
      
      override public function get height() : Number
      {
         return 193;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

