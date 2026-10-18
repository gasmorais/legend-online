package steel.view.search
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.SteelTeamInfo;
   
   public class SteelTeamInfoItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _colorBg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _hostNickNameTxt:FilterFrameText;
      
      private var _fightPowerTxt:FilterFrameText;
      
      private var _checkBtn:SelectedButton;
      
      private var _lineImg:MutipleImage;
      
      private var _spaceTxt:FilterFrameText;
      
      private var _checked:Boolean;
      
      private var _hitSprite:Sprite;
      
      private var _data:SteelTeamInfo;
      
      public function SteelTeamInfoItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaItemColorBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelTeamInfoItem.TeamNameTxt");
         _hostNickNameTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelTeamInfoItem.HostNickNameTxt");
         _fightPowerTxt = ComponentFactory.Instance.creatComponentByStylename("steel.SteelTeamInfoItem.FightPowerTxt");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.itemLine_2");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAddCheckBtn");
         _hitSprite = new Sprite();
         hitArea = _hitSprite;
         _spaceTxt = new FilterFrameText();
         buttonMode = true;
         _colorBg.setFrame(1);
         addChild(_colorBg);
         addChild(_nameTxt);
         addChild(_hostNickNameTxt);
         addChild(_fightPowerTxt);
         addChild(_lineImg);
         addChild(_spaceTxt);
         addChild(_checkBtn);
         addChild(_hitSprite);
         _spaceTxt.y = 4;
      }
      
      private function setHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(40,0,409,29);
         _hitSprite.y = 10;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         _checkBtn.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         _checkBtn.removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(_checkBtn.selected)
         {
            _checkBtn.selected = false;
            _checked = false;
         }
         else
         {
            _checkBtn.selected = true;
            _checked = true;
         }
      }
      
      public function get data() : SteelTeamInfo
      {
         return _data;
      }
      
      public function set data(param1:SteelTeamInfo) : void
      {
         _data = param1;
         if(param1 == null)
         {
            _checkBtn.visible = false;
         }
         else
         {
            _checkBtn.visible = true;
         }
         refreshView();
         setHitArea();
      }
      
      private function refreshView() : void
      {
         _colorBg.setFrame(1);
         if(_data)
         {
            setValue();
         }
         else
         {
            clear();
         }
      }
      
      private function setValue() : void
      {
         buttonMode = true;
         _nameTxt.text = LanguageMgr.GetTranslation("steel.view.member.SteelMemberFrame.TeamName",_data.teamName);
         _hostNickNameTxt.text = _data.hostNickName;
         _fightPowerTxt.text = _data.fightPower.toString();
      }
      
      private function clear() : void
      {
         _nameTxt.text = "";
         _hostNickNameTxt.text = "";
         _fightPowerTxt.text = "";
         buttonMode = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         _spaceTxt = null;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get checked() : Boolean
      {
         return _checkBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected && _data)
         {
            _colorBg.setFrame(2);
         }
         else
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function setCheckState(param1:Boolean) : void
      {
         _checkBtn.selected = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}

