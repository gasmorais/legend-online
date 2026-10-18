package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import yishi.filter.UIFilter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseHeroCell;
   
   public class ArmyManageHeroItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _back:ScaleFrameImage;
      
      private var _icon:BaseHeroCell;
      
      private var _levelBack:ScaleBitmapImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _captainFlag:Image;
      
      private var _data:CampaignArmy;
      
      private var _filter:UIFilter;
      
      private var _state:int;
      
      public var index:int;
      
      public function ArmyManageHeroItem()
      {
         super();
         buttonMode = true;
         init();
      }
      
      private function init() : void
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
         _filter = new UIFilter();
         _icon.type = "head";
         _icon.tipEnable = false;
      }
      
      private function initEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("ONLINE_STATE",__onlineStateHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("ONLINE_STATE",__onlineStateHandler);
         }
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
      
      private function get houseOwnerId() : int
      {
         return RoomManager.instance.roomInfo.houseOwnerId;
      }
      
      public function set isHouseOwner(param1:Boolean) : void
      {
         _captainFlag.visible = param1;
      }
      
      private function refresh() : void
      {
         _captainFlag.visible = false;
         if(_data)
         {
            _captainFlag.visible = houseOwnerId == _data.baseHero.userId;
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
      
      public function set data(param1:CampaignArmy) : void
      {
         refreshIconFilter();
         removeEvent();
         _data = param1;
         initEvent();
         refresh();
         __onlineStateHandler(null);
      }
      
      private function __onlineStateHandler(param1:CampaignMapEvent) : void
      {
         if(!_data)
         {
            return;
         }
         refreshIconFilter();
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         refreshIconFilter();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      private function refreshIconFilter() : void
      {
         if(_state == -1 || _data && !_data.online)
         {
            _filter.setGrayFilter(this);
         }
         else
         {
            _filter.setNormalFilter(this);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

