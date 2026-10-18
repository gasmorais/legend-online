package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.DayGuideManager;
   import mvc.module.dayGuide.LeedInfo;
   
   public class LimitedItemsView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _title:ScaleFrameImage;
      
      protected var _numTxt:FilterFrameText;
      
      protected var _vBox:VBox;
      
      private var _maxSore:int;
      
      public function LimitedItemsView(param1:int)
      {
         super();
         _maxSore = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.UncompleteImgBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("dayGuide.LimitedItemsTitleImg");
         _title.setFrame(_maxSore / 100);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("dayGuide.ProjectNum" + _maxSore / 100);
         addChild(_bg);
         addChild(_title);
         addChild(_numTxt);
         _numTxt.text = "12";
         _vBox = new VBox();
         _vBox.spacing = 6;
         _vBox.x = 7;
         _vBox.y = 33;
         addChild(_vBox);
      }
      
      public function set data(param1:Vector.<LeedInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ProjectItem = null;
         var _loc3_:Array = [];
         for each(var _loc5_:LeedInfo in param1)
         {
            if(_maxSore - 100 <= _loc5_.sort && _loc5_.sort < _maxSore)
            {
               _loc3_.push(_loc5_);
            }
         }
         _loc3_.sortOn(["isComplete","sort"],[16,16]);
         _numTxt.text = _loc3_.length.toString();
         _vBox.disposeAllChildren();
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(DayGuideManager.instance.getCurrConditionType().indexOf((_loc3_[_loc4_] as LeedInfo).type + "") != -1)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("dayGuide.ProjectItem");
               _loc2_.data = _loc3_[_loc4_];
               _vBox.addChild(_loc2_);
            }
            _loc4_++;
         }
         _vBox.refreshChildPos();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeAllChildren(_vBox);
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

