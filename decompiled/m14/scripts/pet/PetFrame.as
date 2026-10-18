package pet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PetEvent;
   import farm.FarmManager;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.pet.PetData;
   import pet.compose.PetComposeView;
   import pet.list.PetListView;
   import pet.swallow.PetSwallowView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PetFrame extends Frame
   {
      
      private var _playerInfo:PlayerInfo;
      
      private var _farmInfo:FarmInfo;
      
      private var _bg:Scale9CornerImage;
      
      private var _shading:Bitmap;
      
      private var _shadingSprite:Sprite;
      
      private var _propertyBtn:SelectedIconButton;
      
      private var _advanceBtn:SelectedIconButton;
      
      private var _swallowBtn:SelectedIconButton;
      
      private var _strengthBtn:SelectedIconButton;
      
      private var _learnskillBtn:SelectedIconButton;
      
      private var _composeBtn:SelectedIconButton;
      
      private var _mixBtn:SelectedIconButton;
      
      private var _equipBtn:SelectedIconButton;
      
      private var _petListView:PetListView;
      
      private var _separateLine:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _currentSelectedBtn:SelectedIconButton;
      
      private var _currentPanelView:Component;
      
      private var _hBox:HBox;
      
      private var _buttonMc1:MovieClip;
      
      private var _openDefaultType:int = 0;
      
      private var _data:PetData;
      
      private var flag:Boolean = false;
      
      private var tempPet:PetData;
      
      public function PetFrame()
      {
         super();
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _farmInfo = FarmManager.instance.model.myFarm;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("pet.PetFrameBack");
         _shading = ComponentFactory.Instance.creatBitmap("asset.pet.Back");
         _shadingSprite = new Sprite();
         _shadingSprite.x = 170;
         _shadingSprite.y = 28;
         _shadingSprite.graphics.beginBitmapFill(_shading.bitmapData);
         _shadingSprite.graphics.lineStyle(0);
         _shadingSprite.graphics.drawRect(0,0,619,422);
         _shadingSprite.graphics.endFill();
         _separateLine = ComponentFactory.Instance.creatBitmap("asset.pet.SeparateLine01");
         addToContent(_bg);
         addToContent(_shadingSprite);
         addToContent(_separateLine);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("pet.hbox");
         _propertyBtn = ComponentFactory.Instance.creatComponentByStylename("pet.PropertyBtn");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("pet.AdvancedBtn");
         _swallowBtn = ComponentFactory.Instance.creatComponentByStylename("pet.SwallowBtn");
         _strengthBtn = ComponentFactory.Instance.creatComponentByStylename("pet.HandbookBtn");
         _learnskillBtn = ComponentFactory.Instance.creatComponentByStylename("pet.LearnskillBtn");
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.ComposeBtn");
         _mixBtn = ComponentFactory.Instance.creatComponentByStylename("pet.PetMixBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("pet.PetEquipBtn");
         _hBox.addChild(_propertyBtn);
         _hBox.addChild(_advanceBtn);
         _hBox.addChild(_strengthBtn);
         _hBox.addChild(_learnskillBtn);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.showVersion && thane.grades >= 60 && !getpetLvFlag())
         {
            _buttonMc1 = ComponentFactory.Instance.creatCustomObject("pet.composeBtnMc");
            _buttonMc1["pos"].addChild(_composeBtn);
            _buttonMc1.play();
            SharedManager.instance.sharePetComposeBtn = false;
            SharedManager.instance.saveSharePetComposeBtn();
            _hBox.addChild(_buttonMc1);
         }
         else
         {
            _hBox.addChild(_composeBtn);
         }
         _hBox.addChild(_mixBtn);
         _hBox.addChild(_equipBtn);
         addToContent(_hBox);
         _petListView = ComponentFactory.Instance.creatCustomObject("pet.PetListView");
         addToContent(_petListView);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("petFrame.helpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("petFrame.helpBtnTip");
         this.titleText = LanguageMgr.GetTranslation("pet.PetFrame.title");
      }
      
      private function getpetLvFlag() : Boolean
      {
         var _loc4_:PetData = null;
         var _loc3_:int = 0;
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         var _loc2_:int = int(_loc1_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            if(_loc4_.template.NeedGrade == 2)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function uintView() : void
      {
         _playerInfo = null;
         _data = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_shading);
         _shading = null;
         ObjectUtils.disposeObject(_shadingSprite);
         _shadingSprite = null;
         ObjectUtils.disposeObject(_separateLine);
         _separateLine = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_propertyBtn);
         _propertyBtn = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_swallowBtn);
         _swallowBtn = null;
         ObjectUtils.disposeObject(_strengthBtn);
         _strengthBtn = null;
         ObjectUtils.disposeObject(_learnskillBtn);
         _learnskillBtn = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_mixBtn);
         _mixBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_petListView);
         _petListView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_currentSelectedBtn);
         _currentSelectedBtn = null;
         ObjectUtils.disposeViolentMc(_buttonMc1);
         _buttonMc1 = null;
         currentPanelView = null;
      }
      
      private function addEvent() : void
      {
         _playerInfo.addEventListener("PET_ADD",__addPetHandler);
         _playerInfo.addEventListener("PET_REMOVE",__removePetHandler);
         _playerInfo.addEventListener("PET_UPDATE",__updatePetHandler);
         _playerInfo.addEventListener("PET_MAXCOUNT_CHANGE",__addPetHandler);
         if(_farmInfo)
         {
            _farmInfo.addEventListener("PET_LAND_OPEN",__updatePracticePetHandler);
            _farmInfo.addEventListener("PET_LAND_UPDATE",__updatePracticePetHandler);
         }
         _petListView.addEventListener("change",__petSelectedChangeHandler);
         _propertyBtn.addEventListener("click",__switchPanelHandler);
         _advanceBtn.addEventListener("click",__switchPanelHandler);
         _swallowBtn.addEventListener("click",__switchPanelHandler);
         _strengthBtn.addEventListener("click",__switchPanelHandler);
         _learnskillBtn.addEventListener("click",__switchPanelHandler);
         _composeBtn.addEventListener("click",__switchPanelHandler);
         _mixBtn.addEventListener("click",__switchPanelHandler);
         _equipBtn.addEventListener("click",__switchPanelHandler);
         this.addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__openHelperFrameHandler);
      }
      
      private function removeEvent() : void
      {
         if(_playerInfo)
         {
            _playerInfo.removeEventListener("PET_ADD",__addPetHandler);
            _playerInfo.removeEventListener("PET_REMOVE",__removePetHandler);
            _playerInfo.removeEventListener("PET_UPDATE",__updatePetHandler);
            _playerInfo.removeEventListener("PET_MAXCOUNT_CHANGE",__addPetHandler);
         }
         if(_farmInfo)
         {
            _farmInfo.removeEventListener("PET_LAND_OPEN",__updatePracticePetHandler);
            _farmInfo.removeEventListener("PET_LAND_UPDATE",__updatePracticePetHandler);
         }
         if(_propertyBtn)
         {
            _propertyBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_advanceBtn)
         {
            _advanceBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_swallowBtn)
         {
            _swallowBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_strengthBtn)
         {
            _strengthBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_learnskillBtn)
         {
            _learnskillBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_composeBtn)
         {
            _composeBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_mixBtn)
         {
            _mixBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_equipBtn)
         {
            _equipBtn.removeEventListener("click",__switchPanelHandler);
         }
         if(_petListView)
         {
            _petListView.removeEventListener("change",__petSelectedChangeHandler);
         }
         this.removeEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelperFrameHandler);
         }
      }
      
      private function setDefaultPanel() : void
      {
         switch(_openDefaultType)
         {
            case 0:
               _propertyBtn.selected = true;
               _currentSelectedBtn = _propertyBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 1:
               _advanceBtn.selected = true;
               _currentSelectedBtn = _advanceBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 2:
               _swallowBtn.selected = true;
               _currentSelectedBtn = _swallowBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 3:
               _strengthBtn.selected = true;
               _currentSelectedBtn = _strengthBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 4:
               _learnskillBtn.selected = true;
               _currentSelectedBtn = _learnskillBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 5:
               _composeBtn.selected = true;
               _currentSelectedBtn = _composeBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            case 6:
               _equipBtn.selected = true;
               _currentSelectedBtn = _equipBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
               break;
            default:
               _propertyBtn.selected = true;
               _currentSelectedBtn = _propertyBtn;
               _currentSelectedBtn.dispatchEvent(new MouseEvent("click"));
               _petListView.refresh();
         }
      }
      
      public function set openDefaultType(param1:int) : void
      {
         _openDefaultType = param1;
      }
      
      private function __addPetHandler(param1:PetEvent) : void
      {
         _petListView.refresh();
      }
      
      private function __removePetHandler(param1:PetEvent) : void
      {
         var _loc3_:PetSwallowView = null;
         var _loc2_:PetData = param1.data as PetData;
         if(currentPanelView is PetSwallowView)
         {
            _loc3_ = currentPanelView as PetSwallowView;
            if(_loc2_ == _loc3_.mainPet)
            {
               _loc3_.mainPet = null;
            }
            else if(_loc2_ == _loc3_.secondPet)
            {
               tempPet = _loc3_.mainPet;
               _loc3_.secondPet = null;
            }
            else
            {
               _petListView.refresh();
            }
         }
         else if(_loc2_ == currentPanelView["data"])
         {
            currentPanelView["data"] = null;
            if(currentPanelView is PetComposeView)
            {
               _petListView.selectedPet = null;
            }
            _petListView.refresh();
         }
         else
         {
            _petListView.refresh();
         }
      }
      
      private function __updatePracticePetHandler(param1:FarmEvent) : void
      {
         _petListView.refresh();
         refresh();
      }
      
      private function __updatePetHandler(param1:PetEvent) : void
      {
         _petListView.resetCurrentPageIndex();
         _petListView.refresh();
         if(this.data == param1.data)
         {
            this.data = param1.data as PetData;
         }
      }
      
      private function __petSelectedChangeHandler(param1:Event) : void
      {
         this.data = _petListView.selectedPet;
      }
      
      private function __switchPanelHandler(param1:MouseEvent) : void
      {
         var _loc7_:PetData = null;
         SoundManager.instance.play("022");
         var _loc5_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc6_:GoodsInfo in _loc5_)
         {
            PlayerManager.instance.moveBagToBag(_loc6_.bagType,_loc6_.objectId,_loc6_.pos,1,0,0,1);
         }
         tempPet = null;
         _propertyBtn.selected = false;
         _advanceBtn.selected = false;
         _swallowBtn.selected = false;
         _strengthBtn.selected = false;
         _learnskillBtn.selected = false;
         _composeBtn.selected = false;
         _mixBtn.selected = false;
         _equipBtn.selected = false;
         var _loc4_:SelectedIconButton = param1.currentTarget as SelectedIconButton;
         _loc4_.selected = true;
         if(_currentSelectedBtn == _loc4_ && flag)
         {
            return;
         }
         flag = true;
         if(currentPanelView)
         {
            if(_currentSelectedBtn == _swallowBtn)
            {
               _loc7_ = (currentPanelView as PetSwallowView).mainPet;
            }
            else
            {
               _loc7_ = currentPanelView["data"] as PetData;
            }
         }
         if(!_loc7_)
         {
            _loc7_ = _playerInfo.enterWarPet;
         }
         if(!_loc7_)
         {
            _loc7_ = _playerInfo.petList[0];
         }
         _petListView.dragEnable = false;
         _helpBtn.visible = true;
         switch(_loc4_)
         {
            case _propertyBtn:
               PetEquipManager.currSelectedPage = "PropertyView";
               _petListView.type = 0;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PropertyView");
               break;
            case _advanceBtn:
               PetEquipManager.currSelectedPage = "PetAdvancedView";
               _petListView.type = 0;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetAdvancedView");
               break;
            case _swallowBtn:
               PetEquipManager.currSelectedPage = "PetSwallowView";
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetSwallowView",[removePetCallBack]);
               _petListView.type = 1;
               _petListView.dragEnable = true;
               break;
            case _strengthBtn:
               PetEquipManager.currSelectedPage = "PetStrengthenView";
               _petListView.type = 0;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetStrengthenView");
               break;
            case _learnskillBtn:
               PetEquipManager.currSelectedPage = "PetLearnSkillView";
               _petListView.type = 2;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetLearnSkillView");
               break;
            case _composeBtn:
               _helpBtn.visible = false;
               PetEquipManager.currSelectedPage = "PetComposeView";
               _petListView.type = 3;
               _petListView.dragEnable = true;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetComposeView",[dragCallback]);
               _loc7_ = null;
               if(_buttonMc1)
               {
                  _buttonMc1.gotoAndStop(1);
               }
               break;
            case _mixBtn:
               PetEquipManager.currSelectedPage = "PetMixView";
               _petListView.type = 4;
               _petListView.dragEnable = true;
               currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.PetMixView",[dragCallback]);
               _loc7_ = null;
               break;
            case _equipBtn:
               if(!PetEquipManager.currSelectedPetData)
               {
                  PetEquipManager.currSelectedPetData = _loc7_;
               }
               if(PetEquipManager.currSelectedPage != "EquipStoreView")
               {
                  PetEquipManager.currSelectedPage = "EquipStoreView";
                  _petListView.type = 0;
                  _petListView.dragEnable = false;
                  currentPanelView = ComponentFactory.Instance.creatCustomObject("pet.EquipStoreView");
               }
         }
         _currentSelectedBtn = _loc4_;
         var _loc2_:Array = [];
         if(_swallowBtn == _loc4_)
         {
            if(_loc7_)
            {
               _loc2_.push(_loc7_);
            }
         }
         if(_mixBtn == _loc4_)
         {
            for each(var _loc3_:PetData in _playerInfo.petList)
            {
               if(_loc3_.template.PetType != 105 && _loc3_.template.PetType != 106 && _loc3_.template.PetType != 102 && _loc3_.template.PetType != 104 && _loc3_.template.PetType != 101 && _loc3_.template.PetType != 103)
               {
                  _loc2_.push(_loc3_);
               }
               else if(_loc3_.template.NeedGrade < 2)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         _petListView.grayPets = _loc2_;
         _petListView.selectedPet = _loc7_;
         _petListView.refresh();
      }
      
      private function removePetCallBack(param1:Array) : void
      {
         _petListView.grayPets = param1;
         _petListView.refresh();
      }
      
      private function dragCallback(param1:PetData) : void
      {
         _petListView.selectedPet = param1;
         _petListView.refresh();
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
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("008");
         switch(_currentSelectedBtn)
         {
            case _propertyBtn:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame1");
               break;
            case _advanceBtn:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame2");
               break;
            case _swallowBtn:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame3");
               break;
            case _strengthBtn:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame4");
               break;
            case _learnskillBtn:
               break;
            case _composeBtn:
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame6");
               break;
            case _mixBtn:
               break;
            case _equipBtn:
               if(PetEquipManager.currSelectedView == "PetEquipStrengView")
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame7_1");
               }
               else if(PetEquipManager.currSelectedView == "PetEquipRefineryView")
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame7_2");
               }
               else if(PetEquipManager.currSelectedView == "PetEquipGodHeadView")
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame7_3");
               }
               else if(PetEquipManager.currSelectedView == "PetEquipUpgradeView")
               {
                  _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PetFrame.HelpFrame7_4");
               }
         }
         if(_loc2_)
         {
            _loc2_.show();
         }
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:PetSwallowView = null;
         if(!currentPanelView)
         {
            return;
         }
         if(currentPanelView.hasOwnProperty("data"))
         {
            if(currentPanelView is PetSwallowView)
            {
               _loc1_ = currentPanelView as PetSwallowView;
               if(tempPet)
               {
                  _loc1_.mainPet = tempPet;
                  tempPet = null;
               }
               else
               {
                  _loc1_.data = _data;
               }
            }
            else
            {
               currentPanelView["data"] = _data;
            }
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1)
         {
            _openDefaultType = int(param1.frameData);
         }
         setDefaultPanel();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         var _loc2_:DisplayObject = null;
         if(isAddToPool)
         {
            if(this.parent)
            {
               this.parent.removeChild(this);
            }
            KeyBoardRegister.instance.keyEnable = true;
            _loc2_ = StageReferance.stage.focus as DisplayObject;
            if(_loc2_ && contains(_loc2_))
            {
               StageReferance.stage.focus = null;
            }
            ComponentFactory.Instance.preStylename = "";
            NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
            return;
         }
         PetEquipManager.currSelectedPetData = null;
         removeEvent();
         uintView();
         super.dispose();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
         _data = null;
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc3_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc3_.bagType,_loc3_.objectId,_loc3_.pos,1,0,0,1);
         }
      }
      
      public function get currentPanelView() : Component
      {
         return _currentPanelView;
      }
      
      public function set currentPanelView(param1:Component) : void
      {
         if(_currentPanelView == param1)
         {
            return;
         }
         if(_currentPanelView)
         {
            _currentPanelView.dispose();
         }
         _currentPanelView = param1;
         if(_currentPanelView)
         {
            addToContent(_currentPanelView);
            _currentPanelView.mouseEnabled = false;
         }
      }
   }
}

