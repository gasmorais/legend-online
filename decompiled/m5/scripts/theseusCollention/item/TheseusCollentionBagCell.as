package theseusCollention.item
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class TheseusCollentionBagCell extends Component implements ISelectable, IManualSize
   {
      
      public static const NAME:String = "heseusCollention.item.TheseusCollentionBagCell";
      
      private var _item:BaseItemView;
      
      private var _light:Bitmap;
      
      private var _chip:Bitmap;
      
      private var _selected:Boolean;
      
      private var _data:GoodsInfo;
      
      protected var _registed:Boolean;
      
      protected var _mediatorKey:String;
      
      protected var _itemText:FilterFrameText;
      
      public function TheseusCollentionBagCell()
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
         _chip = ComponentFactory.Instance.creatBitmap("asset.theseus.cellLight");
         _itemText = ComponentFactory.Instance.creatComponentByStylename("core.BaseItemText");
         addChild(_item);
         addChild(_itemText);
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
         setItemText(_data.count);
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
         if(_light)
         {
            _light.visible = _selected;
         }
      }
      
      public function setItemText1(param1:String, param2:Boolean = false) : void
      {
         if(_itemText)
         {
            _itemText.htmlText = param1;
         }
         if(param2)
         {
            _itemText.x = -31;
            _itemText.width = 77;
         }
      }
      
      public function setItemText(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 0)
         {
            if(_itemText)
            {
               _itemText.text = "";
            }
            return;
         }
         var _loc3_:Number = param1 / 1000;
         if(param1 % 1000 == 0)
         {
            if(_loc3_ >= 1)
            {
               _loc2_ = int(_loc3_) + "k";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = _loc3_.toFixed(1) + "k";
         }
         else if(_loc3_ > 10)
         {
            _loc2_ = int(_loc3_) + "k";
         }
         else
         {
            _loc2_ = param1.toString();
         }
         if(_itemText)
         {
            _itemText.htmlText = _loc2_;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemText);
         _itemText = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_chip);
         _chip = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

