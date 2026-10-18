package kingback.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.kingback.KingbackInfo;
   
   public class KingbackGiftKindItem extends Sprite
   {
      
      private static var _giftSelectFlg:Bitmap;
      
      public var _giftImgs:ScaleFrameImage;
      
      public var _giftNameTxt:FilterFrameText;
      
      private var _data:KingbackInfo;
      
      public function KingbackGiftKindItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _giftImgs = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftImgs");
         _giftNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.kingback.giftNameTxt");
         if(_giftSelectFlg == null)
         {
            _giftSelectFlg = ComponentFactory.Instance.creatBitmap("asset.kingback.giftSelectFlg");
         }
         addChild(_giftImgs);
         addChild(_giftNameTxt);
         buttonMode = true;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_giftSelectFlg)
         {
            if(param1)
            {
               addChild(_giftSelectFlg);
            }
            else
            {
               removeChild(_giftSelectFlg);
            }
         }
      }
      
      public function get data() : KingbackInfo
      {
         return _data;
      }
      
      public function set data(param1:KingbackInfo) : void
      {
         _data = param1;
         var _loc2_:int = int(_data.tempInfo.SubType);
         _giftImgs.setFrame(_loc2_ - 3);
         _giftNameTxt.text = LanguageMgr.GetTranslation("kingback.gift.name" + _loc2_);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_giftImgs);
         _giftImgs = null;
         ObjectUtils.disposeObject(_giftNameTxt);
         _giftNameTxt = null;
         ObjectUtils.disposeObject(_giftSelectFlg);
         _giftSelectFlg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

