package sandbox.daylight
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import sandbox.daylight.data.DayLightUserInfo;
   
   public class DayLightGameOverItemView extends Sprite implements Disposeable, ISelectable
   {
      
      private var _overBg:Scale9CornerImage;
      
      private var _lineImg:MutipleImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _killTxt:FilterFrameText;
      
      public var _mvp:MovieClip;
      
      private var _selected:Boolean;
      
      private var _data:DayLightUserInfo;
      
      public function DayLightGameOverItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.overBg");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.lineImg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.nameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.serverNameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.scoreTxt");
         _killTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightGameOverItemView.killTxt");
         addChild(_overBg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_serverNameTxt);
         addChild(_scoreTxt);
         addChild(_killTxt);
         _overBg.visible = false;
         _overBg.mouseChildren = _overBg.mouseEnabled = false;
         _lineImg.mouseChildren = _lineImg.mouseEnabled = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_killTxt);
         _killTxt = null;
         ObjectUtils.disposeObject(_mvp);
         _mvp = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
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
      
      public function get data() : DayLightUserInfo
      {
         return _data;
      }
      
      public function set data(param1:DayLightUserInfo) : void
      {
         _data = param1;
         if(_data)
         {
            this.mouseChildren = this.mouseEnabled = true;
            _nameTxt.text = _data.nickName;
            if(_data.team > 0)
            {
               _nameTxt.setFrame(_data.team);
            }
            _serverNameTxt.text = _data.serverName;
            _scoreTxt.text = _data.score.toString();
            _killTxt.text = _data.repelCount.toString();
            if(_data.isMvp)
            {
               if(!_mvp)
               {
                  _mvp = ComponentFactory.Instance.creatCustomObject("asset.pvpmap.MvpAsset");
                  _mvp.mouseChildren = _mvp.mouseEnabled = false;
                  _mvp.x = 90;
               }
               addChild(_mvp);
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
            _scoreTxt.text = "";
            _killTxt.text = "";
            _overBg.visible = false;
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
         uninitView();
      }
   }
}

