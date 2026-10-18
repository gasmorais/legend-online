package marry.quality
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class MarryCarriageView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _carriageIcon:BaseIconView;
      
      private var _discText:FilterFrameText;
      
      public function MarryCarriageView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.marry.horseIconBack");
         _discText = ComponentFactory.Instance.creatComponentByStylename("marry.marryCarriageDesc");
         _discText.text = LanguageMgr.GetTranslation("marry.marryCarriage.carriageDesc");
         _carriageIcon = ComponentFactory.Instance.creatCustomObject("MarryRoomLefttView.rewardIcon");
         _carriageIcon.icon = IconFactory.getMarryHorseIcon();
         addChild(_bg);
         addChild(_discText);
         addChild(_carriageIcon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_discText);
         _discText = null;
         ObjectUtils.disposeObject(_carriageIcon);
         _carriageIcon = null;
      }
   }
}

