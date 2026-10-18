package mounts
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.PropertyInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressCommon;
   import yishi.view.tips.MessageTipManager;
   
   public class MountRefiningSoulFrame extends Frame
   {
      
      private var _skillGradeText:FilterFrameText;
      
      private var _physiqueText:FilterFrameText;
      
      private var _ArmorText:FilterFrameText;
      
      private var _abilityText:FilterFrameText;
      
      private var _strengthText:FilterFrameText;
      
      private var _itemCountText:FilterFrameText;
      
      private var _inputText:FilterFrameText;
      
      private var _skillImage:Image;
      
      private var _itemImage:Image;
      
      private var _border:ScaleBitmapImage;
      
      private var _refiningSoulBtn:IconButton;
      
      private var _mBack:MutipleImage;
      
      private var _skillNameText:FilterFrameText;
      
      private var _expBar:ProgressCommon;
      
      private var _skillUpMc:MovieClip;
      
      private var headPosArr:Array = [[140,105],[495,105],[550,295],[85,295]];
      
      private var _headList:Vector.<MountRefiningSoulItem>;
      
      private var materialId:int;
      
      private var expValue:int;
      
      private var hasCount:int;
      
      private var propMaxValue:int;
      
      private var isfirst:Boolean = true;
      
      private var preSkillGrade:int;
      
      public function MountRefiningSoulFrame()
      {
         super();
         initView();
         initHeadView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _skillGradeText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.skillGradeText");
         _physiqueText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.physiqueText");
         _ArmorText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.ArmorText");
         _abilityText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.abilityText");
         _strengthText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.strengthText");
         _itemCountText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.itemCountText");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.inputText");
         _skillImage = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.skillImage");
         _itemImage = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.itemImage");
         _border = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.border");
         _refiningSoulBtn = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.refiningSoulBtn");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.mBack");
         _skillNameText = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.skillNameText");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("MountRefiningSoul.MountRefiningSoulFrame.expBar");
         _skillUpMc = ComponentFactory.Instance.creatCustomObject("MountRefiningSoulFrame.skillUpMc");
         addToContent(_border);
         addToContent(_mBack);
         addToContent(_itemImage);
         addToContent(_skillImage);
         addToContent(_skillNameText);
         addToContent(_skillGradeText);
         addToContent(_refiningSoulBtn);
         addToContent(_inputText);
         addToContent(_itemCountText);
         addToContent(_strengthText);
         addToContent(_abilityText);
         addToContent(_ArmorText);
         addToContent(_physiqueText);
         addToContent(_expBar);
         addToContent(_skillUpMc);
         _skillUpMc.mouseChildren = _skillUpMc.mouseEnabled = false;
         _skillUpMc.gotoAndStop(1);
         _strengthText.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         _abilityText.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         _ArmorText.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         _physiqueText.text = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         _skillNameText.text = LanguageMgr.GetTranslation("MountRefiningSoulFrame.skillNameText.text");
         _itemCountText.text = "0";
         _inputText.text = "1";
         materialId = ConfigInfoManager.instance.getMountRefiningSoulTempId();
         propMaxValue = ConfigInfoManager.instance.getMountRefiningSoulMaxValue();
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(materialId);
         _itemImage.tipData = _loc1_.Description;
      }
      
      private function initHeadView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MountRefiningSoulItem = null;
         _headList = new Vector.<MountRefiningSoulItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new MountRefiningSoulItem(_loc2_ + 1);
            _loc1_.x = headPosArr[_loc2_][0];
            _loc1_.y = headPosArr[_loc2_][1];
            addToContent(_loc1_);
            _headList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _refiningSoulBtn.addEventListener("click",_refiningSoulBtnClickHandler);
         _inputText.addEventListener("change",__textChangHandler);
         MsgMan.addObserver("MOUNT_REFINING_SOUL_CHANGE",this,__updateRefiningSoulHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_refiningSoulBtn)
         {
            _refiningSoulBtn.removeEventListener("click",_refiningSoulBtnClickHandler);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("change",__textChangHandler);
         }
         MsgMan.removeObserver("MOUNT_REFINING_SOUL_CHANGE",this,__updateRefiningSoulHandler);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_inputText.text);
         if(_loc2_ <= 0)
         {
            _inputText.text = "1";
         }
         var _loc3_:int = Math.min(hasCount,999);
         if(_loc2_ >= _loc3_)
         {
            _inputText.text = _loc3_ + "";
         }
      }
      
      private function _refiningSoulBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = parseInt(_inputText.text);
         if(_loc2_ <= 0 || _loc2_ > hasCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         if(refiningSoulInfo.isSkillMax)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt3"));
            return;
         }
         MountsManager.instance.mountOperateSend(12,0,0,_loc2_);
      }
      
      private function __updateRefiningSoulHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         expValue = TempleteManager.instance.getTemplateByLevelAndType(refiningSoulInfo.totalGrade,146).Data;
         if(refiningSoulInfo.isSkillMax)
         {
            _expBar.value = 1;
            _expBar.text = "Max";
         }
         else
         {
            _expBar.value = refiningSoulInfo.curExp / expValue;
            _expBar.text = refiningSoulInfo.curExp + "/" + expValue;
         }
         hasCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(materialId);
         _itemCountText.text = hasCount + "";
         for each(var _loc1_:MountRefiningSoulItem in _headList)
         {
            _loc1_.refreshView();
         }
         setSkillTipData();
      }
      
      private function setSkillTipData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc2_:int = int(refiningSoulInfo.getSkillGrade());
         var _loc1_:int = int(refiningSoulInfo.getSkillAddPercent());
         _skillGradeText.text = refiningSoulInfo.getSkillAddPercent() + "%";
         var _loc5_:String = LanguageMgr.GetTranslation("MountRefiningSoulFrame.skillImage.tipdata",_loc2_,_loc1_) + "\n";
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = PropertyInfo.PROP_NAME_ARR[_loc4_];
            _loc6_ = Math.ceil(mountInfo.getProperty(_loc3_).addition * _loc1_ / 100);
            _loc5_ += LanguageMgr.GetTranslation("MountRefiningSoulFrame.skillImage.propValue" + _loc4_,mountInfo.getProperty(_loc3_).addition,_loc6_,propMaxValue) + "\n";
            _loc4_++;
         }
         _loc5_ = _loc5_.substring(0,_loc5_.lastIndexOf("\n"));
         _skillImage.tipData = _loc5_;
         if(!isfirst && preSkillGrade != _loc2_)
         {
            if(_skillUpMc)
            {
               _skillUpMc.gotoAndPlay(1);
            }
         }
         isfirst = false;
         preSkillGrade = _loc2_;
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
      
      private function get mountInfo() : MountInfo
      {
         return MountsManager.instance.mountInfo;
      }
      
      private function get refiningSoulInfo() : MountRefiningSoulInfo
      {
         return MountsManager.instance.selfRefiningSoulInfo;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("MountRefiningSoulFrame.title.text");
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_skillGradeText);
         _skillGradeText = null;
         ObjectUtils.disposeObject(_physiqueText);
         _physiqueText = null;
         ObjectUtils.disposeObject(_ArmorText);
         _ArmorText = null;
         ObjectUtils.disposeObject(_abilityText);
         _abilityText = null;
         ObjectUtils.disposeObject(_strengthText);
         _strengthText = null;
         ObjectUtils.disposeObject(_itemCountText);
         _itemCountText = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_skillImage);
         _skillImage = null;
         ObjectUtils.disposeObject(_itemImage);
         _itemImage = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_refiningSoulBtn);
         _refiningSoulBtn = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeViolentMc(_skillUpMc);
         _skillUpMc = null;
         ObjectUtils.disposeObject(_skillNameText);
         _skillNameText = null;
         LogicUtils.disposeDisplayCollection(_headList);
         _headList = null;
         super.dispose();
      }
   }
}

