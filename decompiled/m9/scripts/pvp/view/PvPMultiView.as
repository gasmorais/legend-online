package pvp.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PvPMultiView extends Sprite implements Disposeable
   {
      
      private var _icon:Bitmap;
      
      private var _textBack:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _starBtn:IconButton;
      
      private var _shopBtn:IconButton;
      
      public function PvPMultiView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.pvp.MultiIcon");
         _textBack = ComponentFactory.Instance.creatBitmap("asset.pvp.TextBack");
         _text = ComponentFactory.Instance.creatComponentByStylename("pvp.DescribeText");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("pvp.MultiStart");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("pvp.ShopBtn");
         addChild(_icon);
         addChild(_textBack);
         addChild(_text);
         addChild(_starBtn);
         addChild(_shopBtn);
         _text.text = LanguageMgr.GetTranslation("pvp.view.PvPMultiView.text");
      }
      
      private function initEvent() : void
      {
         _shopBtn.addEventListener("click",__openShopHandler);
         _starBtn.addEventListener("click",__startMultiHandler);
      }
      
      private function removeEvent() : void
      {
         _shopBtn.removeEventListener("click",__openShopHandler);
         _starBtn.removeEventListener("click",__startMultiHandler);
      }
      
      private function __startMultiHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(thane.grades < 22)
         {
            _loc2_ = LanguageMgr.GetTranslation("pvp.view.PvPMultiView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("pvproomlist");
      }
      
      private function __openShopHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(thane.grades < 22)
         {
            _loc2_ = LanguageMgr.GetTranslation("pvp.view.PvPMultiView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.pvpControler.openShopFrame();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

