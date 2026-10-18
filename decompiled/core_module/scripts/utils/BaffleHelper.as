package utils
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.datas.PathInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class BaffleHelper
   {
      
      private static var _container:Sprite;
      
      private static var _topBg:ScaleBitmapImage;
      
      private static var _bottomBg:ScaleBitmapImage;
      
      private static var _isShowing:Boolean;
      
      public function BaffleHelper()
      {
         super();
      }
      
      public static function show() : void
      {
         if(_isShowing)
         {
            return;
         }
         _isShowing = true;
         initView();
         addEvent();
         __onStageResize(null);
         LayerManager.Instance.addToLayer(_container,0);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_OUT_SCENE"));
         TweenMax.to(_topBg,0.5,{"alpha":1});
         TweenMax.to(_bottomBg,0.5,{"alpha":1});
      }
      
      public static function hide() : void
      {
         removeEvent();
         TweenMax.killTweensOf(_topBg);
         TweenMax.killTweensOf(_bottomBg);
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         _isShowing = false;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UI_ENTER_SCENE"));
      }
      
      public static function get isShowing() : Boolean
      {
         return _isShowing;
      }
      
      private static function initView() : void
      {
         _container = new Sprite();
         _topBg = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogUpBg");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("core.novice.DialogBg");
         _topBg.alpha = 0;
         _topBg.height = 125;
         _bottomBg.alpha = 0;
         _bottomBg.height = 150;
         _container.addChild(_topBg);
         _container.addChild(_bottomBg);
      }
      
      private static function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__onStageResize);
      }
      
      public static function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__onStageResize);
      }
      
      private static function __onStageResize(param1:Event) : void
      {
         var _loc2_:int = int(StageReferance.stageWidth < PathInfo.GAME_WIDTH ? PathInfo.GAME_WIDTH : StageReferance.stageWidth);
         var _loc3_:int = int(StageReferance.stageHeight < PathInfo.GAME_HEIGHT ? PathInfo.GAME_HEIGHT : StageReferance.stageHeight);
         _topBg.width = _bottomBg.width = _loc2_;
         _topBg.y = -20;
         _bottomBg.y = _loc3_ - _bottomBg.displayHeight + 26;
      }
   }
}

