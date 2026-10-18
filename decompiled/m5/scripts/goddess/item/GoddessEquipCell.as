package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.goddess.GoddessEquipInfo;
   
   public class GoddessEquipCell extends Component
   {
      
      public var _eqQuilty:ScaleFrameImage;
      
      public var _iconSelect:Bitmap;
      
      public var _equipIcon:ScaleFrameImage;
      
      private var _data:GoddessEquipInfo;
      
      public var nextAdd:int = 0;
      
      public function GoddessEquipCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _eqQuilty = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqQuilty");
         _iconSelect = ComponentFactory.Instance.creatBitmap("asset.goddess.eq.iconSelect");
         _equipIcon = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.equipBit");
         addChild(_equipIcon);
         addChild(_iconSelect);
         addChild(_eqQuilty);
         selected = false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _iconSelect.visible = param1;
      }
      
      public function get data() : GoddessEquipInfo
      {
         return _data;
      }
      
      public function set data(param1:GoddessEquipInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _equipIcon.setFrame(_data.equipType);
            _equipIcon.tipData = _data;
            _eqQuilty.setFrame(_data.equipAdvanceLevel + 1 + nextAdd);
            tipData = _data;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_eqQuilty);
         _eqQuilty = null;
         ObjectUtils.disposeObject(_iconSelect);
         _iconSelect = null;
         ObjectUtils.disposeObject(_equipIcon);
         _equipIcon = null;
         super.dispose();
         _data = null;
      }
   }
}

