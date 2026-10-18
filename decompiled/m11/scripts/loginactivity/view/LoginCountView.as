package loginactivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.funny.FunnyModel;
   
   public class LoginCountView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleBack:Bitmap;
      
      private var _loginDate:FilterFrameText;
      
      private var _reward:FilterFrameText;
      
      private var _itemContiner:VBox;
      
      private var _items:Array;
      
      public function LoginCountView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("loginActive.FrameBack");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.countlogin.TitleAsset");
         _itemContiner = ComponentFactory.Instance.creatComponentByStylename("loginActive.Contain");
         _loginDate = ComponentFactory.Instance.creatComponentByStylename("loginActive.LoginDate");
         _reward = ComponentFactory.Instance.creatComponentByStylename("loginActive.Reward");
         addChild(_back);
         addChild(_titleBack);
         addChild(_loginDate);
         addChild(_reward);
         addChild(_itemContiner);
         _loginDate.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.loginDateText");
         _reward.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.rewardText");
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:LoginActiveItem = null;
         var _loc3_:FunnyBagData = null;
         var _loc2_:Bitmap = null;
         _itemContiner.removeAllChild();
         var _loc5_:FunnyData = model.loginActiveData;
         if(!_loc5_)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.bagList.length)
         {
            _loc1_ = new LoginActiveItem();
            _loc3_ = _loc5_.bagList[_loc4_] as FunnyBagData;
            _loc1_.data = _loc3_;
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.countlogin.LineAsset");
            _itemContiner.addChild(_loc1_);
            if(_loc4_ < 6)
            {
               _itemContiner.addChild(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function get model() : FunnyModel
      {
         return FunnyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         _items = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_titleBack)
         {
            ObjectUtils.disposeObject(_titleBack);
         }
         _titleBack = null;
         if(_itemContiner)
         {
            ObjectUtils.disposeObject(_itemContiner);
         }
         _itemContiner = null;
         if(_loginDate)
         {
            ObjectUtils.disposeObject(_loginDate);
         }
         _loginDate = null;
         if(_reward)
         {
            ObjectUtils.disposeObject(_reward);
         }
         _reward = null;
         super.dispose();
      }
   }
}

