package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MagicPubGiftWillView extends Sprite implements Disposeable
   {
      
      private var _back01:ScaleBitmapImage;
      
      private var _back02:ScaleBitmapImage;
      
      private var _back03:ScaleBitmapImage;
      
      private var _topFlower:Bitmap;
      
      private var _downFlower:Bitmap;
      
      private var _teamListView:MagicPubGiftWillTeamListView;
      
      private var _teamInfoView:MagicPubGiftWillTeamInfoView;
      
      public function MagicPubGiftWillView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back01 = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.teamBg01");
         _back02 = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.teamBg02");
         _back03 = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.teamBg03");
         _topFlower = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.topFlower");
         _downFlower = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.topFlower");
         _teamListView = ComponentFactory.Instance.creatCustomObject("magicpub.MagicPubGiftWillTeamListView");
         _teamInfoView = ComponentFactory.Instance.creatCustomObject("magicpub.MagicPubGiftWillTeamInfoView");
         addChild(_back01);
         addChild(_back02);
         addChild(_back03);
         addChild(_topFlower);
         addChild(_downFlower);
         addChild(_teamListView);
         addChild(_teamInfoView);
         _topFlower.x = 12;
         _topFlower.y = 11;
         _downFlower.scaleY = -1;
         _downFlower.x = 12;
         _downFlower.y = 505;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back01);
         _back01 = null;
         ObjectUtils.disposeObject(_back02);
         _back02 = null;
         ObjectUtils.disposeObject(_back03);
         _back03 = null;
         ObjectUtils.disposeObject(_topFlower);
         _topFlower = null;
         ObjectUtils.disposeObject(_downFlower);
         _downFlower = null;
         ObjectUtils.disposeObject(_teamListView);
         _teamListView = null;
         ObjectUtils.disposeObject(_teamInfoView);
         _teamInfoView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

