package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class YLExpedtionHeadInfoView extends Sprite
   {
      
      private var headBack:Bitmap;
      
      private var headIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var _iconMask:Shape;
      
      public function YLExpedtionHeadInfoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         headBack = ComponentFactory.Instance.creatBitmap("asset.ChildPatrolHallFrame.headBack");
         headIcon = ComponentFactory.Instance.creatCustomObject("ChildPatrolHallFrame.headIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolHallFrame.nameText");
         addChild(headBack);
         addChild(headIcon);
         addChild(nameText);
         nameText.text = playerModel.playerInfo.nickName;
         headIcon.icon = IconFactory.getPlayerIcon(ArmyManager.instance.thane.snsInfo.headId,"head");
         _iconMask = createIconMask();
         addChild(_iconMask);
         _iconMask.x = _iconMask.y = 4;
         headIcon.mask = _iconMask;
      }
      
      private function createIconMask() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawCircle(32,34,30);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(headBack);
         headBack = null;
         ObjectUtils.disposeObject(headIcon);
         headIcon = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         if(_iconMask)
         {
            ObjectUtils.disposeObject(_iconMask);
         }
         _iconMask = null;
      }
   }
}

