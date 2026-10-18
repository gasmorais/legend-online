package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import mvc.module.marry.feels.MarryQuestionInfo;
   
   public class MarryHeartResultItem extends SelectedTextButton implements Disposeable
   {
      
      private var _orderTxt:GradientText;
      
      private var _rightOrWrong:ScaleFrameImage;
      
      private var _data:MarryQuestionInfo;
      
      public function MarryHeartResultItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.backStyle = "asset.marry.heartAnswerItemBack";
         _orderTxt = ComponentFactory.Instance.creatComponentByStylename("MarryHeartResultItem.orderTxt");
         _rightOrWrong = ComponentFactory.Instance.creatComponentByStylename("MarryHeartResultItem.rightOrWrong");
         addChild(_rightOrWrong);
         _rightOrWrong.visible = false;
         addChild(_orderTxt);
      }
      
      public function set order(param1:int) : void
      {
         _orderTxt.text = "" + param1;
      }
      
      public function set data(param1:MarryQuestionInfo) : void
      {
         if(param1 == null)
         {
            _rightOrWrong.visible = false;
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_data.result == 1)
         {
            _rightOrWrong.setFrame(1);
            _rightOrWrong.visible = true;
         }
         else
         {
            _rightOrWrong.setFrame(2);
            _rightOrWrong.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         if(_orderTxt)
         {
            _orderTxt.dispose();
         }
         _orderTxt = null;
         if(_rightOrWrong)
         {
            _rightOrWrong.dispose();
         }
         _rightOrWrong = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

