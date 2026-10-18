package heroroad
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.events.NotificationEvent;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   
   public class HeroRoadCourseView extends Sprite implements Disposeable
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _topView:HeroRoadItemView;
      
      private var _bottomView:HeroRoadBoxItemView;
      
      private var _greenBar:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _itemBack1:Image;
      
      private var _itemBack2:Image;
      
      private var _itemBack3:Image;
      
      private var _itemBack4:Image;
      
      private var _itemBack5:Image;
      
      private var _boxBack1:Image;
      
      private var _boxBack2:Image;
      
      private var _boxBack3:Image;
      
      private var _boxBack4:Image;
      
      private var _boxBack5:Image;
      
      private var _boxBack6:Image;
      
      public function HeroRoadCourseView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadFrame.back");
         _bg = ComponentFactory.Instance.creatBitmap("asset.heroroad.Bg");
         _topView = ComponentFactory.Instance.creatCustomObject("heroroad.HeroRoadItemView");
         _bottomView = ComponentFactory.Instance.creatCustomObject("heroroad.HeroRoadBoxItemView");
         _greenBar = ComponentFactory.Instance.creatCustomObject("asset.heroroad.item.greenBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("heroroad.greenBar.progressTxt");
         _itemBack1 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardItemBack");
         _itemBack1.x = 15;
         _itemBack2 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardItemBack");
         _itemBack2.x = 193;
         _itemBack3 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardItemBack");
         _itemBack3.x = 371;
         _itemBack4 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardItemBack");
         _itemBack4.x = 549;
         _itemBack5 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardItemBack");
         _itemBack5.x = 727;
         _boxBack1 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack1.x = 32;
         _boxBack2 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack2.x = 168;
         _boxBack3 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack3.x = 304;
         _boxBack4 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack4.x = 519;
         _boxBack5 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack5.x = 655;
         _boxBack6 = ComponentFactory.Instance.creatComponentByStylename("heroroad.cardBoxItemBack");
         _boxBack6.x = 791;
         addChild(_back);
         addChild(_bg);
         addChild(_itemBack1);
         addChild(_itemBack2);
         addChild(_itemBack3);
         addChild(_itemBack4);
         addChild(_itemBack5);
         addChild(_boxBack1);
         addChild(_boxBack2);
         addChild(_boxBack3);
         addChild(_boxBack4);
         addChild(_boxBack5);
         addChild(_boxBack6);
         addChild(_topView);
         addChild(_bottomView);
         addChild(_greenBar);
         addChild(_progressTxt);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
         __updateViewHandler(null);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("HEROROAD_UPDATE_VIEW",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = int(HeroRoadManager.instance.getAllScore());
         if(HeroRoadManager.instance.heroScore >= _loc4_)
         {
            _progressTxt.text = "max";
            _loc2_ = 100;
         }
         else
         {
            _loc3_ = int(HeroRoadManager.instance.heroScore);
            _progressTxt.text = HeroRoadManager.instance.heroScore + "/" + _loc4_;
            _loc2_ = _loc3_ / _loc4_ * 100;
         }
         _greenBar.gotoAndStop(_loc2_);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeViolentMc(_greenBar);
         _greenBar = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_itemBack1);
         _itemBack1 = null;
         ObjectUtils.disposeObject(_itemBack2);
         _itemBack2 = null;
         ObjectUtils.disposeObject(_itemBack3);
         _itemBack3 = null;
         ObjectUtils.disposeObject(_itemBack4);
         _itemBack4 = null;
         ObjectUtils.disposeObject(_itemBack5);
         _itemBack5 = null;
         ObjectUtils.disposeObject(_boxBack1);
         _boxBack1 = null;
         ObjectUtils.disposeObject(_boxBack2);
         _boxBack2 = null;
         ObjectUtils.disposeObject(_boxBack3);
         _boxBack3 = null;
         ObjectUtils.disposeObject(_boxBack4);
         _boxBack4 = null;
         ObjectUtils.disposeObject(_boxBack5);
         _boxBack5 = null;
         ObjectUtils.disposeObject(_boxBack6);
         _boxBack6 = null;
      }
   }
}

