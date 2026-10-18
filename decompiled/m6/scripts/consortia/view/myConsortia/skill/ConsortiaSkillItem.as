package consortia.view.myConsortia.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.consortia.ConsortiaTemplete;
   import mvc.module.consortia.ConsortiaTempleteInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ConsortiaSkillHelper;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.ConsortiaSkillTipInfo;
   
   public class ConsortiaSkillItem extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _effectTxt:FilterFrameText;
      
      private var _tips:FilterFrameText;
      
      private var _studySkillBtn:TextButton;
      
      private var _data:ConsortiaTempleteInfo;
      
      private var _temp:ConsortiaTemplete;
      
      private var _icon:BaseItemView;
      
      private var _filter:IFilterFormat;
      
      public function ConsortiaSkillItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.skillItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.SkillNameTextStyle");
         _effectTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.SkillEffectTextStyle");
         _studySkillBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.studySkillBtn");
         _tips = ComponentFactory.Instance.creatComponentByStylename("consortia.SkillTipsTextStyle");
         _icon = ComponentFactory.Instance.creatCustomObject("consortia.SkillItemView");
         _icon.tipStyle = "consortia.ConsortiaSkillTip";
         _studySkillBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.study");
         _studySkillBtn.enable = false;
         _studySkillBtn.visible = false;
         _tips.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.tips");
         _tips.visible = false;
         addChild(_bg);
         addChild(_nameTxt);
         addChild(_effectTxt);
         addChild(_studySkillBtn);
         addChild(_tips);
         addChild(_icon);
      }
      
      public function get data() : ConsortiaTempleteInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaTempleteInfo) : void
      {
         _data = param1;
         if(_data)
         {
            addEvent();
            refreshView();
         }
      }
      
      private function getTemp() : ConsortiaTemplete
      {
         var _loc2_:int = int(ConsortiaSkillHelper.getLevelByType(_data.type,playerInfo));
         var _loc3_:int = int(consortiaInfo.getLevelByUpgradeType(_data.type));
         var _loc1_:int = _loc2_ < _loc3_ ? _loc2_ : _loc3_;
         if(_loc1_ == 10)
         {
            _loc1_ -= 1;
         }
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(_data.type,_loc1_ + 1);
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      private function setFilter() : void
      {
         var _loc1_:int = int(consortiaInfo.getLevelByUpgradeType(_data.type));
         if(_loc1_ <= _temp.Levels - 1)
         {
            _filter.setGrayFilter(_nameTxt);
            _filter.setGrayFilter(_effectTxt);
            _filter.setGrayFilter(_icon);
            _tips.visible = true;
            _studySkillBtn.visible = false;
         }
         else
         {
            _filter.setNormalFilter(_nameTxt);
            _filter.setNormalFilter(_effectTxt);
            _filter.setNormalFilter(_icon);
            _tips.visible = false;
            _studySkillBtn.visible = true;
         }
      }
      
      private function uninit() : void
      {
         _data = null;
         _filter = null;
         _temp = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_nameTxt)
         {
            _nameTxt.dispose();
         }
         _nameTxt = null;
         if(_effectTxt)
         {
            _effectTxt.dispose();
         }
         _effectTxt = null;
         if(_tips)
         {
            _tips.dispose();
         }
         _tips = null;
         if(_studySkillBtn)
         {
            _studySkillBtn.dispose();
         }
         _studySkillBtn = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
      }
      
      private function addEvent() : void
      {
         _studySkillBtn.addEventListener("click",__onStudySkillHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function removeEvent() : void
      {
         _studySkillBtn.removeEventListener("click",__onStudySkillHandler);
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function __onStudySkillHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.consortiaStudy(_data.nextTemplateInfo);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __onConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = int(ConsortiaSkillHelper.getLevelByType(_data.type,playerInfo));
         refreshView();
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function __onConsortiaRightsUpdata(param1:ConsortiaEvent) : void
      {
         setStudyRights();
      }
      
      private function setStudyRights() : void
      {
         if(_studySkillBtn && ConsortiaSkillHelper.getLevelByType(_data.type,playerInfo) != 10)
         {
            _studySkillBtn.enable = true;
         }
         else
         {
            _studySkillBtn.enable = false;
         }
      }
      
      public function refreshView() : void
      {
         _temp = getTemp();
         if(isCommonSkill(_temp.Types))
         {
            _tips.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.tips");
            _bg.setFrame(1);
            _effectTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.effect1",_temp.NeedOffer);
         }
         else
         {
            _tips.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.advanced.tips");
            _bg.setFrame(2);
            _effectTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.effect2",_temp.Property2);
         }
         _icon.icon.icon = IconFactory.getTecIconByIcon(_temp.Icon);
         var _loc1_:String = _temp.LevelName + _temp.Levels;
         _nameTxt.text = _temp.LevelName + " " + LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",_temp.Levels);
         if(_nameTxt.numLines <= 2)
         {
            _nameTxt.y = 5;
         }
         setTips();
         setFilter();
         __onConsortiaRightsUpdata(null);
      }
      
      private function setTips() : void
      {
         var _loc1_:ConsortiaSkillTipInfo = new ConsortiaSkillTipInfo();
         _icon.tipData = null;
         if(ConsortiaSkillHelper.getLevelByType(_data.type,playerInfo) == 10)
         {
            _loc1_.title = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.tip.title2");
            _icon.tipData = _loc1_;
            _studySkillBtn.tipData = _loc1_;
            return;
         }
         _loc1_.title = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.ConsortiaSkillItem.tip.title");
         _loc1_.addItem(_temp.Description);
         _loc1_.addExplain(getExplainByTypes(_temp.Types));
         _icon.tipData = _loc1_;
         _studySkillBtn.tipData = _loc1_;
      }
      
      private function isCommonSkill(param1:int = 0) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1 - 6)
         {
            case 0:
            case 2:
            case 3:
            case 4:
            case 5:
            case 6:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function getExplainByTypes(param1:int = 0) : String
      {
         var _loc2_:String = null;
         switch(param1 - 6)
         {
            case 0:
            case 2:
            case 3:
            case 4:
            case 6:
            case 7:
            case 8:
            case 9:
            case 10:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.skill.explain" + param1);
               break;
            case 5:
            case 11:
            case 12:
            case 13:
            case 14:
               _loc2_ = "";
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

