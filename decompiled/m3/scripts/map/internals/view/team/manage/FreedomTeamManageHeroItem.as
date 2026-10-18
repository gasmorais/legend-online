package map.internals.view.team.manage
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FreedomTeamEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import managers.FreedomTeamManager;
   import mvc.module.armyII.BaseArmy;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseHeroCell;
   
   public class FreedomTeamManageHeroItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _icon:BaseHeroCell;
      
      private var _levelBack:ScaleBitmapImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _captainFlag:Image;
      
      private var _data:BaseArmy;
      
      private var _filter:UIFilter;
      
      public var index:int;
      
      public function FreedomTeamManageHeroItem()
      {
         super();
         buttonMode = true;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.HeroBack");
         _levelBack = ComponentFactory.Instance.creatComponentByStylename("core.PlayerLevelback");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.LevelTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.NameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.ConsortiaTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("core.armymanage.PlayerIcon");
         _captainFlag = ComponentFactory.Instance.creatComponentByStylename("core.armymanage.CaptainFlag");
         _back.setFrame(1);
         addChild(_back);
         addChild(_icon);
         addChild(_levelBack);
         addChild(_levelTxt);
         addChild(_nameTxt);
         addChild(_consortiaTxt);
         addChild(_captainFlag);
         _captainFlag.visible = false;
         _filter = new UIFilter();
         _icon.type = "head";
         _icon.tipEnable = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__syncTeamInfoHandler);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected && _data)
         {
            _back.setFrame(2);
         }
         else
         {
            _back.setFrame(1);
         }
      }
      
      private function get captainId() : int
      {
         return FreedomTeamManager.instance.model.captainId;
      }
      
      public function set isCaptain(param1:Boolean) : void
      {
         _captainFlag.visible = param1;
      }
      
      private function refresh() : void
      {
         _captainFlag.visible = false;
         if(_data)
         {
            _captainFlag.visible = captainId == _data.baseHero.userId;
            _levelTxt.text = _data.baseHero.grades.toString();
            _nameTxt.text = _data.baseHero.nickName || "";
            _consortiaTxt.text = _data.baseHero.consortiaName || "";
            _icon.data = _data.baseHero;
            _icon.icon.icon = IconFactory.getHeadIcon(_icon.data.headId,"head");
            _icon.visible = true;
            _levelBack.visible = true;
         }
         else
         {
            _back.setFrame(1);
            _levelTxt.text = "";
            _nameTxt.text = "";
            _consortiaTxt.text = "";
            _icon.data = null;
            _icon.visible = false;
            _levelBack.visible = false;
         }
      }
      
      public function set data(param1:BaseArmy) : void
      {
         removeEvent();
         _data = param1;
         addEvent();
         refresh();
         refreshIconFilter();
      }
      
      public function get data() : BaseArmy
      {
         return _data;
      }
      
      private function __syncTeamInfoHandler(param1:FreedomTeamEvent) : void
      {
         refresh();
         refreshIconFilter();
      }
      
      private function refreshIconFilter() : void
      {
         if(!_data)
         {
            _filter.setNormalFilter(this);
            return;
         }
         if(FreedomTeamManager.instance.memberIsOnline(_data.userId))
         {
            _filter.setNormalFilter(this);
         }
         else
         {
            _filter.setGrayFilter(this);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

