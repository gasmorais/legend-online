package map.campaign.view.ui.flametemple
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.WarFightOrderInfo;
   
   public class FlameTempleGameOverItemView extends Sprite implements Disposeable, ISelectable
   {
      
      private var _overBg:Scale9CornerImage;
      
      private var _lineImg:MutipleImage;
      
      private var _flameIcon:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _killTxt:FilterFrameText;
      
      private var _honnerTxt:FilterFrameText;
      
      public var _mvp:MovieClip;
      
      private var _data:WarFightOrderInfo;
      
      private var _selected:Boolean;
      
      public function FlameTempleGameOverItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.overBg");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.lineImg");
         _flameIcon = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.FlameIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.nameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.serverNameTxt");
         _killTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.killTxt");
         _honnerTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleGameOverItemView.honnerTxt");
         addChild(_overBg);
         addChild(_lineImg);
         addChild(_flameIcon);
         addChild(_nameTxt);
         addChild(_serverNameTxt);
         addChild(_killTxt);
         addChild(_honnerTxt);
         _overBg.visible = false;
         _overBg.mouseChildren = _overBg.mouseEnabled = false;
         _lineImg.mouseChildren = _lineImg.mouseEnabled = false;
         _flameIcon.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.flametemple.FlameTempleGameOverItemView.FlameIconTips",5,10);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_flameIcon);
         _flameIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_killTxt);
         _killTxt = null;
         ObjectUtils.disposeObject(_honnerTxt);
         _honnerTxt = null;
         ObjectUtils.disposeObject(_mvp);
         _mvp = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : WarFightOrderInfo
      {
         return _data;
      }
      
      public function set data(param1:WarFightOrderInfo) : void
      {
         _data = param1;
         if(_data)
         {
            this.mouseChildren = this.mouseEnabled = true;
            _nameTxt.text = _data.nickName;
            if(_data.teamId > 0)
            {
               _nameTxt.setFrame(_data.teamId);
            }
            _serverNameTxt.text = _data.serverName;
            _killTxt.text = _data.hitCount.toString();
            _honnerTxt.text = _data.geste.toString();
            _flameIcon.visible = _data.param1 > 0 ? true : false;
            if(_data.isMvp)
            {
               if(!_mvp)
               {
                  _mvp = ComponentFactory.Instance.creatCustomObject("asset.pvpmap.MvpAsset");
                  _mvp.mouseChildren = _mvp.mouseEnabled = false;
               }
               addChild(_mvp);
               if(_flameIcon.visible)
               {
                  _mvp.x = _flameIcon.x + _flameIcon.width;
               }
               else
               {
                  _mvp.x = _flameIcon.x;
               }
            }
            else if(_mvp && _mvp.parent == this)
            {
               _mvp.parent.removeChild(_mvp);
            }
         }
         else
         {
            this.mouseChildren = this.mouseEnabled = false;
            _nameTxt.text = "";
            _serverNameTxt.text = "";
            _killTxt.text = "";
            _honnerTxt.text = "";
            _overBg.visible = false;
            _flameIcon.visible = false;
            if(_mvp && _mvp.parent)
            {
               _mvp.parent.removeChild(_mvp);
            }
         }
      }
      
      public function mouseOut() : void
      {
         if(selected)
         {
            return;
         }
         if(_overBg)
         {
            _overBg.visible = false;
         }
      }
      
      public function mouseOver() : void
      {
         if(selected)
         {
            return;
         }
         if(_overBg)
         {
            _overBg.visible = true;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
         ObjectUtils.disposeAllChildren(this);
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
         if(_overBg)
         {
            _overBg.visible = param1;
         }
      }
   }
}

