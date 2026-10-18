package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class ChildEquipAttItem extends Component
   {
      
      private var _button:SelectedButton;
      
      private var _text:FilterFrameText;
      
      private var _addTxt:FilterFrameText;
      
      private var _upBg:Bitmap;
      
      private var _isRefresh:Boolean;
      
      private var _selected:Boolean;
      
      public function ChildEquipAttItem(param1:Boolean = false)
      {
         _isRefresh = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _button = ComponentFactory.Instance.creatComponentByStylename("ChildEquipAttItem.selectBtn");
         _text = ComponentFactory.Instance.creatComponentByStylename("ChildEquipAttItem.text");
         _addTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEquipAttItem.upTxt");
         _upBg = ComponentFactory.Instance.creatBitmap("asset.chil.equipAtt.UpImage");
         addChild(_button);
         addChild(_text);
         addChild(_addTxt);
         addChild(_upBg);
         _button.visible = _isRefresh;
         upTip = false;
      }
      
      public function set text(param1:String) : void
      {
         if(_text)
         {
            _text.text = param1;
            _addTxt.x = _text.x + _text.textWidth + 20;
         }
      }
      
      public function set addTxt(param1:String) : void
      {
         if(_addTxt)
         {
            _addTxt.text = param1;
            _upBg.x = _addTxt.width + _addTxt.x;
         }
      }
      
      private function initEvent() : void
      {
         if(_isRefresh && _button)
         {
            _button.addEventListener("select",__selectedHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_button)
         {
            _button.removeEventListener("select",__selectedHandler);
         }
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         _selected = _button.selected;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_button)
         {
            _button.selected = _selected;
         }
      }
      
      public function set upTip(param1:Boolean) : void
      {
         if(_upBg)
         {
            _upBg.visible = param1;
         }
         if(_addTxt)
         {
            _addTxt.visible = param1;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_button);
         _button = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_addTxt);
         _addTxt = null;
         ObjectUtils.disposeObject(_upBg);
         _upBg = null;
         super.dispose();
      }
   }
}

