package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import yishi.manager.ArmyManager;
   
   public class UnrealShootingRoomBackView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _bgEffect:MovieClip;
      
      private var _playerView:UnrealShootingRoomPlayerView;
      
      public function UnrealShootingRoomBackView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.unrealshooting.RoomBg");
         _bgEffect = ComponentFactory.Instance.creatCustomObject("warlordsroom.RoomBgEffect");
         _playerView = ComponentFactory.Instance.creatCustomObject("unrealshootingroom.RoomPlayerView");
         _playerView.data = ArmyManager.instance.army;
         addChild(_bg);
         addChild(_playerView);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_playerView);
         _playerView = null;
         ObjectUtils.disposeViolentMc(_bgEffect);
         _bgEffect = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      override public function get width() : Number
      {
         return _bg ? _bg.width : super.width;
      }
      
      override public function get height() : Number
      {
         return _bg ? _bg.height : super.height;
      }
      
      public function refreshView() : void
      {
         _playerView.showBody();
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

