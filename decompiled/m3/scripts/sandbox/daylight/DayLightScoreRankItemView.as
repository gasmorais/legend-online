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
   import flash.display.Sprite;
   import sandbox.daylight.data.DayLightUserInfo;
   
   public class DayLightScoreRankItemView extends Sprite implements Disposeable, ISelectable
   {
      
      private var _overBg:Scale9CornerImage;
      
      private var _lineImg:MutipleImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _killTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _data:DayLightUserInfo;
      
      public function DayLightScoreRankItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.overBg");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.lineImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.nameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.serverNameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.scoreTxt");
         _killTxt = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightScoreRankItemView.killTxt");
         _nameTxt.mouseEnabled = true;
         _nameTxt.selectable = false;
         addChild(_overBg);
         addChild(_lineImg);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_serverNameTxt);
         addChild(_scoreTxt);
         addChild(_killTxt);
         _overBg.mouseChildren = _overBg.mouseEnabled = false;
         _lineImg.mouseChildren = _lineImg.mouseEnabled = false;
         _rankTxt.text = "09";
         _nameTxt.htmlText = "达斯爱爱";
         _serverNameTxt.text = "第七大道-80{invalid_utf8=229}{invalid_utf8=140}?";
         _scoreTxt.text = "99999";
         _killTxt.text = "888";
         _overBg.visible = false;
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_serverNameTxt);
         _serverNameTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_killTxt);
         _killTxt = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function mouseOver() : void
      {
         if(selected)
         {
            return;
         }
         if(_overBg)
         {
            _overBg.visible = _data != null;
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
      
      public function mouseClick() : void
      {
         selected = true;
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
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get data() : DayLightUserInfo
      {
         return _data;
      }
      
      public function set data(param1:DayLightUserInfo) : void
      {
         _data = param1;
         if(param1)
         {
            this.mouseChildren = this.mouseEnabled = true;
            _rankTxt.text = "" + param1.order;
            _nameTxt.text = param1.nickName;
            if(param1.team > 0)
            {
               _nameTxt.setFrame(param1.team);
            }
            _serverNameTxt.text = param1.serverName;
            _scoreTxt.text = param1.score + "";
            _killTxt.text = param1.repelCount + "";
         }
         else
         {
            this.mouseChildren = this.mouseEnabled = false;
            _rankTxt.text = "";
            _nameTxt.text = "";
            _serverNameTxt.text = "";
            _scoreTxt.text = "";
            _killTxt.text = "";
            _overBg.visible = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
         _data = null;
      }
   }
}

