package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   
   public class PokerCardView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _patternBmp:Bitmap;
      
      private var _suit:int;
      
      private var _rank:int;
      
      private var _cardNum:MovieClip;
      
      public function PokerCardView(param1:int = 0, param2:int = 0)
      {
         super();
         _suit = param1;
         _rank = param2;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.poker.card" + (_suit + 1));
         _patternBmp = ComponentFactory.Instance.creatBitmap("asset.poker.pattern" + (_suit + 1));
         _cardNum = ComponentFactory.Instance.creatCustomObject("poker.cardNum" + (_suit + 1));
         addChild(_bg);
         addChild(_patternBmp);
         addChild(_cardNum);
         _bg.smoothing = true;
         _patternBmp.smoothing = true;
         _cardNum.transform.matrix = null;
         _cardNum.gotoAndStop(_rank + 1);
      }
      
      public function get suit() : int
      {
         return _suit;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_patternBmp);
         _patternBmp = null;
         ObjectUtils.disposeViolentMc(_cardNum);
         _cardNum = null;
         super.dispose();
      }
   }
}

