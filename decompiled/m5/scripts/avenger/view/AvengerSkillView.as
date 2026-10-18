package avenger.view
{
   import avatar.view.ShowAvatar;
   import avenger.item.AvengerSkillItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.avenger.AvengerSkillInfo;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.AvengerManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class AvengerSkillView extends Component
   {
      
      private var _descText:FilterFrameText;
      
      private var _costText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _skillNameText:FilterFrameText;
      
      private var _selectSkillIcon:BaseIconView;
      
      private var _skillBack:MutipleImage;
      
      private var _upgradeBtn:IconButton;
      
      private var _upBtn:IconButton;
      
      private var _heroAvatar:ShowAvatar;
      
      private var _skillCon:Component;
      
      public var skillList:Vector.<AvengerSkillItem>;
      
      private var selectIndex:int = 1;
      
      private var skillLen:int = 6;
      
      private var selectInfo:AvengerSkillInfo;
      
      public function AvengerSkillView()
      {
         super();
         initView();
         initSkillView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _descText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.descText");
         _costText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.costText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.gradeText");
         _skillNameText = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.skillNameText");
         _selectSkillIcon = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillView.selectSkillIcon");
         _skillBack = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.skillBack");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.upgradeBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.upBtn");
         _skillCon = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerSkillView.skillCon");
         _heroAvatar = new ShowAvatar(true);
         _heroAvatar.x = 50;
         _heroAvatar.y = 75;
         _heroAvatar.mouseChildren = _heroAvatar.mouseEnabled = false;
         _heroAvatar.data = ArmyManager.instance.thane;
         addChild(_skillBack);
         addChild(_heroAvatar);
         addChild(_skillCon);
         addChild(_selectSkillIcon);
         addChild(_skillNameText);
         addChild(_descText);
         addChild(_gradeText);
         addChild(_costText);
         addChild(_upBtn);
         addChild(_upgradeBtn);
         this.mouseEnabled = false;
      }
      
      private function initSkillView() : void
      {
         var _loc4_:AvengerSkillItem = null;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         skillList = new Vector.<AvengerSkillItem>();
         _loc3_ = 0;
         while(_loc3_ < skillLen)
         {
            _loc1_ = _loc3_ < 3 ? 1 : 2;
            _loc4_ = ComponentFactory.Instance.creatCustomObject("Avenger.AvengerSkillView.skillItem",[_loc1_,_loc3_ + 1]);
            _loc4_.x = int(_loc3_ / 3) <= 0 ? 15 : 275;
            _loc4_.y = int(_loc3_ % 3) * 100 + 80;
            _skillCon.addChild(_loc4_);
            skillList.push(_loc4_);
            _loc4_.selected = _loc3_ + 1 == selectIndex ? true : false;
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _upBtn.addEventListener("click",_upBtnClickHandler);
         _upgradeBtn.addEventListener("click",_upgradeBtnClickHandler);
         MsgMan.addObserver("SKILL_INFO_UPDATE",this,__updateSkillInfoHandler);
         MsgMan.addObserver("SKILL_ITEM_SELECT",this,__updateSkillSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",_upBtnClickHandler);
         }
         if(_upgradeBtn)
         {
            _upgradeBtn.removeEventListener("click",_upgradeBtnClickHandler);
         }
         MsgMan.removeObserver("SKILL_INFO_UPDATE",this,__updateSkillInfoHandler);
         MsgMan.removeObserver("SKILL_ITEM_SELECT",this,__updateSkillSelectHandler);
      }
      
      private function _upBtnClickHandler(param1:MouseEvent) : void
      {
         if(!selectInfo)
         {
            return;
         }
         AvengerManager.instance.sendAvengerSkillRequest(1,selectInfo.skillSontype);
      }
      
      private function _upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("avenger","UPGARDE_FRAME",selectInfo);
      }
      
      private function __updateSkillSelectHandler(param1:String, param2:Object) : void
      {
         selectIndex = param2 as int;
         refreshView();
      }
      
      private function __updateSkillInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:AvengerSkillItem = null;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < skillLen)
         {
            _loc4_ = skillList[_loc3_];
            _loc4_.data = _loc3_ < model.showSkillList.length ? model.showSkillList[_loc3_] : null;
            _loc4_.selected = _loc3_ + 1 == selectIndex ? true : false;
            _loc3_++;
         }
         selectInfo = model.showSkillList[selectIndex - 1];
         if(!selectInfo)
         {
            return;
         }
         _descText.text = selectInfo.skillTemp.Description;
         _skillNameText.text = selectInfo.skillTemp.TemplateName;
         _gradeText.text = LanguageMgr.GetTranslation("public.level4_space2",selectInfo.skillTemp.Grades);
         var _loc2_:int = selectInfo.skillTemp.Cost / 10;
         _costText.text = LanguageMgr.GetTranslation("AvengerSkillView.costText.text",_loc2_);
         _selectSkillIcon.icon = IconFactory.getTecIconByIcon(selectInfo.skillTemp.Icons);
         _upBtn.enable = !selectInfo.isFight;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_costText);
         _costText = null;
         ObjectUtils.disposeObject(_skillNameText);
         _skillNameText = null;
         ObjectUtils.disposeObject(_selectSkillIcon);
         _selectSkillIcon = null;
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_upgradeBtn);
         _upgradeBtn = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_skillCon);
         _skillCon = null;
         ObjectUtils.disposeObject(_heroAvatar);
         _heroAvatar = null;
         LogicUtils.disposeDisplayCollection(skillList);
         skillList = null;
         super.dispose();
      }
   }
}

