package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.event.GloryGameEvent;
   
   public class SevenYearGloryGameScheduleView extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _gloryGameSchedulePic1:MutipleImage;
      
      private var posArray1:Array = [[-82,63],[-82,179],[-82,292],[-82,406]];
      
      private var posArray2:Array = [[163,80],[163,199],[163,310],[163,429]];
      
      private var posArray3:Array = [[390,137],[390,366]];
      
      private var posArray4:Array = [[605,252]];
      
      private var container:Component;
      
      public function SevenYearGloryGameScheduleView()
      {
         super();
         initView();
         initEvent();
         GloryGameManager.instance.sendOpenBet();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.bg7");
         _gloryGameSchedulePic1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGameSchedulePic1");
         addChild(_bit0);
         addChild(_gloryGameSchedulePic1);
         container = new Component();
         addChild(container);
         initItem();
      }
      
      private function initEvent() : void
      {
         GloryGameManager.instance.addEventListener("SCHEDULE_INFO_UPDATE",onUpdate);
      }
      
      private function removeEvent() : void
      {
         GloryGameManager.instance.removeEventListener("SCHEDULE_INFO_UPDATE",onUpdate);
      }
      
      protected function onUpdate(param1:GloryGameEvent) : void
      {
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc4_:* = null;
         var _loc3_:SevenYearGloryGameScheduleData1 = null;
         var _loc2_:SevenYearGloryGameScheduleData2 = null;
         while(container.numChildren > 0)
         {
            (container.getChildAt(0) as Component).dispose();
         }
         for each(var _loc1_:Array in posArray1)
         {
            _loc3_ = new SevenYearGloryGameScheduleData1();
            container.addChild(_loc3_);
            _loc3_.x = _loc1_[0];
            _loc3_.y = _loc1_[1];
            _loc3_.setData(2,posArray1.indexOf(_loc1_));
         }
         for each(_loc1_ in posArray2)
         {
            _loc2_ = new SevenYearGloryGameScheduleData2();
            container.addChild(_loc2_);
            _loc2_.x = _loc1_[0];
            _loc2_.y = _loc1_[1];
            _loc2_.setData(3,posArray2.indexOf(_loc1_));
         }
         for each(_loc1_ in posArray3)
         {
            _loc2_ = new SevenYearGloryGameScheduleData2();
            container.addChild(_loc2_);
            _loc2_.x = _loc1_[0];
            _loc2_.y = _loc1_[1];
            _loc2_.setData(4,posArray3.indexOf(_loc1_));
         }
         for each(_loc1_ in posArray4)
         {
            _loc2_ = new SevenYearGloryGameScheduleData2();
            container.addChild(_loc2_);
            _loc2_.x = _loc1_[0];
            _loc2_.y = _loc1_[1];
            _loc2_.setData(5,posArray4.indexOf(_loc1_));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_gloryGameSchedulePic1);
         _gloryGameSchedulePic1 = null;
         ObjectUtils.disposeObject(container);
         container = null;
         super.dispose();
      }
   }
}

