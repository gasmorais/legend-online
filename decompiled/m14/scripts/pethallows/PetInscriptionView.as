package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class PetInscriptionView extends Component
   {
      
      private var back:Bitmap;
      
      private var materialImage1:MutipleImage;
      
      private var materialImage2:MutipleImage;
      
      private var materialText1:FilterFrameText;
      
      private var materialText2:FilterFrameText;
      
      private var materialText3:FilterFrameText;
      
      private var materialBtn1:SelectedIconTextButton;
      
      private var materialBtn2:SelectedIconTextButton;
      
      private var materialBtn3:SelectedIconTextButton;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var essenceText:FilterFrameText;
      
      private var pointImage:Image;
      
      private var essenceBtn:IconButton;
      
      private var itemList:Vector.<PetInscriptionItemView>;
      
      private var itemContiner:Component;
      
      private var skillIcon:BaseIconView;
      
      private var skillLevelText:FilterFrameText;
      
      private var curHasCount:int;
      
      private var curCostTempId:int;
      
      private var upgradeHasCount:int;
      
      private var feedHasCount:int;
      
      private var breakHasCount:int;
      
      private var curHallowsInfo:PetHallowsInfo;
      
      private var lockCostArr:Array;
      
      private var lockCostAll:int;
      
      public function PetInscriptionView()
      {
         super();
         initView();
         initItemView();
         addEvent();
         model.hasLockCount = 0;
         refreshView();
         btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.PetInscriptionView.back");
         materialImage1 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialImage1");
         materialImage2 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialImage2");
         materialText1 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialText1");
         materialText2 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialText2");
         materialText3 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialText3");
         essenceText = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.essenceText");
         pointImage = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.pointImage");
         essenceBtn = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.essenceBtn");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.itemContiner");
         skillIcon = ComponentFactory.Instance.creatCustomObject("PetInscriptionView.skillIcon");
         skillLevelText = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.skillLevelText");
         materialBtn1 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialBtn1");
         materialBtn2 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialBtn2");
         materialBtn3 = ComponentFactory.Instance.creatComponentByStylename("PetInscriptionView.materialBtn3");
         addChild(back);
         addChild(materialImage1);
         addChild(materialImage2);
         addChild(materialText1);
         addChild(materialText2);
         addChild(materialText3);
         addChild(itemContiner);
         addChild(skillIcon);
         addChild(skillLevelText);
         addChild(essenceText);
         addChild(pointImage);
         addChild(essenceBtn);
         addChild(materialBtn1);
         addChild(materialBtn2);
         addChild(materialBtn3);
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(materialBtn1);
         btnGroup.addSelectItem(materialBtn2);
         btnGroup.addSelectItem(materialBtn3);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208062);
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208063);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208064);
         if(_loc1_)
         {
            materialBtn1.text = LanguageMgr.GetTranslation("PetInscriptionView.materialBtn.text",model.inscriptionNeedValue,_loc1_.TemplateName);
         }
         if(_loc3_)
         {
            materialBtn2.text = LanguageMgr.GetTranslation("PetInscriptionView.materialBtn.text",model.inscriptionNeedValue,_loc3_.TemplateName);
         }
         if(_loc2_)
         {
            materialBtn3.text = LanguageMgr.GetTranslation("PetInscriptionView.materialBtn.text",model.inscriptionNeedValue,_loc2_.TemplateName);
         }
         lockCostArr = ConfigInfoManager.instance.getPetHallowsInscriptionLockArr();
      }
      
      private function initItemView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetInscriptionItemView = null;
         itemList = new Vector.<PetInscriptionItemView>();
         itemContiner.mouseEnabled = false;
         var _loc3_:Array = [[160,10],[280,78],[281,216],[160,282],[41,216],[39,78]];
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("PetInscriptionView.item",[_loc2_]);
            _loc1_.x = _loc3_[_loc2_][0];
            _loc1_.y = _loc3_[_loc2_][1];
            itemContiner.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         essenceBtn.addEventListener("click",__onEssenceClickHandler);
         btnGroup.addEventListener("change",__updateSelectMaterialHandler);
         MsgMan.addObserver("PET_INSCRIPTION_LOCK_CHANGE",this,__onLockChangeHandler);
         MsgMan.addObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.addObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsUpdateMsgHandler);
      }
      
      private function removeEvent() : void
      {
         if(essenceBtn)
         {
            essenceBtn.removeEventListener("click",__onEssenceClickHandler);
         }
         if(btnGroup)
         {
            btnGroup.removeEventListener("change",__updateSelectMaterialHandler);
         }
         MsgMan.removeObserver("PET_INSCRIPTION_LOCK_CHANGE",this,__onLockChangeHandler);
         MsgMan.removeObserver("PET_HALLOWS_HEAD_SELECT",this,__hallowsHeadSelectHandler);
         MsgMan.removeObserver("PET_HALLOWS_MSG_UPDATE",this,__hallowsUpdateMsgHandler);
      }
      
      private function __hallowsUpdateMsgHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __hallowsHeadSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            itemList[_loc3_].isLock = false;
            _loc3_++;
         }
         refreshView();
      }
      
      private function __onLockChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         model.hasLockCount = getLockArr().length;
         lockCostAll = 0;
         _loc3_ = 0;
         while(_loc3_ < model.hasLockCount)
         {
            if(_loc3_ <= lockCostArr.length)
            {
               lockCostAll = int(lockCostArr[_loc3_]);
            }
            _loc3_++;
         }
         essenceText.htmlText = LanguageMgr.GetTranslation("PetInscriptionView.essenceText.text",lockCostAll);
         pointImage.x = essenceText.x + essenceText.textWidth + 8;
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!model.selectedHallowsTemp)
         {
            return;
         }
         upgradeHasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208062);
         feedHasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208063);
         breakHasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208064);
         materialText1.text = upgradeHasCount + "";
         materialText2.text = feedHasCount + "";
         materialText3.text = breakHasCount + "";
         __updateSelectMaterialHandler(null);
         curHallowsInfo = model.getHallowsInfoByHallowsType(model.selectedHallowsTemp.HallowType);
         essenceBtn.enable = curHallowsInfo ? true : false;
         if(curHallowsInfo && curHallowsInfo.activeSkillTempId != 0)
         {
            _loc1_ = int(curHallowsInfo.activeSkillTempId);
            skillIcon.filters = [];
         }
         else
         {
            _loc1_ = int(model.getShowSkillTempId(curHallowsInfo));
            skillIcon.filters = [UIFilter.getGrayFilter()];
         }
         var _loc3_:SkillTempInfo = TempleteManager.instance.getSkillById(_loc1_);
         var _loc4_:String = IconFactory.getCommonIconPath(_loc3_.Icons);
         if(skillIcon.icon != _loc4_)
         {
            skillIcon.icon = _loc4_;
         }
         skillIcon.tipData = _loc3_;
         skillLevelText.text = LanguageMgr.GetTranslation("public.level2",_loc3_.Grades);
         _loc2_ = 0;
         while(_loc2_ < itemList.length)
         {
            itemList[_loc2_].data = curHallowsInfo;
            _loc2_++;
         }
         __onLockChangeHandler(null,null);
      }
      
      private function __onEssenceClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!curHallowsInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         if(getLockArr().length > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_ = LanguageMgr.GetTranslation("PetInscriptionView.lock.costContent",lockCostAll,getLockArr().length);
            SharedManagerHelper.ins.needAlert("PetInscriptionView.lock.alert",petInscriptionResultHandler,_loc2_,_loc3_,"");
         }
         else
         {
            PetHallowsManager.instance.sendPetInscriptionRequest(curHallowsInfo.hallowType,curCostTempId,0,getLockArr());
         }
      }
      
      private function petInscriptionResultHandler(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = int(playerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(playerModel.playerInfo.point);
         }
         if(_loc2_ >= lockCostAll)
         {
            _loc3_ = param1 ? 2 : 1;
            PetHallowsManager.instance.sendPetInscriptionRequest(curHallowsInfo.hallowType,curCostTempId,_loc3_,getLockArr());
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function getLockArr() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            if(itemList[_loc1_].isLock)
            {
               _loc2_.push(_loc1_ + 1);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function __updateSelectMaterialHandler(param1:Event) : void
      {
         if(btnGroup.getSelectedItem() == materialBtn1)
         {
            curHasCount = upgradeHasCount;
            curCostTempId = 208062;
         }
         else if(btnGroup.getSelectedItem() == materialBtn2)
         {
            curHasCount = feedHasCount;
            curCostTempId = 208063;
         }
         else if(btnGroup.getSelectedItem() == materialBtn3)
         {
            curHasCount = breakHasCount;
            curCostTempId = 208064;
         }
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         btnGroup = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(materialImage1)
         {
            ObjectUtils.disposeObject(materialImage1);
         }
         materialImage1 = null;
         if(materialImage2)
         {
            ObjectUtils.disposeObject(materialImage2);
         }
         materialImage2 = null;
         if(essenceText)
         {
            ObjectUtils.disposeObject(essenceText);
         }
         essenceText = null;
         if(pointImage)
         {
            ObjectUtils.disposeObject(pointImage);
         }
         pointImage = null;
         if(essenceBtn)
         {
            ObjectUtils.disposeObject(essenceBtn);
         }
         essenceBtn = null;
         if(materialText1)
         {
            ObjectUtils.disposeObject(materialText1);
         }
         materialText1 = null;
         if(materialText2)
         {
            ObjectUtils.disposeObject(materialText2);
         }
         materialText2 = null;
         if(materialText3)
         {
            ObjectUtils.disposeObject(materialText3);
         }
         materialText3 = null;
         if(skillIcon)
         {
            ObjectUtils.disposeObject(skillIcon);
         }
         skillIcon = null;
         if(skillLevelText)
         {
            ObjectUtils.disposeObject(skillLevelText);
         }
         skillLevelText = null;
         if(materialBtn1)
         {
            ObjectUtils.disposeObject(materialBtn1);
         }
         materialBtn1 = null;
         if(materialBtn2)
         {
            ObjectUtils.disposeObject(materialBtn2);
         }
         materialBtn2 = null;
         if(materialBtn3)
         {
            ObjectUtils.disposeObject(materialBtn3);
         }
         materialBtn3 = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         LogicUtils.disposeDisplayCollection(itemList);
         model.hasLockCount = 0;
         super.dispose();
      }
   }
}

