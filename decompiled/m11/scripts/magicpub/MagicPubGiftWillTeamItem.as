package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.giftparty.TeamMemberInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class MagicPubGiftWillTeamItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _goodsIcon:ScaleFrameImage;
      
      private var _data:TeamMemberInfoMsg;
      
      private var _teamId:int;
      
      public function MagicPubGiftWillTeamItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.magicpub.giftWill.goodsItemBack");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.teamNumTxt");
         _goodsIcon = ComponentFactory.Instance.creatComponentByStylename("xmlui.magi.GoosIcon2");
         addChild(_back);
         addChild(_numTxt);
         addChild(_goodsIcon);
         _goodsIcon.visible = false;
         _numTxt.text = "0/1";
      }
      
      public function set teamId(param1:int) : void
      {
         _teamId = param1;
      }
      
      public function set data(param1:TeamMemberInfoMsg) : void
      {
         _data = param1;
         clearView();
         if(!param1)
         {
            return;
         }
         _goodsIcon.visible = true;
         _goodsIcon.setFrame(_data.fragQuality);
         _goodsIcon.tipData = _data.nickName;
         _numTxt.text = "1/1";
      }
      
      private function clearView() : void
      {
         _goodsIcon.visible = false;
         _numTxt.text = "0/1";
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_goodsIcon);
         _goodsIcon = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

