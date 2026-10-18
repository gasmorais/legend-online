package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GoddessAdvanceItem extends Sprite
   {
      
      private var _title:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _panel:ScrollPanel;
      
      private var _line:Bitmap;
      
      private var _desText:FilterFrameText;
      
      private var _titleIdx:int;
      
      private var _fullImg:Image;
      
      private var _data:GoddessAdvaceTempInfo;
      
      private var _reg:RegExp = /[0-9%]+/g;
      
      public function GoddessAdvanceItem(param1:int)
      {
         super();
         _titleIdx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.AdvanceItemTitle");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.goddess.advanceSkillIcon");
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advance.scrollPanel");
         _line = ComponentFactory.Instance.creatBitmap("asset.goddess.advance.line");
         _desText = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceSkTxt");
         _fullImg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.advanceFullImg");
         addChild(_title);
         addChild(_icon);
         addChild(_line);
         addChild(_panel);
         addChild(_fullImg);
         _fullImg.visible = false;
         _title.setFrame(_titleIdx);
         _desText.setFrame(_titleIdx);
         _panel.setView(_desText);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_fullImg);
         _fullImg = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function get data() : GoddessAdvaceTempInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessAdvaceTempInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data == null)
         {
            _icon.visible = false;
            _panel.visible = false;
            _title.visible = false;
            _line.visible = false;
            _desText.visible = false;
            _fullImg.visible = true;
         }
         else
         {
            _fullImg.visible = false;
            _icon.visible = true;
            _panel.visible = true;
            _title.visible = true;
            _line.visible = true;
            _desText.visible = true;
            _icon.icon = IconFactory.getTecIconByIcon(_data.skillTemp.Icons);
            _icon.tipData = _data.skillTemp;
            _desText.htmlText = changeNumColor(_data.skillTemp.Description);
            _desText.height = _desText.numLines * 19;
            _panel.invalidateViewport();
         }
      }
      
      private function changeNumColor(param1:String) : String
      {
         return param1.replace(_reg,regFun);
      }
      
      private function regFun() : String
      {
         return "<font color=\'#00ff00\'>" + arguments[0] + "</font>";
      }
   }
}

