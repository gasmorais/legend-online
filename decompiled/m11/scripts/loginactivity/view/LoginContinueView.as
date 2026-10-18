package loginactivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import managers.FunnyManager;
   import mvc.module.funny.FunnyModel;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.view.component.TileContainer;
   
   public class LoginContinueView extends Component
   {
      
      private var _timeText:FilterFrameText;
      
      private var _countImage:Bitmap;
      
      private var _dayContiner:Component;
      
      private var _numBitmap:BitmapData;
      
      private var _border:ScaleBitmapImage;
      
      private var _itemContiner:TileContainer;
      
      private var itemList:Vector.<LoginContinueItem>;
      
      public function LoginContinueView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _timeText = ComponentFactory.Instance.creatComponentByStylename("LoginContinueView.timeText");
         _countImage = ComponentFactory.Instance.creatBitmap("asset.LoginContinueView.countImage");
         _dayContiner = ComponentFactory.Instance.creatCustomObject("LoginContinueView.dayContiner");
         _numBitmap = ComponentFactory.Instance.creatBitmapData("asset.LoginContinueView.numBitmap");
         _border = ComponentFactory.Instance.creatComponentByStylename("LoginContinueView.border");
         _itemContiner = ComponentFactory.Instance.creatCustomObject("LoginContinueView.itemContiner");
         addChild(_timeText);
         addChild(_countImage);
         addChild(_dayContiner);
         addChild(_border);
         addChild(_itemContiner);
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:LoginContinueItem = null;
         var _loc2_:FunnyBagData = null;
         _itemContiner.removeAllChildren();
         var _loc4_:FunnyData = model.continueLoginData;
         if(!_loc4_)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.bagList.length)
         {
            _loc1_ = new LoginContinueItem();
            _loc2_ = _loc4_.bagList[_loc3_] as FunnyBagData;
            _loc1_.data = _loc2_;
            _itemContiner.appendItem(_loc1_);
            _loc3_++;
         }
         _timeText.text = DateFormatter.transDate(_loc4_.startTime / 1000) + "--" + DateFormatter.transDate(_loc4_.endTime / 1000);
         NumberViewUtils.refreshValue(_loc4_.finishNum,_dayContiner,_numBitmap,18,24,14,18,"0123456789");
      }
      
      private function get model() : FunnyModel
      {
         return FunnyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_countImage);
         _countImage = null;
         ObjectUtils.disposeObject(_dayContiner);
         _dayContiner = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_itemContiner);
         _itemContiner = null;
         super.dispose();
      }
   }
}

