package dragontalker
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerProficiencyInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerProficiencyFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _skillName:FilterFrameText;
      
      private var _needImage:Image;
      
      private var _back:Image;
      
      private var _replaceBtn:IconButton;
      
      private var _closeBtn:IconButton;
      
      private var _skillHbox:HBox;
      
      private var _gradeText1:FilterFrameText;
      
      private var _gradeText2:FilterFrameText;
      
      private var _gradeText3:FilterFrameText;
      
      private var _selectImage:Bitmap;
      
      private var _materialHbox:HBox;
      
      private var _starContiner:Component;
      
      private var index:int;
      
      private var skillIndex:int;
      
      private var skillList:Vector.<BaseIconView>;
      
      private var materialList:Vector.<BaseItemView>;
      
      private var hasMaterial:Boolean = true;
      
      public function DragonTalkerProficiencyFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _skillName = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d_n6_b4rj");
         _border = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d.border");
         _needImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d.needImage");
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d.back");
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d.replaceBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4d.closeBtn");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.skillHbox");
         _gradeText1 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.gradeText1");
         _gradeText2 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.gradeText2");
         _gradeText3 = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.gradeText3");
         _selectImage = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerProficiencyFrame.selectImage");
         _materialHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.materialHbox");
         _starContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyFrame.starContiner");
         addToContent(_border);
         addToContent(_back);
         addToContent(_skillHbox);
         addToContent(_starContiner);
         addToContent(_selectImage);
         addToContent(_needImage);
         addToContent(_skillName);
         addToContent(_gradeText1);
         addToContent(_gradeText2);
         addToContent(_gradeText3);
         addToContent(_materialHbox);
         addToContent(_replaceBtn);
         addToContent(_closeBtn);
      }
      
      private function initSkillView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:BaseIconView = null;
         var _loc5_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc6_:int = 0;
         var _loc3_:Bitmap = null;
         skillList = new Vector.<BaseIconView>();
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerProficiencyItem.skillIcon");
            _loc5_ = 3 * index - (2 - _loc4_);
            _loc7_ = model.profiencySkillTempDic[_loc5_ + "_" + 1];
            _loc2_.icon = IconFactory.getTecIconByIcon(_loc7_.Icons);
            _loc2_.addEventListener("click",__skillIconSelectHandler);
            _skillHbox.addChild(_loc2_);
            skillList.push(_loc2_);
            _loc4_++;
         }
         var _loc1_:Array = [[0,0],[0,35],[25,35],[0,70],[25,70],[50,70]];
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerProficiencyFrame.startBitmap");
            _loc3_.x = _loc1_[_loc6_][0];
            _loc3_.y = _loc1_[_loc6_][1];
            _starContiner.addChild(_loc3_);
            _loc6_++;
         }
      }
      
      private function initMaterialView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         materialList = new Vector.<BaseItemView>();
         var _loc6_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(index,143);
         var _loc1_:Array = [];
         if(_loc6_)
         {
            _loc1_ = _loc6_.TemplateName.split("|");
         }
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_].split(",");
            _loc4_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerProficiencyFrame.materialItem");
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc2_[0];
            _loc5_.count = _loc2_[1];
            _loc4_.data = _loc5_;
            _materialHbox.addChild(_loc4_);
            materialList.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _closeBtn.addEventListener("click",_closeBtnClickHandler);
         _replaceBtn.addEventListener("click",_replaceBtnClickHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateProficiencyHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",_closeBtnClickHandler);
         }
         if(_replaceBtn)
         {
            _replaceBtn.removeEventListener("click",_replaceBtnClickHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateProficiencyHandler);
      }
      
      private function _replaceBtnClickHandler(param1:MouseEvent) : void
      {
         if(!hasMaterial)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc3_:String = LanguageMgr.GetTranslation("dragontalker.profiencyFrame.replaceAlertText");
         SharedManagerHelper.ins.needAlert("dragontalker.profiencyFrame.replaceAlert",replaceHandlerResult,_loc2_,_loc3_);
      }
      
      private function replaceHandlerResult() : void
      {
         DragonTalkerManager.instance.sendProficiencyReplace(skillIndex);
      }
      
      private function _closeBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __updateProficiencyHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __skillIconSelectHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = skillList.indexOf(param1.currentTarget as BaseIconView);
         refreshView(_loc2_);
      }
      
      private function refreshView(param1:int = -1) : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:BaseItemView = null;
         var _loc9_:GoodsInfo = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc2_:DragonTalkerProficiencyInfo = model.getProficiencyInfoByIndex(index);
         if(param1 != -1)
         {
            skillIndex = 3 * index - (2 - param1);
            _loc6_ = param1;
         }
         else if(_loc2_.skillTemp)
         {
            skillIndex = _loc2_.skillIndex;
            _loc6_ = skillIndex - 3 * index + 2;
         }
         else
         {
            skillIndex = 3 * index - 2;
            _loc6_ = 0;
         }
         var _loc5_:SkillTempInfo = model.profiencySkillTempDic[skillIndex + "_" + 1];
         var _loc4_:SkillTempInfo = model.profiencySkillTempDic[skillIndex + "_" + 2];
         var _loc3_:SkillTempInfo = model.profiencySkillTempDic[skillIndex + "_" + 3];
         _gradeText1.text = _loc5_.Description;
         _gradeText1.setFrame(1);
         _gradeText2.text = _loc4_.Description;
         _gradeText2.setFrame(1);
         _gradeText3.text = _loc3_.Description;
         _gradeText3.setFrame(1);
         _gradeText1.y = _gradeText1.numLines > 2 ? 167 : 177;
         _gradeText2.y = _gradeText2.numLines > 2 ? 206 : 214;
         _gradeText3.y = _gradeText3.numLines > 2 ? 243 : 250;
         _skillName.text = _loc5_.TemplateName;
         if(_loc2_.skillTemp && _loc2_.skillIndex == skillIndex)
         {
            this["_gradeText" + _loc2_.skillTemp.Grades].setFrame(2);
         }
         hasMaterial = true;
         _loc7_ = 0;
         while(_loc7_ < materialList.length)
         {
            _loc8_ = materialList[_loc7_];
            _loc9_ = _loc8_.data;
            _loc10_ = int(_loc9_.templateId);
            _loc11_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc10_));
            _loc8_.setItemTextOther(_loc11_ + "/" + _loc9_.count);
            if(_loc11_ < _loc9_.count)
            {
               hasMaterial = false;
               _loc8_.itemText.setFrame(1);
            }
            else
            {
               _loc8_.itemText.setFrame(2);
            }
            _loc7_++;
         }
         _selectImage.x = _loc6_ * 95 + 167;
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
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("DragonTalkerProficiencyFrame.title.text");
         if(param1 && param1.frameData)
         {
            index = param1.frameData as int;
            initSkillView();
            initMaterialView();
            refreshView();
         }
      }
      
      private function removeIconEvent(param1:BaseIconView) : void
      {
         param1.removeEventListener("click",__skillIconSelectHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(skillList,removeIconEvent);
         skillList = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         ObjectUtils.disposeObject(_skillName);
         _skillName = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_needImage);
         _needImage = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_replaceBtn);
         _replaceBtn = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         ObjectUtils.disposeObject(_gradeText1);
         _gradeText1 = null;
         ObjectUtils.disposeObject(_gradeText2);
         _gradeText2 = null;
         ObjectUtils.disposeObject(_gradeText3);
         _gradeText3 = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         ObjectUtils.disposeObject(_materialHbox);
         _materialHbox = null;
         ObjectUtils.disposeObject(_starContiner);
         _starContiner = null;
         super.dispose();
      }
   }
}

