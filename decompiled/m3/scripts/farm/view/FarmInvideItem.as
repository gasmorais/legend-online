package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class FarmInvideItem extends Component
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _invideBtn:SelectedButton;
      
      private var _lineImg:Bitmap;
      
      private var _selected:Boolean = true;
      
      private var _data:ThaneInfo;
      
      private var _invidedTxt:FilterFrameText;
      
      public function FarmInvideItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function addEvent() : void
      {
         _invideBtn.addEventListener("click",onSelectBtnClick);
      }
      
      private function removeEvent() : void
      {
         if(_invideBtn)
         {
            _invideBtn.removeEventListener("click",onSelectBtnClick);
         }
      }
      
      private function onSelectBtnClick(param1:Event) : void
      {
         _selected = _invideBtn.selected;
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data == null)
         {
            return;
         }
         updateView();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _invideBtn.selected = selected;
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("core.SexIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("farm.invide.ItemNameText");
         _invideBtn = ComponentFactory.Instance.creatComponentByStylename("farm.Invide.SelectButton");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.farm.invide.InvideItemLine");
         _invidedTxt = ComponentFactory.Instance.creatComponentByStylename("farm.view.invidedTxt");
         _invidedTxt.text = LanguageMgr.GetTranslation("farm.view.invidedTxt");
         addChild(_icon);
         _icon.x = 10;
         addChild(_nameText);
         addChild(_invideBtn);
         addChild(_lineImg);
         addChild(_invidedTxt);
         _invideBtn.selected = selected;
      }
      
      public function updateView() : void
      {
         _data.sexs == 0 ? _icon.setFrame(2) : _icon.setFrame(1);
         _nameText.text = _data.nickName;
         _invidedTxt.visible = false;
         _invideBtn.visible = true;
      }
      
      public function invide() : void
      {
         _invidedTxt.visible = true;
         _invideBtn.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_invideBtn);
         _invideBtn = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

