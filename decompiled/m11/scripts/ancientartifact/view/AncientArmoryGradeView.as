package ancientartifact.view
{
   import ancientartifact.view.item.AncientArmoryGradeItem;
   import ancientartifact.view.item.AncientArmoryItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.AncientArtifactEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class AncientArmoryGradeView extends Component
   {
      
      private var _jiantou:Image;
      
      private var _needIcon:Bitmap;
      
      private var _backBg01:Bitmap;
      
      private var _backBg02:Bitmap;
      
      private var _iconItem1:Image;
      
      private var _iconItem2:Image;
      
      private var _currentTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _tipsTxt:FilterFrameText;
      
      private var _gradeBtn:IconButton;
      
      private var _currentItem:AncientArmoryGradeItem;
      
      private var _nextItem:AncientArmoryGradeItem;
      
      private var _maxItem:AncientArmoryGradeItem;
      
      private var _needItem01:AncientArmoryItem;
      
      private var _needItem02:AncientArmoryItem;
      
      private var _needItem03:AncientArmoryItem;
      
      private var _needItem04:AncientArmoryItem;
      
      private var _data:AncientArmoryInfo;
      
      public function AncientArmoryGradeView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _needIcon = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryNeedIcon");
         _backBg01 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryCurrentHasIcon");
         _backBg02 = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.armoryNeedIcon");
         _iconItem1 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeIcon1");
         _iconItem2 = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeIcon2");
         _currentTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.currentGradeHasNumTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.currentGradeNeedNumTxt");
         _jiantou = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeJianTou");
         _tipsTxt = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeTipsTxt");
         _gradeBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.armoryGradeBtn");
         _currentItem = new AncientArmoryGradeItem(1);
         _nextItem = new AncientArmoryGradeItem(2);
         _maxItem = new AncientArmoryGradeItem(3);
         _needItem01 = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem",[2,1]);
         _needItem02 = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem",[2,2]);
         _needItem03 = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem",[2,3]);
         _needItem04 = ComponentFactory.Instance.creatCustomObject("ancientartifact.markArmoryItem",[2,4]);
         addChild(_backBg01);
         addChild(_backBg02);
         addChild(_iconItem1);
         addChild(_iconItem2);
         addChild(_currentTxt);
         addChild(_needTxt);
         addChild(_needIcon);
         addChild(_jiantou);
         addChild(_tipsTxt);
         addChild(_gradeBtn);
         addChild(_currentItem);
         addChild(_nextItem);
         addChild(_maxItem);
         addChild(_needItem01);
         addChild(_needItem02);
         addChild(_needItem03);
         addChild(_needItem04);
         _backBg01.x = 27;
         _backBg01.y = 314;
         _backBg02.x = 178;
         _backBg02.y = 309;
         _currentItem.x = 15;
         _currentItem.y = 30;
         _nextItem.x = 220;
         _nextItem.y = 30;
         _maxItem.x = 120;
         _maxItem.y = 30;
         _needItem01.x = 80;
         _needItem01.y = 225;
         _needItem02.x = 150;
         _needItem02.y = 225;
         _needItem03.x = 220;
         _needItem03.y = 225;
         _needItem04.x = 290;
         _needItem04.y = 225;
         _tipsTxt.text = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips05");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(6260003);
         var _loc2_:String = LanguageMgr.GetTranslation("ChildNSLearnSkillFrame.hasMaterialText.text",_loc1_.TemplateName,_loc1_.Description);
         if(_loc1_)
         {
            _iconItem1.tipData = _iconItem2.tipData = _loc2_;
         }
         _needTxt.text = "0";
         _gradeBtn.enable = false;
         initInfo();
      }
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      private function initInfo() : void
      {
         _currentItem.visible = _nextItem.visible = _jiantou.visible = true;
         _maxItem.visible = false;
         _needItem01.data = null;
         _needItem02.data = null;
         _needItem03.data = null;
         _needItem04.data = null;
         _needItem01.setGrayFilter();
         _needItem02.setGrayFilter();
         _needItem03.setGrayFilter();
         _needItem04.setGrayFilter();
         _currentTxt.text = GoodsManager.instance.getBagCountByTempId(1,6260003).toString();
      }
      
      private function initEvent() : void
      {
         _gradeBtn.addEventListener("click",__onClick);
         model.addEventListener("ARMORY_CHOOSE_DATA",__getGradesInfos);
      }
      
      private function __getGradesInfos(param1:AncientArtifactEvent) : void
      {
         var _loc9_:AncientArmoryInfo = null;
         var _loc2_:ArmoryTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Array = param1.data as Array;
         var _loc4_:int = int(_loc5_[1]);
         initInfo();
         if(_loc4_ == -1)
         {
            _data = _loc5_[0] as AncientArmoryInfo;
            if(!_data)
            {
               _currentItem.data = null;
               _nextItem.data = null;
               _maxItem.data = null;
               _needTxt.text = "0";
               return;
            }
            _loc6_ = _data.profile + 1;
            _loc2_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_loc6_);
            if(!_loc2_)
            {
               _currentItem.visible = _nextItem.visible = _jiantou.visible = false;
               _maxItem.visible = true;
               _maxItem.data = _data;
               _gradeBtn.enable = false;
            }
            else
            {
               _gradeBtn.enable = true;
               _needTxt.text = _loc2_.AdvanceNeedCount.toString();
               _currentItem.data = _data;
               _nextItem.data = getNextData();
               _loc7_ = int(_loc2_.ComposeNeedCount);
            }
         }
         if(_data)
         {
            _loc2_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_data.profile + 1);
            if(!_loc2_)
            {
               return;
            }
            _loc7_ = int(_loc2_.ComposeNeedCount);
         }
         var _loc3_:int = int(model.chooseList.length);
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = model.getArmoryInfoById(model.chooseList[_loc8_]);
            if(_loc8_ < _loc3_)
            {
               this["_needItem0" + (_loc8_ + 1)].data = _loc9_;
               this["_needItem0" + (_loc8_ + 1)].setNormalFilter();
            }
            else
            {
               this["_needItem0" + (_loc8_ + 1)].data = getNeedData();
            }
            _loc8_ += 1;
         }
      }
      
      private function getNextData() : AncientArmoryInfo
      {
         var _loc1_:AncientArmoryInfo = new AncientArmoryInfo();
         _loc1_.armoryId = _data.armoryId;
         _loc1_.templateId = _data.templateId;
         _loc1_.profile = _data.profile + 1;
         _loc1_.attacks = _data.attacks;
         _loc1_.defences = _data.defences;
         _loc1_.magicDefences = _data.magicDefences;
         _loc1_.penetrate = _data.penetrate;
         _loc1_.parry = _data.parry;
         _loc1_.gp = _data.gp;
         _loc1_.live = _data.live;
         _loc1_.grades = 0;
         _loc1_.isEquip = _data.isEquip;
         _loc1_.equipPos = _data.equipPos;
         return _loc1_;
      }
      
      private function getNeedData() : AncientArmoryInfo
      {
         var _loc1_:AncientArmoryInfo = new AncientArmoryInfo();
         _loc1_.armoryId = _data.armoryId;
         _loc1_.templateId = _data.templateId;
         _loc1_.profile = _data.profile;
         _loc1_.attacks = _data.attacks;
         _loc1_.defences = _data.defences;
         _loc1_.magicDefences = _data.magicDefences;
         _loc1_.penetrate = _data.penetrate;
         _loc1_.parry = _data.parry;
         _loc1_.gp = _data.gp;
         _loc1_.live = _data.live;
         _loc1_.grades = _data.grades;
         _loc1_.isEquip = _data.isEquip;
         _loc1_.equipPos = _data.equipPos;
         return _loc1_;
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ArmoryTemplateInfo = null;
         var _loc2_:String = "";
         if(!_data)
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _loc4_ = _data.profile + 1;
         _loc3_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_loc4_);
         if(!_loc3_)
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _loc3_ = TempleteManager.instance.armoryTempCate.getTempInfoByTemplateId(_data.templateId,_loc4_ - 1);
         if(model.chooseList.length < _loc3_.ComposeNeedCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(isHasEquipArmory)
         {
            showArmoryGradeAlert();
            return;
         }
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_ADVANCE,0,0,false,0,_data.armoryId,model.chooseList);
      }
      
      private function showArmoryGradeAlert() : void
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.armoryEquipGradeCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.armoryEquipGrade);
         if(!_loc5_ || _loc3_.month < _loc4_.month || _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.ArmoryDeleteAlertFrame");
            _loc6_ = LanguageMgr.GetTranslation("ancientartifact.AncientAdvanceFrame.armoryGradesTips06");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,startDeleteAlertBack);
         }
         else
         {
            AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_ADVANCE,0,0,false,0,_data.armoryId,model.chooseList);
         }
      }
      
      private function startDeleteAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.armoryEquipGrade = param1;
         SharedManager.instance.armoryEquipGradeCheckDate = new Date();
         SharedManager.instance.armoryEquipGradeCheck();
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.ARMORY_ADVANCE,0,0,false,0,_data.armoryId,model.chooseList);
      }
      
      private function get isHasEquipArmory() : Boolean
      {
         var _loc7_:AncientArtifactInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Array = model.chooseList.concat(model.chooseId);
         var _loc1_:Array = model.artifactList;
         var _loc4_:int = int(_loc1_.length);
         var _loc8_:int = 0;
         _loc5_ = 0;
         for(; _loc5_ < _loc4_; _loc5_ += 1)
         {
            _loc7_ = _loc1_[_loc5_];
            if(_loc7_)
            {
               _loc6_ = 1;
               while(_loc6_ < 7)
               {
                  _loc8_ = int(_loc7_["armoryEquipPos" + _loc6_]);
                  if(_loc3_.indexOf(_loc8_) > 0)
                  {
                     return true;
                     break;
                  }
                  _loc6_ += 1;
               }
            }
         }
         return _loc2_;
      }
      
      private function removeEvent() : void
      {
         if(_gradeBtn)
         {
            _gradeBtn.removeEventListener("click",__onClick);
         }
         model.removeEventListener("ARMORY_CHOOSE_DATA",__getGradesInfos);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_jiantou);
         _jiantou = null;
         ObjectUtils.disposeObject(_needIcon);
         _needIcon = null;
         ObjectUtils.disposeObject(_currentItem);
         _currentItem = null;
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_maxItem);
         _maxItem = null;
         ObjectUtils.disposeObject(_gradeBtn);
         _gradeBtn = null;
         ObjectUtils.disposeObject(_tipsTxt);
         _tipsTxt = null;
         ObjectUtils.disposeObject(_needItem01);
         _needItem01 = null;
         ObjectUtils.disposeObject(_needItem02);
         _needItem02 = null;
         ObjectUtils.disposeObject(_needItem03);
         _needItem03 = null;
         ObjectUtils.disposeObject(_needItem04);
         _needItem04 = null;
         ObjectUtils.disposeObject(_backBg01);
         _backBg01 = null;
         ObjectUtils.disposeObject(_backBg02);
         _backBg02 = null;
         ObjectUtils.disposeObject(_iconItem1);
         _iconItem1 = null;
         ObjectUtils.disposeObject(_iconItem2);
         _iconItem2 = null;
         ObjectUtils.disposeObject(_currentTxt);
         _currentTxt = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         super.dispose();
      }
   }
}

