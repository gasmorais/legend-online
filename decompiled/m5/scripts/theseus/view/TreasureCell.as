package theseus.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class TreasureCell extends Component implements ISelectable, IManualSize
   {
      
      private var _item:BaseItemView;
      
      private var _light:Bitmap;
      
      private var _selected:Boolean;
      
      private var _data:GoodsInfo;
      
      public function TreasureCell()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,45,45);
      }
      
      public function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("TreasureCell.item");
         _light = ComponentFactory.Instance.creatBitmap("asset.theseus.cellLight");
         addChild(_item);
         addChild(_light);
         _light.visible = false;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         _item.data = _data;
         this.buttonMode = true;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
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
         _light.visible = _selected;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

