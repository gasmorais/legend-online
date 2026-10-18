package map.campaign.view.ui.emedream
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tools.QuickenMovieClip;
   
   public class EmeDreamTeamView extends Component
   {
      
      private static var isManualShrinked:Boolean = false;
      
      private var _bg:Image;
      
      private var _list:Array;
      
      private var _optipTxt:FilterFrameText;
      
      private var _adjustBtnMC:MovieClip;
      
      private var _adjustBtnQuickMC:QuickenMovieClip;
      
      private var _adjustBtn:TextButton;
      
      private var _helpBtn:TextButton;
      
      private var _finalStretchBg:Image;
      
      private var _finalShrinkBg:Image;
      
      private var _finalTeamBtn:IconButton;
      
      private var _finalTeamArrowImg:Image;
      
      private var _isFullPetMembers:Boolean;
      
      private var _playCount:int = 0;
      
      private var _playMax:int = 10;
      
      private var isTeamViewStretched:Boolean = true;
      
      public function EmeDreamTeamView()
      {
         super();
         initView();
         addEvent();
         refresh();
      }
      
      private function initView() : void
      {
         var _loc1_:EmeDreamTeamItemView = null;
         var _loc4_:int = 0;
         _optipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaBossTeamView.optipTxt");
         _adjustBtnMC = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyTeamView.adjustBtnMC");
         _adjustBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaBossTeamView.adjustBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaBossTeamView.helpBtn");
         _adjustBtnQuickMC = new QuickenMovieClip(_adjustBtnMC);
         _finalStretchBg = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsTeamView.finalStretchBg");
         _finalShrinkBg = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsTeamView.finalShrinkBg");
         _finalTeamBtn = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsTeamView.finalTeamBtn");
         _finalTeamArrowImg = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsTeamView.finalTeamArrmorImg");
         addChild(_finalStretchBg);
         addChild(_finalShrinkBg);
         addChild(_finalTeamBtn);
         addChild(_finalTeamArrowImg);
         addChild(_optipTxt);
         addChild(_adjustBtnQuickMC);
         addChild(_helpBtn);
         _finalTeamBtn.addChild(_finalTeamArrowImg);
         _adjustBtnMC.gotoAndStop(1);
         _adjustBtnMC["pos"].addChild(_adjustBtn);
         _adjustBtnQuickMC.gotoAndStop(0);
         _adjustBtnQuickMC.addFrameScript(_adjustBtnQuickMC.totalFrames - 1,adjuctBtnQuickCallBack);
         _finalStretchBg.y = 20;
         _finalShrinkBg.y = 20;
         _finalShrinkBg.visible = false;
         _finalTeamBtn.y += 20;
         _list = [];
         _loc4_ = 0;
         while(_loc4_ < 2)
         {
            _loc1_ = new EmeDreamTeamItemView();
            addChild(_loc1_);
            _loc1_.y = 25 + _loc4_ * 55;
            _loc1_.x = 5;
            _list[_loc4_] = _loc1_;
            _loc4_++;
         }
         _adjustBtn.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.AllocateView.sort");
         _helpBtn.text = LanguageMgr.GetTranslation("public.help");
         _optipTxt.text = LanguageMgr.GetTranslation("PetChallengeTeamView.optipTxt");
         checkIsFullPetMembers();
         if(isManualShrinked)
         {
            for each(var _loc3_:EmeDreamTeamItemView in _list)
            {
               _loc3_.hideSkillItems();
            }
            _finalTeamBtn.x = 70;
            _finalTeamBtn.y = 72;
            _finalStretchBg.visible = false;
            _finalShrinkBg.visible = true;
            _optipTxt.visible = false;
            _list[0].y = 47;
            _list[1].y = 102;
            isTeamViewStretched = false;
         }
         else if(!_isFullPetMembers)
         {
            for each(var _loc2_:EmeDreamTeamItemView in _list)
            {
               _loc2_.showSkillItems();
            }
            _finalTeamBtn.x = 342;
            _finalTeamBtn.y = 72;
            _finalTeamArrowImg.scaleX = -1;
            _finalTeamArrowImg.x = _finalTeamArrowImg.width - _finalTeamArrowImg.x;
            _finalShrinkBg.visible = false;
            _finalStretchBg.visible = true;
            _optipTxt.visible = true;
            _list[0].y = 25;
            _list[1].y = 80;
            isTeamViewStretched = true;
         }
         else
         {
            for each(var _loc5_:EmeDreamTeamItemView in _list)
            {
               _loc5_.hideSkillItems();
            }
            _finalTeamBtn.x = 70;
            _finalTeamBtn.y = 72;
            _finalStretchBg.visible = false;
            _finalShrinkBg.visible = true;
            _optipTxt.visible = false;
            _list[0].y = 47;
            _list[1].y = 102;
            isTeamViewStretched = false;
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
         var _loc1_:EmeDreamTeamItemView = null;
         for each(_loc1_ in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_optipTxt);
         _optipTxt = null;
         ObjectUtils.disposeViolentMc(_adjustBtnMC);
         _adjustBtnMC = null;
         ObjectUtils.disposeObject(_adjustBtnQuickMC);
         _adjustBtnQuickMC = null;
         ObjectUtils.disposeObject(_adjustBtn);
         _adjustBtn = null;
         ObjectUtils.disposeObject(_finalStretchBg);
         _finalStretchBg = null;
         ObjectUtils.disposeObject(_finalShrinkBg);
         _finalShrinkBg = null;
         ObjectUtils.disposeObject(_finalTeamBtn);
         _finalTeamBtn = null;
         ObjectUtils.disposeObject(_finalTeamArrowImg);
         _finalTeamArrowImg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _list = null;
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("PLAYER_PET_LIST_CHANGE",__petformationChangeHandler);
         _adjustBtn.addEventListener("click",__openFormationHandler);
         _helpBtn.addEventListener("click",__onHelperBtnClick);
         _finalTeamBtn.addEventListener("click",__finalTeamViewChangeHandler);
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
            _helpBtn.removeEventListener("click",__onHelperBtnClick);
         }
         if(_finalTeamBtn)
         {
            _finalTeamBtn.removeEventListener("click",__finalTeamViewChangeHandler);
         }
      }
      
      private function __petformationChangeHandler(param1:PlayerEvent) : void
      {
         refresh();
      }
      
      private function __openFormationHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL,3);
      }
      
      private function __finalTeamViewChangeHandler(param1:MouseEvent) : void
      {
         if(isTeamViewStretched)
         {
            for each(var _loc3_:EmeDreamTeamItemView in _list)
            {
               _loc3_.hideSkillItems();
            }
            _finalTeamBtn.x = 70;
            _finalTeamBtn.y = 72;
            _finalTeamArrowImg.scaleX = 1;
            _finalTeamArrowImg.x = _finalTeamArrowImg.width - _finalTeamArrowImg.x;
            _finalStretchBg.visible = false;
            _finalShrinkBg.visible = true;
            _optipTxt.visible = false;
            _list[0].y = 47;
            _list[1].y = 102;
            isManualShrinked = true;
         }
         else
         {
            for each(var _loc2_:EmeDreamTeamItemView in _list)
            {
               _loc2_.showSkillItems();
            }
            _finalTeamBtn.x = 342;
            _finalTeamBtn.y = 72;
            _finalTeamArrowImg.scaleX = -1;
            _finalTeamArrowImg.x = _finalTeamArrowImg.width + _finalTeamArrowImg.x;
            _finalShrinkBg.visible = false;
            _finalStretchBg.visible = true;
            _optipTxt.visible = true;
            _list[0].y = 25;
            _list[1].y = 80;
         }
         isTeamViewStretched = !isTeamViewStretched;
      }
      
      public function refresh() : void
      {
         var _loc5_:PetData = null;
         var _loc3_:Array = [];
         for each(var _loc1_:String in playerInfo.petConsortiaBossFormationOfArray)
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
         for each(var _loc2_:EmeDreamTeamItemView in _list)
         {
            _loc2_.data = _loc3_[_loc4_];
            _loc4_++;
         }
      }
      
      private function checkIsFullPetMembers() : void
      {
         var _loc3_:PetData = null;
         var _loc2_:Array = [];
         for each(var _loc1_:String in playerInfo.petConsortiaBossFormationOfArray)
         {
            if(_loc1_)
            {
               _loc3_ = playerInfo.getPet(int(_loc1_));
               if(_loc3_)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         if(_loc2_.length < 2)
         {
            _isFullPetMembers = false;
         }
         else
         {
            _isFullPetMembers = true;
         }
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaBossHelperFrame");
         _loc2_.show();
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

