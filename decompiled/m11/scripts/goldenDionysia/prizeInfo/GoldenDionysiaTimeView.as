package goldenDionysia.prizeInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.manager.GoldenDionysiaManager;
   import yishi.utils.DateFormatter;
   
   public class GoldenDionysiaTimeView extends Component
   {
      
      private var _frame1:ScaleBitmapImage;
      
      private var _frame2:ScaleBitmapImage;
      
      private var _titleBg:Bitmap;
      
      private var _title2:FilterFrameText;
      
      private var _luckyNum2:FilterFrameText;
      
      private var _timeTxt2:FilterFrameText;
      
      public function GoldenDionysiaTimeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _frame1 = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.bg");
         _frame2 = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.bg");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.timeTxt");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.timeInfoTitle");
         _luckyNum2 = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.timeInfoLuckNum");
         _timeTxt2 = ComponentFactory.Instance.creatComponentByStylename("goldenDionysia.timeInfoTimeTxt");
         addChild(_frame1);
         addChild(_frame2);
         addChild(_titleBg);
         addChild(_title2);
         addChild(_luckyNum2);
         addChild(_timeTxt2);
         _frame1.scaleX = -1;
         _frame1.x = 174;
         _frame1.y = 8;
         _frame2.scaleX = -1;
         _frame2.scaleY = -1;
         _frame2.x = 174;
         _frame2.y = 122;
      }
      
      public function update() : void
      {
         var _loc4_:GoldCrazyMsg = GoldenDionysiaManager.instance.goldenMsg;
         _title2.text = _loc4_.stopTime;
         _luckyNum2.text = LanguageMgr.GetTranslation("GoldenDionysiaTimeView.timeTxt");
         var _loc1_:Date = DateFormatter.parse(_loc4_.stopTime,"YYYY-MM-DD hh:mm:ss");
         var _loc5_:Number = _loc1_.time + 86400000;
         var _loc2_:Date = new Date(_loc5_);
         var _loc3_:String = DateFormatter.timeFormat4(_loc2_);
         _timeTxt2.text = _loc3_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_frame1);
         _frame1 = null;
         ObjectUtils.disposeObject(_frame2);
         _frame2 = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_title2);
         _title2 = null;
         ObjectUtils.disposeObject(_luckyNum2);
         _luckyNum2 = null;
         ObjectUtils.disposeObject(_timeTxt2);
         _timeTxt2 = null;
         super.dispose();
      }
   }
}

