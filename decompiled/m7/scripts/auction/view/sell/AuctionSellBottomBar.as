package auction.view.sell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class AuctionSellBottomBar extends Sprite implements Disposeable
   {
      
      private var _diamondBack:DisplayObject;
      
      private var _diamondTxt:FilterFrameText;
      
      private var _cancelBtn:BaseButton;
      
      public function AuctionSellBottomBar()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _diamondBack = ComponentFactory.Instance.creatComponentByStylename("auction.diamondBackImg2");
         _diamondTxt = ComponentFactory.Instance.creatComponentByStylename("auction.DiamondTxt2");
         _diamondTxt.text = "10000";
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("auction.cancelBtn");
         addChild(_diamondBack);
         addChild(_diamondTxt);
         addChild(_cancelBtn);
         playerInfo.addEventListener("POINT_CHANGE",onPointChanged,false,0,true);
         onPointChanged(null);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function onPointChanged(param1:PlayerEvent) : void
      {
         _diamondTxt.text = PlayerManager.instance.currentPlayerModel.playerInfo.point + "";
      }
      
      public function getCancelBtn() : BaseButton
      {
         return _cancelBtn;
      }
      
      public function dispose() : void
      {
         playerInfo.removeEventListener("POINT_CHANGE",onPointChanged);
         ObjectUtils.disposeObject(_diamondBack);
         _diamondBack = null;
         ObjectUtils.disposeObject(_diamondTxt);
         _diamondTxt = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

