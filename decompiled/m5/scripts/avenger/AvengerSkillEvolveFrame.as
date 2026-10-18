package avenger
{
   import avenger.item.AvengerSkillEvolveCostItem;
   import avenger.item.AvengerSkillEvolvePropItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.AvengerBodyTempInfo;
   import yishi.datas.templates.AvengerSkillTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerSkillEvolveFrame extends Frame
   {
      
      private var _descText:FilterFrameText;
      
      private var _nextNameText:FilterFrameText;
      
      private var _curNameText:FilterFrameText;
      
      private var _nextSkillIcon:BaseIconView;
      
      private var _curSkillIcon:BaseIconView;
      
      private var _resistanceItem:AvengerSkillEvolvePropItem;
      
      private var _propItem:AvengerSkillEvolvePropItem;
      
      private var _evolveBack:MutipleImage;
      
      private var _evolveBtn:IconButton;
      
      private var _maxImage:Image;
      
      private var _curSkillBack:MutipleImage;
      
      private var _nextSkillBack:MutipleImage;
      
      private var _arrowImage:Image;
      
      private var _costCon:SimpleTileList;
      
      private var costList:Vector.<AvengerSkillEvolveCostItem>;
      
      private var skillInfo:AvengerSkillInfo;
      
      private var curAvengerSkillTemp:AvengerSkillTempInfo;
      
      private var nextAvengerSkillTemp:AvengerSkillTempInfo;
      
      public function AvengerSkillEvolveFrame()
      {
         super();
         initView();
         addEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("start");
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _descText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveFrame.descText");
         _nextNameText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveFrame.nextNameText");
         _curNameText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveFrame.curNameText");
         _nextSkillIcon = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.nextSkillIcon");
         _curSkillIcon = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.curSkillIcon");
         _resistanceItem = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.resistanceItem",[2]);
         _propItem = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.propItem",[1]);
         _evolveBack = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveFrame.evolveBack");
         _evolveBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillEvolveFrame.evolveBtn");
         _costCon = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.costCon",[3]);
         _maxImage = ComponentFactory.Instance.creatComponentByStylename("AvengerSkillEvolveFrame.maxImage");
         _arrowImage = ComponentFactory.Instance.creatComponentByStylename("AvengerSkillEvolveFrame.arrowImage");
         _curSkillBack = ComponentFactory.Instance.creatComponentByStylename("AvengerSkillEvolveFrame.curSkillBack");
         _nextSkillBack = ComponentFactory.Instance.creatComponentByStylename("AvengerSkillEvolveFrame.nextSkillBack");
         addToContent(_evolveBack);
         addToContent(_curSkillBack);
         addToContent(_arrowImage);
         addToContent(_nextSkillBack);
         addToContent(_curSkillIcon);
         addToContent(_nextSkillIcon);
         addToContent(_curNameText);
         addToContent(_nextNameText);
         addToContent(_propItem);
         addToContent(_resistanceItem);
         addToContent(_costCon);
         addToContent(_maxImage);
         addToContent(_descText);
         addToContent(_evolveBtn);
         _maxImage.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _evolveBtn.addEventListener("click",_evolveBtnClickHandler);
         MsgMan.addObserver("SKILL_INFO_UPDATE",this,__updateSkillInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_evolveBtn)
         {
            _evolveBtn.removeEventListener("click",_evolveBtnClickHandler);
         }
         MsgMan.removeObserver("SKILL_INFO_UPDATE",this,__updateSkillInfoHandler);
      }
      
      private function __updateSkillInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _evolveBtnClickHandler(param1:MouseEvent) : void
      {
         if(!allReached)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerSkillEvolveFrame.prmote.needItemAlert"));
            return;
         }
         if(model.bodyInfo.grade < curAvengerSkillTemp.NeedBodyGrade)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AvengerSkillEvolveFrame.prmote.noBodyGradeAlert"));
            return;
         }
         AvengerManager.instance.sendAvengerSkillRequest(3,skillInfo.skillSontype);
      }
      
      private function refreshView() : void
      {
         var _loc1_:AvengerBodyTempInfo = null;
         if(!skillInfo)
         {
            return;
         }
         _curNameText.text = skillInfo.skillTemp.TemplateName;
         _curSkillIcon.icon = IconFactory.getTecIconByIcon(skillInfo.skillTemp.Icons);
         _curSkillIcon.tipData = skillInfo.skillTemp;
         curAvengerSkillTemp = TempleteManager.instance.avengerSkillTempCate.getTemplateByTypeAndGrade(skillInfo.skillSontype,skillInfo.skillTemp.Grades);
         nextAvengerSkillTemp = TempleteManager.instance.avengerSkillTempCate.getTemplateByTypeAndGrade(skillInfo.skillSontype,skillInfo.skillTemp.Grades + 1);
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(skillInfo.skillSontype,skillInfo.skillTemp.Grades + 1);
         if(nextAvengerSkillTemp && _loc2_)
         {
            _evolveBtn.enable = true;
            _maxImage.visible = false;
            _nextSkillBack.visible = true;
            _arrowImage.visible = true;
            _nextNameText.text = _loc2_.TemplateName;
            _nextSkillIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _nextSkillIcon.tipData = _loc2_;
            _curSkillBack.x = 26;
            _curSkillIcon.x = 76;
            _curNameText.x = 45;
            _loc1_ = TempleteManager.instance.avengerBodyTempCate.getTemplateByGrade(curAvengerSkillTemp.NeedBodyGrade);
            _descText.text = LanguageMgr.GetTranslation("AvengerSkillEvolveFrame.descText.text",_loc1_.BodyType);
         }
         else
         {
            _evolveBtn.enable = false;
            _maxImage.visible = true;
            _nextSkillBack.visible = false;
            _arrowImage.visible = false;
            _nextNameText.text = "";
            _nextSkillIcon.icon = null;
            _nextSkillIcon.tipData = null;
            _curSkillBack.x = 112;
            _curSkillIcon.x = 162;
            _curNameText.x = 132;
            _descText.text = "";
         }
         _propItem.refreshTextValue(skillInfo.propAry);
         _resistanceItem.refreshTextValue(skillInfo.resiAry);
         refreshCostItems();
      }
      
      private function refreshCostItems() : void
      {
         var _loc4_:AvengerSkillEvolveCostItem = null;
         var _loc3_:int = 0;
         _costCon.removeAllChild();
         LogicUtils.disposeDisplayCollection(costList);
         costList = new Vector.<AvengerSkillEvolveCostItem>();
         var _loc1_:AvengerSkillTempInfo = TempleteManager.instance.avengerSkillTempCate.getTemplateByTypeAndGrade(skillInfo.skillSontype,skillInfo.skillTemp.Grades);
         var _loc2_:int = int(_loc1_.needItemAry[0].length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillEvolveFrame.costItem",[_loc3_]);
            _loc4_.data = skillInfo;
            _costCon.addChild(_loc4_);
            costList.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function get allReached() : Boolean
      {
         var _loc3_:AvengerSkillEvolveCostItem = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < costList.length)
         {
            _loc3_ = costList[_loc1_];
            if(!_loc3_.hasReached)
            {
               return false;
            }
            _loc1_++;
         }
         return true;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AvengerSkillEvolveFrame.title.text");
         if(param1 && param1.frameData)
         {
            skillInfo = param1.frameData as AvengerSkillInfo;
         }
         refreshView();
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         PlayerManager.instance.currentPlayerModel.setFightingCapacityRecord("end");
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_nextNameText);
         _nextNameText = null;
         ObjectUtils.disposeObject(_curNameText);
         _curNameText = null;
         ObjectUtils.disposeObject(_nextSkillIcon);
         _nextSkillIcon = null;
         ObjectUtils.disposeObject(_curSkillIcon);
         _curSkillIcon = null;
         ObjectUtils.disposeObject(_resistanceItem);
         _resistanceItem = null;
         ObjectUtils.disposeObject(_propItem);
         _propItem = null;
         ObjectUtils.disposeObject(_costCon);
         _costCon = null;
         ObjectUtils.disposeObject(_evolveBack);
         _evolveBack = null;
         ObjectUtils.disposeObject(_maxImage);
         _maxImage = null;
         ObjectUtils.disposeObject(_evolveBtn);
         _evolveBtn = null;
         ObjectUtils.disposeObject(_curSkillBack);
         _curSkillBack = null;
         ObjectUtils.disposeObject(_nextSkillBack);
         _nextSkillBack = null;
         ObjectUtils.disposeObject(_arrowImage);
         _arrowImage = null;
         LogicUtils.disposeDisplayCollection(costList);
         costList = null;
         super.dispose();
      }
   }
}

