package blackjack
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class BlackjackCard extends Component
   {
      
      private var _num:int;
      
      private var _bg:Bitmap;
      
      private var _cardNum:Bitmap;
      
      private var _reverseNum:Bitmap;
      
      public function BlackjackCard()
      {
         super();
      }
      
      public function set num(param1:int) : void
      {
         _num = param1 / 13;
         _bg = ComponentFactory.Instance.creatBitmap("asset.blackjack.card" + (_num + 1));
         addChild(_bg);
         _num = param1 % 13;
         _cardNum = ComponentFactory.Instance.creatBitmap("asset.blackjack.cardNum" + _num);
         _reverseNum = ComponentFactory.Instance.creatBitmap("asset.blackjack.reverseNum" + _num);
         _cardNum.x = 9;
         _cardNum.y = 9;
         _reverseNum.x = 79;
         _reverseNum.y = 116;
         addChild(_cardNum);
         addChild(_reverseNum);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_cardNum);
         _cardNum = null;
         ObjectUtils.disposeObject(_reverseNum);
         _reverseNum = null;
         super.dispose();
      }
   }
}

