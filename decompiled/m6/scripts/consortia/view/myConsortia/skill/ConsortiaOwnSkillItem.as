package consortia.view.myConsortia.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaTemplete;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ConsortiaOwnSkillItem extends Component implements Disposeable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _iconBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _upgradeType:int;
      
      private var _level:int;
      
      private var _temp:ConsortiaTemplete;
      
      private var _icon:BaseIconView;
      
      public function ConsortiaOwnSkillItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ownItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.OwnSkillNameTextStyle");
         _icon = ComponentFactory.Instance.creatCustomObject("consortia.OwnSkillBaseIconView");
         addChild(_bg);
         _nameTxt.text = "";
         addChild(_nameTxt);
         addChild(_icon);
      }
      
      private function uninit() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_iconBg)
         {
            ObjectUtils.disposeObject(_iconBg);
         }
         _iconBg = null;
         _temp = null;
      }
      
      private function addEvent() : void
      {
         playerInfo.addEventListener("CONSORTIA_STUDY",__onOwnSkillUpdata);
      }
      
      private function removeEvent() : void
      {
         playerInfo.removeEventListener("CONSORTIA_STUDY",__onOwnSkillUpdata);
      }
      
      private function __onOwnSkillUpdata(param1:ConsortiaEvent) : void
      {
         if(param1.data == _upgradeType)
         {
            param1.stopImmediatePropagation();
            refreshView();
         }
      }
      
      public function set data(param1:Array) : void
      {
         if(param1[0] is String)
         {
            _level = playerInfo[param1[0]];
         }
         else
         {
            _level = param1[0];
         }
         _upgradeType = param1[1];
         refreshView();
      }
      
      override public function get isFollowMouse() : Boolean
      {
         return false;
      }
      
      override public function get tipDirctions() : String
      {
         return "4,6,5,7";
      }
      
      override public function get tipStyle() : String
      {
         return "yishi.view.tips.OneLineTip";
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function refreshView() : void
      {
         _temp = TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(_upgradeType,_level);
         if(isCommonSkill(_temp.Types))
         {
            _bg.setFrame(1);
         }
         else
         {
            _bg.setFrame(2);
         }
         _icon.icon = IconFactory.getTecIconByIcon(_temp.Icon);
         _nameTxt.text = _temp.LevelName + " " + LanguageMgr.GetTranslation("public.level4_space",String(_temp.Levels));
         tipData = _temp.Description;
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
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
      
      public function get upgradeType() : int
      {
         return _upgradeType;
      }
   }
}

