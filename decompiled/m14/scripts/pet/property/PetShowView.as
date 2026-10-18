package pet.property
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import farm.data.PetLandInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mainBar.vicePassword.VicePasswordUtil;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.MonopolySocketOutManager;
   import managers.PetEquipManager;
   import managers.PetSocketOut;
   import mvc.module.children.ChildModel;
   import mvc.module.pet.PetData;
   import pet.advanced.equipbag.PetEquipCell;
   import yishi.GlobalConfig;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.ConfirmSellFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetShowView extends Component
   {
      
      private var _back:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _showContainer:Sprite;
      
      private var _nameTxt:FilterFrameText;
      
      private var _carryTxt:FilterFrameText;
      
      private var _needGradeTxt:FilterFrameText;
      
      private var _powerLabel:FilterFrameText;
      
      private var _powerTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _petType:ScaleFrameImage;
      
      private var _levelFlag:Bitmap;
      
      private var _petSamllAvatar:DisplayObject;
      
      private var _changeBtn:TextButton;
      
      private var _sacrificeBtn:TextButton;
      
      private var _setEnterWarBtn:TextButton;
      
      private var _heroWarBtn:TextButton;
      
      private var _childWarBtn:TextButton;
      
      private var _slavedChildWarBtn:TextButton;
      
      private var _resetBtn:TextButton;
      
      private var _priorityBtn:TextButton;
      
      private var _cancelPracticeBtn:TextButton;
      
      private var _petTypeList:Array;
      
      private var _btnVpLock:IconButton;
      
      private var _hBox:HBox;
      
      private var _equipBg:MovieImage;
      
      private var _equipList:Vector.<PetEquipCell>;
      
      private var _equipDic:Dictionary;
      
      private var _isSelf:Boolean = true;
      
      private var renameView:PetRenameView;
      
      private var _data:PetData;
      
      private var _loaderKey:String;
      
      private var _state:int = 0;
      
      public function PetShowView()
      {
         super();
         var _loc1_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         _petTypeList = _loc1_.split("|");
         initView();
         mouseEnabled = false;
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         if(_isSelf != param1)
         {
            _isSelf = param1;
            refreshEquipView(null);
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("pet.ShowViewBack");
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.PetBg");
         _showContainer = new Sprite();
         _showContainer.x = 159;
         _showContainer.y = 223;
         _showContainer.mouseChildren = _showContainer.mouseEnabled = false;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PetNameTxt");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.ChangeBtn");
         _carryTxt = ComponentFactory.Instance.creatComponentByStylename("pet.CarrayLabelTxt");
         _needGradeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.NeedGradeTxt");
         _powerLabel = ComponentFactory.Instance.creatComponentByStylename("pet.PowerLabelTxt");
         _powerTxt = ComponentFactory.Instance.creatComponentByStylename("pet.PowerTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.GradeTxt");
         _petType = ComponentFactory.Instance.creatComponentByStylename("pet.PetTypeImage");
         _levelFlag = ComponentFactory.Instance.creatBitmap("asset.pet.LevelFlag");
         _sacrificeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.SacrificeButton");
         _setEnterWarBtn = ComponentFactory.Instance.creatComponentByStylename("PetShowView.setEnterWarBtn");
         _heroWarBtn = ComponentFactory.Instance.creatComponentByStylename("PetShowView.heroWarBtn");
         _childWarBtn = ComponentFactory.Instance.creatComponentByStylename("PetShowView.childWarBtn");
         _slavedChildWarBtn = ComponentFactory.Instance.creatComponentByStylename("PetShowView.slavedChildWarBtn");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("PetShowView.resetBtn");
         _priorityBtn = ComponentFactory.Instance.creatComponentByStylename("pet.priorityBtn");
         _cancelPracticeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.CancelPracticeButton");
         _equipBg = ComponentFactory.Instance.creatComponentByStylename("petPro.equipBack");
         _hBox = new HBox();
         _hBox.spacing = 0;
         addChild(_back);
         addChild(_bg);
         addChild(_showContainer);
         addChild(_nameTxt);
         addChild(_changeBtn);
         addChild(_needGradeTxt);
         addChild(_powerLabel);
         addChild(_powerTxt);
         addChild(_gradeTxt);
         addChild(_levelFlag);
         addChild(_petType);
         addChild(_priorityBtn);
         addChild(_sacrificeBtn);
         addChild(_cancelPracticeBtn);
         addChild(_equipBg);
         addChild(_hBox);
         _hBox.x = 8;
         _hBox.y = 47;
         creatEquipView();
         addChild(_setEnterWarBtn);
         addChild(_heroWarBtn);
         addChild(_childWarBtn);
         addChild(_slavedChildWarBtn);
         addChild(_resetBtn);
         _petType.visible = false;
         _equipBg.visible = false;
         _cancelPracticeBtn.visible = false;
         _changeBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionItem.change");
         _carryTxt.text = LanguageMgr.GetTranslation("public.colon",LanguageMgr.GetTranslation("pet.PetFrame.carryGrade"));
         _powerLabel.text = LanguageMgr.GetTranslation("public.colon",LanguageMgr.GetTranslation("public.playerInfo.ap"));
         _sacrificeBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.sacrifice");
         _setEnterWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.setEnterWarBtn.text");
         _heroWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.heroWarBtn.text");
         _childWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.childWarBtn.text");
         _slavedChildWarBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.slavedChildWarBtn.text");
         _resetBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.unenterWar");
         _cancelPracticeBtn.text = LanguageMgr.GetTranslation("pet.PetFrame.cancelPractice");
         _priorityBtn.text = LanguageMgr.GetTranslation("pet.property.PetShowView.priority");
         _priorityBtn.tipData = LanguageMgr.GetTranslation("pet.property.PetShowView.TipTxt05");
         _cancelPracticeBtn.tipData = LanguageMgr.GetTranslation("pet.property.PetShowView.TipTxt04");
         _btnVpLock = ComponentFactory.Instance.creatComponentByStylename("PetFrame.lockbtn");
         this.addChild(_btnVpLock);
         _btnVpLock.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.vicepasswordBtnTipData");
      }
      
      private function __vpLockHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(playerInfo.isDuringResetTime)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description1");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(playerInfo.hasVicePassword == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("vicepassword",1);
         }
         else
         {
            SoundManager.instance.play("022");
            param1.stopPropagation();
            param1.stopImmediatePropagation();
            if(GlobalConfig.isConfirmPassword)
            {
               VicePasswordUtil.vpLockOp(2,0,_data.petId);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("vicepassword",3);
            }
         }
      }
      
      private function refreshBtnView() : void
      {
         if(!data || state == 3)
         {
            return;
         }
         showEnterWarMenu(false);
         if(state == 1 || state == 2)
         {
            _priorityBtn.visible = false;
            _sacrificeBtn.visible = false;
            _setEnterWarBtn.visible = false;
         }
         else
         {
            _sacrificeBtn.visible = true;
            _setEnterWarBtn.visible = true;
            _cancelPracticeBtn.visible = false;
            _priorityBtn.enable = data.thaneInfo.petList[0] != _data;
         }
      }
      
      private function creatEquipView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetEquipCell = null;
         _equipList = new Vector.<PetEquipCell>();
         _equipDic = new Dictionary(true);
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("pet.petEquip0" + _loc2_);
            if(_loc2_ < 3)
            {
               _loc1_.sonType = 113;
            }
            else if(_loc2_ == 3)
            {
               _loc1_.sonType = 114;
            }
            else if(_loc2_ > 3 && _loc2_ < 6)
            {
               _loc1_.sonType = 115;
            }
            else if(_loc2_ == 6)
            {
               _loc1_.sonType = 116;
            }
            addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc2_++;
         }
         refreshEquipView();
      }
      
      private function refreshEquipView(param1:Event = null) : void
      {
         var _loc8_:int = 0;
         var _loc5_:PetEquipCell = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:PetEquipCell = null;
         var _loc9_:int = 0;
         var _loc3_:PetEquipCell = null;
         if(!_data)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < _equipList.length)
         {
            _loc5_ = _equipList[_loc8_];
            _loc5_.canDrag = state != 3;
            _loc5_.data = null;
            _loc8_++;
         }
         if(_isSelf)
         {
            _loc2_ = GoodsManager.instance.getPetEquipListById(_data.petId);
         }
         else
         {
            _loc2_ = _data.equipList;
         }
         for each(var _loc4_:GoodsInfo in _loc2_)
         {
            _loc6_ = int(_loc4_.pos);
            _loc7_ = _equipList[_loc6_] as PetEquipCell;
            if(_loc7_)
            {
               _loc7_.canDrag = state != 3;
               _loc7_.data = _loc4_;
            }
         }
         if(state == 1 || state == 2)
         {
            _loc9_ = 0;
            while(_loc9_ < _equipList.length)
            {
               _loc3_ = _equipList[_loc9_] as PetEquipCell;
               _loc3_.visible = false;
               _loc9_++;
            }
         }
      }
      
      private function __dropStartHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:PetEquipCell = null;
         var _loc3_:GoodsInfo = param1.data;
         if(_loc3_)
         {
            _loc2_ = GoodsSonType.getSonTypePos(_loc3_.templateInfo.SonType);
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc6_ = 0;
               while(_loc6_ < _equipList.length)
               {
                  _loc4_ = _equipList[_loc6_] as PetEquipCell;
                  if(_loc4_ && _loc4_.pos == _loc2_[_loc5_])
                  {
                     _loc4_.setSelectedEff();
                  }
                  _loc6_++;
               }
               _loc5_++;
            }
         }
      }
      
      private function __dropOverHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PetEquipCell = null;
         _loc3_ = 0;
         while(_loc3_ < _equipList.length)
         {
            _loc2_ = _equipList[_loc3_] as PetEquipCell;
            _loc2_.setNotSelectedEff();
            _loc3_++;
         }
      }
      
      private function uintView() : void
      {
         clearLoaders();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_showContainer);
         _showContainer = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_carryTxt);
         _carryTxt = null;
         ObjectUtils.disposeObject(_needGradeTxt);
         _needGradeTxt = null;
         ObjectUtils.disposeObject(_powerLabel);
         _powerLabel = null;
         ObjectUtils.disposeObject(_powerTxt);
         _powerTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_petType);
         _petType = null;
         ObjectUtils.disposeObject(_levelFlag);
         _levelFlag = null;
         ObjectUtils.disposeObject(_petSamllAvatar);
         _petSamllAvatar = null;
         ObjectUtils.disposeObject(_sacrificeBtn);
         _sacrificeBtn = null;
         ObjectUtils.disposeObject(_setEnterWarBtn);
         _setEnterWarBtn = null;
         ObjectUtils.disposeObject(_heroWarBtn);
         _heroWarBtn = null;
         ObjectUtils.disposeObject(_childWarBtn);
         _childWarBtn = null;
         ObjectUtils.disposeObject(_slavedChildWarBtn);
         _slavedChildWarBtn = null;
         ObjectUtils.disposeObject(_cancelPracticeBtn);
         _cancelPracticeBtn = null;
         ObjectUtils.disposeObject(_priorityBtn);
         _priorityBtn = null;
         ObjectUtils.disposeObject(_equipBg);
         _equipBg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(_btnVpLock)
         {
            ObjectUtils.disposeObject(_btnVpLock);
            _btnVpLock = null;
         }
         if(renameView)
         {
            renameView.dispose();
            renameView = null;
         }
      }
      
      private function addEvent() : void
      {
         switch(state)
         {
            case 0:
               _changeBtn.addEventListener("click",__changeHandler);
               _sacrificeBtn.addEventListener("click",__sacrificeBtnClickHandler);
               _setEnterWarBtn.addEventListener("click",__enterWarBtnClickHandler);
               _heroWarBtn.addEventListener("click",__enterWarBtnClickHandler);
               _childWarBtn.addEventListener("click",__enterWarBtnClickHandler);
               _slavedChildWarBtn.addEventListener("click",__enterWarBtnClickHandler);
               _resetBtn.addEventListener("click",__enterWarBtnClickHandler);
               _cancelPracticeBtn.addEventListener("click",__cancelPracticeBtnClickHandler);
               _priorityBtn.addEventListener("click",__priorityHandler);
               GoodsManager.instance.addEventListener("UPDATE_BAG",refreshEquipView);
               GoodsManager.instance.addEventListener("DELETE_BAG",refreshEquipView);
               NotificationManager.instance.addEventListener("PETEQUIPDROPSTART",__dropStartHandler);
               NotificationManager.instance.addEventListener("PETEQUIPDROPOVER",__dropOverHandler);
            case 1:
            case 2:
               _btnVpLock.addEventListener("click",__vpLockHandler);
               break;
            case 3:
         }
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",__changeHandler);
         }
         if(_sacrificeBtn)
         {
            _sacrificeBtn.removeEventListener("click",__sacrificeBtnClickHandler);
         }
         if(_setEnterWarBtn)
         {
            _setEnterWarBtn.removeEventListener("click",__enterWarBtnClickHandler);
         }
         if(_heroWarBtn)
         {
            _heroWarBtn.removeEventListener("click",__enterWarBtnClickHandler);
         }
         if(_childWarBtn)
         {
            _childWarBtn.removeEventListener("click",__enterWarBtnClickHandler);
         }
         if(_slavedChildWarBtn)
         {
            _slavedChildWarBtn.removeEventListener("click",__enterWarBtnClickHandler);
         }
         if(_resetBtn)
         {
            _resetBtn.removeEventListener("click",__enterWarBtnClickHandler);
         }
         if(_cancelPracticeBtn)
         {
            _cancelPracticeBtn.removeEventListener("click",__cancelPracticeBtnClickHandler);
         }
         if(_priorityBtn)
         {
            _priorityBtn.removeEventListener("click",__priorityHandler);
         }
         if(_btnVpLock)
         {
            _btnVpLock.removeEventListener("click",__vpLockHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",refreshEquipView);
         GoodsManager.instance.removeEventListener("DELETE_BAG",refreshEquipView);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPSTART",__dropStartHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPOVER",__dropOverHandler);
      }
      
      private function __changeHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(renameView)
         {
            renameView.dispose();
            renameView = null;
         }
         renameView = ComponentFactory.Instance.creatComponentByStylename("pet.PetRenameFrame");
         renameView.data = data;
         renameView.show();
      }
      
      private function __sacrificeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         if(data.isLock)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description3");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(data.isPractice)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPractice");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(data.isEnterWar)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetShowView.checkEnterWarForSacrifice");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(data.isChildWar != 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetShowView.checkEnterChildForSacrifice.alert");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(playerInfo.petChallengeFormationOfArray.indexOf(data.petId + "") >= 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPetChanglle");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(data.isRemote)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inRemotePet");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:Array = GoodsManager.instance.getPetEquipListById(data.petId);
         if(_loc3_.length > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.inPetChanglle4");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(data.quality < 3)
         {
            if(data.isDefenser)
            {
               checkDefenserForSacrifice();
               return;
            }
            checkSacrifice();
         }
         else
         {
            checkSacrificeYes();
         }
      }
      
      private function updateToPlayerInfo(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         playerInfo.beginChanges();
         _loc2_ = int(playerInfo.petMonopolyFormationOfArray.indexOf(param1.toString()));
         if(_loc2_ != -1)
         {
            playerInfo.petMonopolyFormationOfArray[_loc2_] = -1;
            _loc3_ = playerInfo.petMonopolyFormationOfArray.join(",");
            playerInfo.petMonopolyFormation = _loc3_;
            MonopolySocketOutManager.sendPetFormation(_loc3_);
         }
         playerInfo.commit();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function checkDefenserForSacrifice() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("PetShowView.state1");
         var _loc5_:String = LanguageMgr.GetTranslation("PetShowView.inGuard",_loc3_);
         _loc5_ = _loc5_ + ("<br/>" + getSacrificeTip());
         SimpleAlertHelper.instance.data = [checkSacrificeBack,data];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function checkSacrifice() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = getSacrificeTip();
         SimpleAlertHelper.instance.data = [checkSacrificeBack,data];
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,true,2,"SIMPLE_ALERT",0,"",null);
      }
      
      private function checkSacrificeBack(param1:Boolean, param2:Boolean, param3:PetData) : void
      {
         if(isDie)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         if(param1)
         {
            updateToPlayerInfo(param3.petId);
            PetSocketOut.sacrifice(param3.petId);
         }
      }
      
      private function checkSacrificeYes() : void
      {
         var _loc2_:ConfirmSellFrame = ComponentFactory.Instance.creatComponentByStylename("core.ConfirmSellFrame");
         var _loc1_:String = getStarHtmlName(data.name,data.quality) + "\n" + getSacrificeTip() + "\n" + LanguageMgr.GetTranslation("PetShowView.yestip");
         _loc2_.show(_loc1_,data,checkSacrificeYesBack);
      }
      
      public function getStarHtmlName(param1:String, param2:int) : String
      {
         var _loc4_:Array = ["#ffffff","#999999","#59cd41","#32a2f8","#c300ff","#ff8000","#ce0f0f","#ce0f0f"];
         var _loc3_:String = _loc4_[param2];
         if(!_loc3_)
         {
            _loc3_ = _loc4_[0];
         }
         return LanguageMgr.GetTranslation("PetShowView.tempTxt",_loc3_,param1);
      }
      
      private function checkSacrificeYesBack(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         if(isDie)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         if(param1)
         {
            updateToPlayerInfo(param3.petId);
            PetSocketOut.sacrifice(param3.petId);
         }
      }
      
      private function getSacrificeTip() : String
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         if(_data.quality <= 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetShowView.sacrificeBtnTip2","1-2");
         }
         else if(_data.quality == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetShowView.sacrificeBtnTip2","2-3");
         }
         else
         {
            _loc1_ = Math.pow(_data.quality - 1,4);
            if(_data.quality >= 6)
            {
               _loc2_ = LanguageMgr.GetTranslation("PetShowView.sacrificeBtnTip3",_loc1_);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("PetShowView.sacrificeBtnTip",_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function __enterWarBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         param1.stopPropagation();
         if(!data)
         {
            return;
         }
         var _loc2_:String = "";
         var _loc3_:int = int(ArmyManager.instance.thane.grades);
         if(data.template && _loc3_ < data.template.NeedGrade)
         {
            _loc2_ = LanguageMgr.GetTranslation("PetShowView.needPlayerGrade",data.template.NeedGrade);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!data.isBind)
         {
            checkBind();
            return;
         }
         if(param1.currentTarget == _setEnterWarBtn)
         {
            showEnterWarMenu(!_heroWarBtn.visible);
         }
         else if(param1.currentTarget == _heroWarBtn)
         {
            showEnterWarMenu(false);
            updateToPlayerInfo(data.petId);
            PetSocketOut.enterWar(data.petId);
         }
         else if(param1.currentTarget == _childWarBtn)
         {
            showEnterWarMenu(false);
            updateToPlayerInfo(data.petId);
            PetSocketOut.enterChildPet(data.petId,1);
         }
         else if(param1.currentTarget == _slavedChildWarBtn)
         {
            showEnterWarMenu(false);
            updateToPlayerInfo(data.petId);
            PetSocketOut.enterChildPet(data.petId,2);
         }
         else if(param1.currentTarget == _resetBtn)
         {
            showEnterWarMenu(false);
            if(_data.isEnterWar)
            {
               PetSocketOut.rest(data.petId);
            }
            else if(_data.isChildWar != 0)
            {
               PetSocketOut.restChildPet(data.petId);
            }
         }
      }
      
      private function showEnterWarMenu(param1:Boolean) : void
      {
         _heroWarBtn.visible = param1;
         _childWarBtn.visible = param1;
         _slavedChildWarBtn.visible = param1;
         _resetBtn.visible = param1;
         if(_data.isEnterWar)
         {
            _heroWarBtn.enable = false;
            _childWarBtn.enable = true;
            _slavedChildWarBtn.enable = true;
            _resetBtn.enable = true;
         }
         else if(_data.isChildWar == 1)
         {
            _heroWarBtn.enable = true;
            _childWarBtn.enable = false;
            _slavedChildWarBtn.enable = true;
            _resetBtn.enable = true;
         }
         else if(_data.isChildWar == 2)
         {
            _heroWarBtn.enable = true;
            _childWarBtn.enable = true;
            _slavedChildWarBtn.enable = false;
            _resetBtn.enable = true;
         }
         else
         {
            _heroWarBtn.enable = true;
            _childWarBtn.enable = true;
            _slavedChildWarBtn.enable = true;
            _resetBtn.enable = false;
         }
         if(!childModel.getEnterWar())
         {
            _childWarBtn.enable = false;
         }
         if(!childModel.getSlavedEnterWar())
         {
            _slavedChildWarBtn.enable = false;
         }
         if(ArmyManager.instance.thane.grades < 70)
         {
            _childWarBtn.enable = false;
            _slavedChildWarBtn.enable = false;
         }
      }
      
      private function __cancelPracticeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!data)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("FarmPetLandView.cancelPet");
         SimpleAlertHelper.instance.data = [cancelBtnBack,data];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function cancelBtnBack(param1:Boolean, param2:Boolean, param3:PetData) : void
      {
         if(!param3)
         {
            return;
         }
         if(!param1)
         {
            return;
         }
         var _loc5_:Array = FarmManager.instance.model.myFarm.getPetLandList();
         for each(var _loc4_:PetLandInfo in _loc5_)
         {
            if(_loc4_.petId == param3.petId)
            {
               FarmManager.instance.sendFarmOper(param3.userId,16,_loc4_.pos,_loc4_.petId,0);
               return;
            }
         }
      }
      
      private function checkBind() : void
      {
         checkBindBack(true,true,data);
      }
      
      private function checkBindBack(param1:Boolean, param2:Boolean, param3:PetData) : void
      {
         if(isDie)
         {
            return;
         }
         if(!param3)
         {
            return;
         }
         if(param1)
         {
            updateToPlayerInfo(param3.petId);
            PetSocketOut.enterWar(param3.petId);
         }
      }
      
      private function __priorityHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data)
         {
            PetSocketOut.shiftToTop(_data.petId);
            _data.thaneInfo.addPet(_data,true);
            _data.playerInfo.addPet(_data,true);
         }
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(state == 0 || state == 1 || state == 2)
         {
            PetEquipManager.currSelectedPetData = _data;
         }
         if(_data)
         {
            refresh();
         }
         else
         {
            restore();
         }
      }
      
      private function refresh() : void
      {
         switch(state)
         {
            case 0:
            case 3:
               refreshForState0();
               break;
            case 1:
               refreshForState1();
               break;
            case 2:
               refreshForState2();
               break;
            default:
               refreshForState0();
         }
         refreshBtnView();
         refreshEquipView();
         _gradeTxt.text = String(_data.grade);
         if(_data.quality >= 6)
         {
            _sacrificeBtn.tipData = LanguageMgr.GetTranslation("pet.property.PetShowView.TipTxt06");
         }
         else
         {
            _sacrificeBtn.tipData = LanguageMgr.GetTranslation("pet.property.PetShowView.TipTxt01");
         }
      }
      
      private function refreshForState0() : void
      {
         var _loc1_:int = 0;
         _nameTxt.text = _data.name;
         _nameTxt.setFrame(_data.quality);
         if(_data.template)
         {
            _loc1_ = int(_data.template.PetType.toString().charAt(2));
            _needGradeTxt.text = LanguageMgr.GetTranslation("pet.needGradeTxt" + _data.template.NeedGrade,_petTypeList[_loc1_ - 1]);
         }
         _powerTxt.text = String(_data.fightPower);
         if(_loaderKey != _data.template.PetAvatar)
         {
            _loaderKey = _data.template.PetAvatar;
            clearLoaders();
            startLoader();
         }
         var _loc2_:int = int(_data.template.PetType.toString().charAt(2));
         _petType.visible = true;
         _equipBg.visible = true;
         _petType.setFrame(_loc2_);
         _petType.tipData = _petTypeList[_loc2_ - 1];
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         showStar();
      }
      
      private function refreshForState1() : void
      {
         _nameTxt.text = _data.name;
         _nameTxt.setFrame(_data.quality);
         if(_loaderKey != _data.template.PetAvatar)
         {
            _loaderKey = _data.template.PetAvatar;
            clearLoaders();
            startLoader();
         }
      }
      
      private function refreshForState2() : void
      {
         _nameTxt.text = _data.name;
         _nameTxt.setFrame(_data.quality);
         if(_loaderKey != _data.template.PetAvatar)
         {
            _loaderKey = _data.template.PetAvatar;
            clearLoaders();
            startLoader();
         }
      }
      
      private function showStar() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Bitmap = null;
         var _loc7_:int = 0;
         var _loc2_:Bitmap = null;
         var _loc1_:UpgradeTemplateInfo = _data.qualityUpgradeTemplateInfo;
         if(_loc1_ == null)
         {
            return;
         }
         _loc3_ = _data.temQuality % 5 == 0 ? 5 : _data.temQuality % 5;
         if(_data.temQuality > 25)
         {
            _loc4_ = "asset.pet.smallMoonLightLevelImg";
            _loc5_ = "asset.pet.smallMoonDarkLevelImg";
         }
         else
         {
            _loc4_ = "asset.petList.StarLevelLightImg";
            _loc5_ = "asset.petList.StarLevelDarkImg";
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc8_ = ComponentFactory.Instance.creatBitmap(_loc4_);
            _hBox.addChild(_loc8_);
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < 5 - _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatBitmap(_loc5_);
            _hBox.addChild(_loc2_);
            _loc7_++;
         }
      }
      
      private function clearLoaders() : void
      {
         ObjectUtils.disposeAllChildren(_showContainer);
      }
      
      private function startLoader() : void
      {
         var _loc1_:String = PathManager.getPetMorphShowPath(_loaderKey);
         LoaderManagerII.instance.load(_loc1_,2,8,__loadMorphAvatarCompleteHandler);
      }
      
      private function __loadMorphAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         var _loc3_:MovieClip = param2 as MovieClip;
         if(_loc3_)
         {
            if(_loc3_["pos_down"])
            {
               _loc3_.x = -_loc3_["pos_down"]["x"];
               _loc3_.y = -_loc3_["pos_down"]["y"];
            }
            _showContainer.addChild(_loc3_);
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
      }
      
      private function restore() : void
      {
         _nameTxt.text = "";
         _needGradeTxt.text = "";
         _powerTxt.text = "";
         _gradeTxt.text = "";
         ObjectUtils.disposeAllChildren(_showContainer);
         _petType.visible = false;
         _equipBg.visible = false;
         _setEnterWarBtn.visible = false;
         _heroWarBtn.visible = false;
         _childWarBtn.visible = false;
         _slavedChildWarBtn.visible = false;
         _resetBtn.visible = false;
         _cancelPracticeBtn.visible = false;
         _sacrificeBtn.visible = false;
         _priorityBtn.visible = false;
         _loaderKey = null;
         _hBox.visible = false;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         _heroWarBtn.visible = false;
         _childWarBtn.visible = false;
         _slavedChildWarBtn.visible = false;
         _resetBtn.visible = false;
         if(state == 1 || state == 2)
         {
            _changeBtn.visible = false;
            _carryTxt.visible = false;
            _needGradeTxt.visible = false;
            _powerLabel.visible = false;
            _powerTxt.visible = false;
            _gradeTxt.visible = false;
            _sacrificeBtn.visible = false;
            _cancelPracticeBtn.visible = false;
            _priorityBtn.visible = false;
            _setEnterWarBtn.visible = false;
            _levelFlag.visible = false;
            _petType.visible = false;
            _equipBg.visible = false;
            _hBox.visible = false;
         }
         else if(state == 3)
         {
            _changeBtn.visible = false;
            _sacrificeBtn.visible = false;
            _cancelPracticeBtn.visible = false;
            _priorityBtn.visible = false;
            _btnVpLock.visible = false;
            _setEnterWarBtn.visible = false;
         }
         addEvent();
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loadMorphAvatarCompleteHandler);
         removeEvent();
         uintView();
         if(_showContainer)
         {
            ObjectUtils.disposeObject(_showContainer);
         }
         _showContainer = null;
         super.dispose();
         _data = null;
      }
   }
}

