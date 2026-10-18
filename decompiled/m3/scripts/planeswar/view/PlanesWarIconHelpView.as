package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   
   public class PlanesWarIconHelpView extends Component
   {
      
      private var back:ScaleBitmapImage;
      
      private var vBox:VBox;
      
      private var iconArray:Array = [4,5,11,7,6,13,101,102,103];
      
      private var _showState:Boolean = false;
      
      public function PlanesWarIconHelpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Component = null;
         var _loc3_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         back = ComponentFactory.Instance.creatComponentByStylename("PlanesWarIconHelpView.back");
         vBox = ComponentFactory.Instance.creatComponentByStylename("PlanesWarIconHelpView.vBox");
         addChild(back);
         addChild(vBox);
         _loc4_ = 0;
         while(_loc4_ < iconArray.length)
         {
            _loc5_ = int(iconArray[_loc4_]);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("PlanesWarIconHelpView.rowContiner");
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.PlanesWarIconHelpView.icon" + _loc5_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("PlanesWarIconHelpView.iconText");
            _loc1_.text = LanguageMgr.GetTranslation("PlanesWarIconHelpView.iconText.text" + _loc5_);
            if(_loc5_ > 100)
            {
               _loc3_.scaleX = _loc3_.scaleY = 0.75;
            }
            _loc2_.addChild(_loc3_);
            _loc2_.addChild(_loc1_);
            vBox.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      public function set showState(param1:Boolean) : void
      {
         if(_showState == param1)
         {
            return;
         }
         _showState = param1;
         if(_showState)
         {
            this.visible = true;
         }
         else
         {
            this.visible = false;
         }
      }
      
      public function get showState() : Boolean
      {
         return _showState;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(vBox);
         vBox = null;
         super.dispose();
      }
   }
}

