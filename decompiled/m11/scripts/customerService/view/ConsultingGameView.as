package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.manager.ConfigManager;
   
   public class ConsultingGameView extends CustomerServiceBaseView
   {
      
      protected var _systemDesc:Bitmap;
      
      protected var _systemDescTxt:FilterFrameText;
      
      protected var _systemDescBack:ScaleBitmapImage;
      
      public function ConsultingGameView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ConsultingGameView";
      }
      
      override protected function initView() : void
      {
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.DescribeTxt_1");
         addChild(_titleBitmap);
         _cantactBtn = creatBaseButton("customerservice.contactButton");
         if(ConfigManager.info.VOICE)
         {
            _cantactBtn.enable = true;
         }
         else
         {
            _cantactBtn.enable = false;
         }
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.SystemDesc");
         addChild(_loc2_);
         var _loc3_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("customerservice.textInputBack");
         addChild(_loc3_);
         _loc3_.height = 240;
         _loc3_.y = 106;
         var _loc1_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("customerservice.ConsultingGameViewText");
         _loc1_.htmlText = LanguageMgr.GetTranslation("customerService.view.ConsultingGameView.systemDescTxt");
         addChild(_loc1_);
         _submitBtn.enable = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

