package dayguide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.DayGuideManager;
   
   public class SignDayView extends Sprite
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _num:ScaleFrameImage;
      
      private var _today:Bitmap;
      
      private var _checkedImg:Bitmap;
      
      private var _day:int;
      
      public function SignDayView(param1:int)
      {
         super();
         _day = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.newSignDayBg");
         _num = ComponentFactory.Instance.creatComponentByStylename("dayGuide.newSignDayNum" + _day);
         _today = ComponentFactory.Instance.creatBitmap("asset.dayGuide.DateItemToday");
         _checkedImg = ComponentFactory.Instance.creatBitmap("asset.dayGuide.CheckedImg");
         addChild(_bg);
         addChild(_num);
         addChild(_today);
         addChild(_checkedImg);
      }
      
      public function setData(param1:int) : void
      {
         _bg.setFrame(3);
         _checkedImg.visible = false;
         _today.visible = false;
         if(_day < DayGuideManager.instance.daySignInfo.todayIndex - 1)
         {
            _bg.setFrame(4);
         }
         if(param1 == 1)
         {
            _checkedImg.visible = true;
         }
         if(_day == DayGuideManager.instance.daySignInfo.todayIndex - 1)
         {
            _bg.setFrame(1);
            _checkedImg.visible = false;
            _today.visible = true;
            if(param1 == 1)
            {
               _bg.setFrame(2);
               _checkedImg.visible = true;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_num);
         _num = null;
         ObjectUtils.disposeObject(_today);
         _today = null;
         ObjectUtils.disposeObject(_checkedImg);
         _checkedImg = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

