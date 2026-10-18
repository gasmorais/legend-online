package pvp.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import yishi.scene.SceneManager;
   
   public class PvPSingleView extends Sprite implements Disposeable
   {
      
      private var _icon:Bitmap;
      
      private var _textBack:Bitmap;
      
      private var _text:FilterFrameText;
      
      private var _mask:Bitmap;
      
      private var _starBtn:IconButton;
      
      private var _shape:Shape;
      
      public function PvPSingleView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.pvp.SingleIcon");
         _textBack = ComponentFactory.Instance.creatBitmap("asset.pvp.TextBack");
         _mask = ComponentFactory.Instance.creatBitmap("asset.pvp.Mask");
         _text = ComponentFactory.Instance.creatComponentByStylename("pvp.DescribeText");
         _starBtn = ComponentFactory.Instance.creatComponentByStylename("pvp.SingleStart");
         createShape();
         addChild(_icon);
         addChild(_textBack);
         addChild(_text);
         addChild(_starBtn);
         addChild(_mask);
         addChild(_shape);
         _text.text = LanguageMgr.GetTranslation("pvp.view.PvPSingleView.text");
      }
      
      private function createShape() : void
      {
         _shape = new Shape();
         _shape.graphics.beginFill(65535,0);
         _shape.graphics.drawRect(0,0,_mask.width,_mask.height);
      }
      
      private function initEvent() : void
      {
         _starBtn.addEventListener("click",__startSingleHandler);
         addEventListener("mouseOver",__overHandler);
      }
      
      private function removeEvent() : void
      {
         _starBtn.removeEventListener("click",__startSingleHandler);
         removeEventListener("mouseOver",__overHandler);
      }
      
      public function get starBtn() : IconButton
      {
         return _starBtn;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _mask.visible = false;
      }
      
      public function get showMask() : Bitmap
      {
         return _mask;
      }
      
      private function __startSingleHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ChallengeManager.instance.enterScene = SceneManager.instance.currentType;
         ChallengeManager.instance.isShowFrame = true;
         SceneManager.instance.setScene("CHANLLENGE_ROOM_SCENE");
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

