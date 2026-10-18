package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.data.PetLandInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.PetMovieClip;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmPetLandView extends Component
   {
      
      private var _pos:int = 0;
      
      private var _back:ScaleFrameImage;
      
      private var _hasOperEffect:MovieClip;
      
      private var _feedImg:Bitmap;
      
      private var _gainsImg:Bitmap;
      
      private var _filter:UIFilter;
      
      private var _petAvatar:PetMovieClip;
      
      private var _cancelBtn:IconButton;
      
      private var _effect:MovieClip;
      
      private var _clickTxt:GradientText;
      
      private var _tipView:FarmPetSelectMeun;
      
      private var _data:PetLandInfo;
      
      private var _loaderKey:int;
      
      public function FarmPetLandView(param1:int)
      {
         super();
         this._pos = param1;
         initView();
         addEvent();
         tipStyle = "yishi.view.tips.CropTip";
         tipDirctions = "0,1,2,3";
         tipGapV = 80;
         tipGapH = 0;
         isFollowMouse = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("farm.PetBottom");
         _back.setFrame(1);
         _hasOperEffect = ComponentFactory.Instance.creatCustomObject("farm.HasOperEffect");
         _hasOperEffect["hasOperBox"]["box"].gotoAndStop(2);
         _feedImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemFeedImg");
         _gainsImg = ComponentFactory.Instance.creatBitmap("asset.farm.FarmLandItemPickImg");
         _gainsImg.x = 2;
         _petAvatar = new PetMovieClip();
         _petAvatar.x = 0;
         _petAvatar.y = 13;
         addChild(_back);
         addChild(_petAvatar);
         _effect = ComponentFactory.Instance.creatCustomObject("farm.PetBottomEffect2");
         _effect.mouseChildren = _effect.mouseEnabled = false;
         _effect.gotoAndStop(1);
         _effect.visible = false;
         addChild(_effect);
         addChild(_hasOperEffect);
         _hasOperEffect.visible = false;
         _hasOperEffect.mouseChildren = _hasOperEffect.mouseEnabled = false;
         _hasOperEffect.x = 33;
         _hasOperEffect.y = -30;
         _filter = new UIFilter();
         _clickTxt = ComponentFactory.Instance.creatComponentByStylename("FarmPetLandView.ClickParticeTxt");
         _clickTxt.text = LanguageMgr.GetTranslation("FarmPetLandView.clickPartice");
         _clickTxt.visible = isSelfFarm() && Boolean(PlayerManager.instance.currentPlayerModel.petSystemIsOpened);
         addChild(_clickTxt);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("farm.CancelPetBtn");
         addChild(_cancelBtn);
         _cancelBtn.visible = false;
      }
      
      private function uintView() : void
      {
         if(_tipView)
         {
            _tipView.removeEventListener("dispose",__disposeListView);
            _tipView.dispose();
            _tipView = null;
         }
         if(_petAvatar)
         {
            _petAvatar.dispose();
            _petAvatar = null;
         }
         ObjectUtils.disposeObject(_feedImg);
         _feedImg = null;
         ObjectUtils.disposeObject(_gainsImg);
         _gainsImg = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_clickTxt);
         _clickTxt = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",_cancelBtnClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__clickHandler);
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",_cancelBtnClickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!buttonMode)
         {
            return;
         }
         if(param1.target == _cancelBtn)
         {
            return;
         }
         if(isSelfFarm())
         {
            if(!data)
            {
               selectPet(param1.stageX + 60,param1.stageY - 80);
               param1.stopImmediatePropagation();
            }
            else if(data.canGains())
            {
               gainsPet();
            }
            else if(data.canFeed())
            {
               feedPet();
            }
         }
         else if(data && data.canFeed())
         {
            feedPet();
         }
      }
      
      private function isSelfFarm() : Boolean
      {
         return FarmManager.instance.model.curSelectedFarmInfo == FarmManager.instance.model.myFarm;
      }
      
      private function gainsPet() : void
      {
         var _loc4_:int = int(data.userId);
         var _loc1_:int = 16;
         var _loc3_:int = this.pos;
         var _loc2_:int = int(data.petId);
         FarmManager.instance.sendFarmOper(_loc4_,_loc1_,_loc3_,_loc2_,0);
      }
      
      private function feedPet() : void
      {
         var _loc5_:int = int(data.userId);
         var _loc1_:int = 13;
         var _loc3_:int = this.pos;
         var _loc2_:int = int(data.petId);
         var _loc4_:int = 10;
         FarmManager.instance.sendFarmOper(_loc5_,_loc1_,_loc3_,_loc2_,_loc4_);
      }
      
      private function selectPet(param1:int, param2:int) : void
      {
         var _loc3_:String = null;
         if(_tipView)
         {
            _tipView.removeEventListener("dispose",__disposeListView);
            _tipView.dispose();
            _tipView = null;
            return;
         }
         if(ArmyManager.instance.thane.grades < 50)
         {
            _loc3_ = LanguageMgr.GetTranslation("FarmPetLandView.noOpen");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         if(petCount() == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         if(_data)
         {
            _loc4_ = int(data.petId);
         }
         _tipView = ComponentFactory.Instance.creatComponentByStylename("farm.FarmPetSelectMeun",[_loc4_,pos]);
         _tipView.show();
         _tipView.x = param1;
         _tipView.y = param2;
         _tipView.addEventListener("dispose",__disposeListView);
      }
      
      private function petCount() : int
      {
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         return _loc1_.length;
      }
      
      private function __disposeListView(param1:Event) : void
      {
         (param1.currentTarget as FarmPetSelectMeun).removeEventListener("dispose",__disposeListView);
         _tipView = null;
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         changeButtonMode();
         changeMouseCursor();
         var _loc2_:Boolean = isSelfFarm();
         if(buttonMode)
         {
            _filter.setLightingFilter(this);
         }
         if(_loc2_ && data)
         {
            if(_cancelBtn)
            {
               _cancelBtn.visible = true;
            }
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(this);
         if(_cancelBtn)
         {
            _cancelBtn.visible = false;
         }
         if(data)
         {
            CursorManagerII.instance.resetCursor();
         }
         buttonMode = false;
      }
      
      private function changeButtonMode() : void
      {
         var _loc2_:Boolean = isSelfFarm();
         var _loc1_:Boolean = Boolean(PlayerManager.instance.currentPlayerModel.petSystemIsOpened);
         buttonMode = false;
         if(_loc2_)
         {
            if(_data)
            {
               buttonMode = true;
            }
            else if(_loc1_)
            {
               buttonMode = true;
            }
            else
            {
               buttonMode = false;
            }
         }
         else if(_data && _data.canFeed())
         {
            buttonMode = true;
         }
         else
         {
            buttonMode = false;
         }
      }
      
      private function changeMouseCursor() : void
      {
         if(DragManager.getInstance().isDraging || Boolean(DoubleClickManager.Instance.isClicking))
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
         if(!data)
         {
            return;
         }
         if(data.canGains() && isSelfFarm())
         {
            CursorManagerII.instance.showCursorByType("FARM_PICK_CURSOR");
         }
         else if(data.canFeed())
         {
            CursorManagerII.instance.showCursorByType("FARM_FEED");
         }
      }
      
      private function _cancelBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("FarmPetLandView.cancelPet");
         SimpleAlertHelper.instance.data = [cancelBtnBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function cancelBtnBack(param1:Boolean, param2:Boolean) : void
      {
         if(!data)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         FarmManager.instance.sendFarmOper(data.userId,16,_pos,_data.petId,0);
      }
      
      public function get data() : PetLandInfo
      {
         return _data;
      }
      
      public function set data(param1:PetLandInfo) : void
      {
         _data = param1;
         if(param1 && param1.petId <= 0)
         {
            _data = null;
         }
         if(_data)
         {
            refresh();
            update();
         }
         else
         {
            _data = null;
            if(_petAvatar)
            {
               _petAvatar.stop();
               _petAvatar.clearAllFrames();
            }
            if(_cancelBtn)
            {
               _cancelBtn.visible = false;
            }
            if(_hasOperEffect)
            {
               _hasOperEffect.visible = false;
            }
            ShowTipManager.Instance.removeTip(this);
         }
         this.tipData = data;
         _effect.visible = false;
         _effect.stop();
         if(_data)
         {
            _effect.visible = true;
            _effect.play();
            _back.setFrame(3);
         }
         else if(isSelfFarm())
         {
            if(!PlayerManager.instance.currentPlayerModel.petSystemIsOpened)
            {
               _back.setFrame(1);
            }
            else
            {
               _back.setFrame(2);
            }
         }
         else
         {
            _back.setFrame(1);
         }
         if(!data && isSelfFarm() && Boolean(PlayerManager.instance.currentPlayerModel.petSystemIsOpened))
         {
            _clickTxt.visible = true;
         }
         else
         {
            _clickTxt.visible = false;
         }
      }
      
      private function refresh() : void
      {
         _petAvatar.play();
         _petAvatar.urlKey = _data.petTemplate.PetAvatar;
      }
      
      public function update() : void
      {
         if(!data)
         {
            return;
         }
         if(data.canGains() && isSelfFarm())
         {
            showGainsMovie();
         }
         else if(data.canFeed())
         {
            showFeedMovie();
         }
         else
         {
            _hasOperEffect.visible = false;
         }
      }
      
      private function showGainsMovie() : void
      {
         _hasOperEffect.visible = true;
         _hasOperEffect.gotoAndStop("hasOperEffect");
         if(_feedImg.parent)
         {
            _feedImg.parent.removeChild(_feedImg);
         }
         _hasOperEffect["hasOperBox"]["box"].addChild(_gainsImg);
         _hasOperEffect["hasOperBox"]["box"].gotoAndStop(2);
      }
      
      private function showFeedMovie() : void
      {
         _hasOperEffect.visible = true;
         _hasOperEffect.gotoAndStop("hasOperEffect");
         if(_gainsImg.parent)
         {
            _gainsImg.parent.removeChild(_gainsImg);
         }
         _hasOperEffect["hasOperBox"]["box"].addChild(_feedImg);
         _hasOperEffect["hasOperBox"]["box"].gotoAndStop(2);
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

