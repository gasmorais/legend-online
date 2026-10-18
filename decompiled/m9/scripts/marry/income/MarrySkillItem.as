package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MarrySkillItem extends Component
   {
      
      private var _itemBG:Bitmap;
      
      private var _itemLock:Image;
      
      private var _noUse:BaseButton;
      
      private var _doUse:BaseButton;
      
      private var _noActivation:BaseButton;
      
      private var _killName:FilterFrameText;
      
      protected var _data:String;
      
      private var _killItem:BaseIconView;
      
      private var arr:Array = [];
      
      private var skill:SkillTempInfo;
      
      private var _state:int = 0;
      
      private var _skillTemplateName:String;
      
      public function MarrySkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBG = ComponentFactory.Instance.creatBitmap("asset.marry.ringback");
         _itemLock = ComponentFactory.Instance.creatComponentByStylename("marry.skillItemLock");
         _noUse = ComponentFactory.Instance.creatComponentByStylename("MarrySkillItem.noUse");
         _doUse = ComponentFactory.Instance.creatComponentByStylename("MarrySkillItem.doUse");
         _noActivation = ComponentFactory.Instance.creatComponentByStylename("MarrySkillItem.noActivation");
         _killName = ComponentFactory.Instance.creatComponentByStylename("MarrySkillItem.killName");
         _killItem = ComponentFactory.Instance.creatCustomObject("MarrySkillItem.killItem");
         _noActivation.enable = false;
         addChild(_itemBG);
         addChild(_itemLock);
         addChild(_killItem);
         addChild(_killName);
         addChild(_noUse);
         addChild(_doUse);
         addChild(_noActivation);
         _killName.text = LanguageMgr.GetTranslation("marry.income.MarrySkillItem.skillnametext");
         _noUse.tipData = LanguageMgr.GetTranslation("marry.income.MarrySkillItem.noUse.tipData");
         _noActivation.tipData = LanguageMgr.GetTranslation("marry.income.MarrySkillItem.noActivation.tipdata");
         _itemLock.tipData = LanguageMgr.GetTranslation("marry.income.MarrySkillItem.noActivation.tipdata");
         setState();
      }
      
      private function initEvent() : void
      {
         _noUse.addEventListener("click",__noUseClickHandler);
      }
      
      private function __noUseClickHandler(param1:Event) : void
      {
         MarrySender.skillUse(_skillTemplateName);
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function set data(param1:String) : void
      {
         var _loc2_:MarryTipData = null;
         var _loc3_:int = 0;
         _skillTemplateName = param1;
         arr = TempleteManager.instance.getSkillTemplateInfoByIds(param1);
         if(param1 == model.marriageData.ringInfo.ringSkill)
         {
            _state = 1;
         }
         else
         {
            _state = 2;
         }
         setState();
         _loc2_ = new MarryTipData();
         _loc2_.type = 3;
         _loc2_.skillId = param1;
         _loc2_.grades = 9;
         _loc3_ = 0;
         while(_loc3_ < arr.length)
         {
            skill = arr[_loc3_] as SkillTempInfo;
            if(skill.UseWay == 1)
            {
               _killName.text = skill.TemplateName;
            }
            if(skill.Icons != "")
            {
               _killItem.icon = IconFactory.getMarrySkillIcon(skill.Icons);
            }
            _killItem.tipData = _loc2_;
            _loc3_++;
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function setState() : void
      {
         _noUse.visible = false;
         _doUse.visible = false;
         _noActivation.visible = false;
         switch(_state)
         {
            case 0:
               _noActivation.visible = true;
               break;
            case 1:
               _doUse.visible = true;
               break;
            case 2:
               _noUse.visible = true;
               break;
            default:
               _noUse.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_itemBG)
         {
            _itemBG = null;
         }
         if(_itemLock)
         {
            _itemLock = null;
         }
         if(_killItem)
         {
            _killItem.dispose();
         }
         _killItem = null;
         if(_noUse)
         {
            _noUse.dispose();
         }
         _noUse = null;
         if(_killName)
         {
            _killName.dispose();
         }
         _killName = null;
         if(_doUse)
         {
            _doUse.dispose();
         }
         _doUse = null;
         if(_noActivation)
         {
            _noActivation.dispose();
         }
         _noActivation = null;
         if(skill)
         {
            skill = null;
         }
      }
      
      private function removeEvent() : void
      {
         _noUse.removeEventListener("click",__noUseClickHandler);
      }
   }
}

