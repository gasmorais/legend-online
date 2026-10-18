package goldenDionysia.middleInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import yishi.utils.NumberViewUtils;
   
   public class MillionNumContainer extends Component
   {
      
      private var _winDiamondNum:Number = -1;
      
      private var _numContainer:Sprite;
      
      private var _numBmd:BitmapData;
      
      private var _containerWidth:Number;
      
      public function MillionNumContainer()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
         _numBmd = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.rewardNum").bitmapData;
         _numContainer = new Sprite();
         addChild(_numContainer);
      }
      
      public function get containerWidth() : Number
      {
         return _containerWidth;
      }
      
      public function updateUI(param1:Number) : void
      {
         if(_winDiamondNum != param1)
         {
            _winDiamondNum = param1;
            _containerWidth = _winDiamondNum.toString().length * 16;
            NumberViewUtils.getNumberView(_winDiamondNum,_numContainer,_numBmd,16,22,16,16,"0123456789.",1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numContainer);
         _numContainer = null;
         ObjectUtils.disposeObject(_numBmd);
         _numBmd = null;
         super.dispose();
      }
   }
}

