package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   
   public class PriceItem extends Component
   {
      
      private var _priceTxt:FilterFrameText;
      
      private var _icon:DisplayObject;
      
      private var _price:int;
      
      private var _index:int;
      
      public function PriceItem()
      {
         super();
         initview();
      }
      
      private function initview() : void
      {
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("numbuy.priceValueTextStyle");
         addChild(_priceTxt);
      }
      
      public function show(param1:int, param2:int = 0, param3:Object = null) : void
      {
         switch(param2)
         {
            case 0:
               _icon = ComponentFactory.Instance.creatBitmap("asset.numbuy.diamond");
               break;
            case 1:
               _icon = ComponentFactory.Instance.creatBitmap("asset.numbuy.integral");
               break;
            case 2:
               _icon = ComponentFactory.Instance.creatComponentByStylename("numbuy.PetSymbolImg");
               _icon["setFrame"](param3);
               break;
            case 3:
               _icon = ComponentFactory.Instance.creatBitmap("asset.core.FashionPiece");
               break;
            case 4:
               _icon = ComponentFactory.Instance.creatBitmap("asset.core.mountConversion");
               break;
            case 7:
               _icon = ComponentFactory.Instance.creatBitmap("asset.numbuy.GemDust");
         }
         _icon.x = _priceTxt.x + _priceTxt.textWidth + 3;
         addChild(_icon);
         setPrice(param1);
      }
      
      public function setFrame(param1:int = 1) : void
      {
         _index = param1;
         _priceTxt.setFrame(param1);
      }
      
      public function getFrame() : int
      {
         return _index;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function setPrice(param1:int) : void
      {
         _price = param1;
         _priceTxt.text = param1 + "";
         _icon.x = _priceTxt.x + _priceTxt.textWidth + 3;
      }
   }
}

