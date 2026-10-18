package eclipticpalace
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.EclipticPalaceManager;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import yishi.filter.UIFilter;
   
   public class EclipticPalaceLayerProcessView extends Component
   {
      
      private var _lineHbox:HBox;
      
      private var _palaceHbox:HBox;
      
      public function EclipticPalaceLayerProcessView()
      {
         super();
         initView();
         initListView();
         refreshView();
      }
      
      private function initView() : void
      {
         _lineHbox = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceLayerProcessView.lineHbox");
         _palaceHbox = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceLayerProcessView.palaceHbox");
         addChild(_lineHbox);
         addChild(_palaceHbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc3_:Bitmap = null;
         _loc2_ = 1;
         while(_loc2_ <= 12)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceLayerProcessView.line");
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.EclipticPalace.titleImage.titleImage" + _loc2_);
            _loc3_.scaleX = _loc3_.scaleY = 0.5;
            if(_loc2_ != 12)
            {
               _lineHbox.addChild(_loc1_);
            }
            _palaceHbox.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         _loc2_ = 0;
         while(_loc2_ < 11)
         {
            _loc1_ = _lineHbox.getChildAt(_loc2_) as Bitmap;
            _loc1_.visible = model.curLayer > _loc2_ + 1 ? true : false;
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc4_ = _palaceHbox.getChildAt(_loc3_) as Bitmap;
            if(_loc3_ + 1 < model.curLayer)
            {
               _loc4_.alpha = 1;
               _loc4_.filters = [UIFilter.getGrayFilter()];
            }
            else if(_loc3_ + 1 == model.curLayer)
            {
               _loc4_.alpha = 1;
               _loc4_.filters = [UIFilter.getLightingFilter()];
            }
            else
            {
               _loc4_.alpha = 0.5;
               _loc4_.filters = [];
            }
            _loc3_++;
         }
      }
      
      private function get model() : EclipticPalaceModel
      {
         return EclipticPalaceManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_lineHbox);
         _lineHbox = null;
         ObjectUtils.disposeObject(_palaceHbox);
         _palaceHbox = null;
         super.dispose();
      }
   }
}

