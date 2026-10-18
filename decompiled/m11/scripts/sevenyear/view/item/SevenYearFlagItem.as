package sevenyear.view.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mainBar.StripView;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.NumberViewUtils;
   
   public class SevenYearFlagItem extends Component
   {
      
      private var bg:ScaleFrameImage;
      
      private var _numBitmap:Bitmap;
      
      private var _numContainer:StripView;
      
      private var configArr:Array;
      
      public function SevenYearFlagItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         configArr = ConfigInfoManager.instance.getSevenYearFlagBgConfig();
         bg = ComponentFactory.Instance.creatComponentByStylename("SevenYear.flag");
         bg.setFrame(1);
         _numBitmap = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.numberbmp");
         _numContainer = ComponentFactory.Instance.creatCustomObject("SevenYearBattleFlagView.numContainer");
         addChild(bg);
         addChild(_numContainer);
      }
      
      public function set grade(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         NumberViewUtils.refreshValue(param1,_numContainer,_numBitmap.bitmapData,20,21,15,20,"0123456789");
         _numContainer.x = 35 - (_numContainer.width - 20) / 2;
         var _loc4_:int = 1;
         _loc5_ = 0;
         while(_loc5_ < configArr.length)
         {
            _loc2_ = configArr[_loc5_].split(",");
            _loc6_ = int(_loc2_[0]);
            _loc3_ = int(_loc2_[1]);
            if(param1 >= _loc6_)
            {
               _loc4_ = Math.min(Math.max(_loc3_ + 1,_loc4_),5);
            }
            _loc5_++;
         }
         bg.setFrame(_loc4_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(bg);
         bg = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_numContainer);
         _numContainer = null;
         super.dispose();
      }
   }
}

