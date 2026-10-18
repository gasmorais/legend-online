package consortia.view.myConsortia.contribution
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.consortia.ConsortiaUserInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.ConsortiaPlayerMenu;
   
   public class ConsortiaContributionItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _colorBg:ScaleFrameImage;
      
      private var _rankingTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _resourcext:FilterFrameText;
      
      private var _soulTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _data:ConsortiaUserInfo;
      
      private var _itemLineImg:MutipleImage;
      
      public function ConsortiaContributionItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeItemBg");
         _rankingTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeRankingTextStyle");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeConsortiaNameTextStyle");
         _resourcext = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeConsortiaResourceTextStyle");
         _soulTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeConsortiaSoulTextStyle");
         _itemLineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.ContributeItemLine");
         _colorBg.setFrame(1);
         addChild(_colorBg);
         addChild(_rankingTxt);
         addChild(_nameTxt);
         addChild(_resourcext);
         addChild(_soulTxt);
         addChild(_itemLineImg);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_colorBg);
         _colorBg = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(!_data || _data.nickName == playerInfo.nickName)
         {
            return;
         }
         var _loc3_:ConsortiaPlayerMenu = new ConsortiaPlayerMenu();
         _loc3_.x = StageReferance.stage.mouseX;
         var _loc2_:Point = localToGlobal(new Point(0,height));
         _loc3_.y = _loc2_.y - 10;
         _loc3_.closeRights = false;
         var _loc4_:ThaneInfo = ConsortiaManager.instance.getSimplePlayerInfoByNickname(_data.nickName);
         if(!_loc4_)
         {
            return;
         }
         _loc3_.setData(_loc4_);
         LayerManager.Instance.addToLayer(_loc3_,7);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
            _colorBg.setFrame(2);
         }
         else
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function get data() : ConsortiaUserInfo
      {
         return _data;
      }
      
      public function setdata(param1:ConsortiaUserInfo, param2:Boolean = true) : void
      {
         _data = param1;
         if(_data)
         {
            buttonMode = true;
            _nameTxt.text = _data.nickName;
            _resourcext.text = param2 ? String(_data.totalOffer) : String(_data.todayOffer);
            _soulTxt.text = param2 ? String(_data.totalSpirit) : String(_data.todaySpirit);
         }
         else
         {
            _rankingTxt.text = "";
            _nameTxt.text = "";
            _resourcext.text = "";
            _soulTxt.text = "";
            buttonMode = false;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
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
      
      public function get rankingTxt() : FilterFrameText
      {
         return _rankingTxt;
      }
      
      public function set rankingTxt(param1:FilterFrameText) : void
      {
         _rankingTxt = param1;
      }
   }
}

