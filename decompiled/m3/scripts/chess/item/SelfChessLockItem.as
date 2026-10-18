package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class SelfChessLockItem extends Sprite
   {
      
      public var _btLuckBtn:BaseButton;
      
      public var _lockState:ScaleFrameImage;
      
      private var _isLock:int;
      
      public function SelfChessLockItem()
      {
         super();
         initView();
      }
      
      public function get isLock() : int
      {
         return _isLock;
      }
      
      public function set isLock(param1:int) : void
      {
         _isLock = param1;
         if(_isLock)
         {
            _lockState.setFrame(1);
         }
         else
         {
            _lockState.setFrame(2);
         }
      }
      
      private function initView() : void
      {
         _btLuckBtn = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.btLuckBtn");
         _lockState = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.lockState");
         addChild(_btLuckBtn);
         addChild(_lockState);
         _btLuckBtn.tipData = LanguageMgr.GetTranslation("selfchess.lockBtn.Tip");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_btLuckBtn);
         _btLuckBtn = null;
         ObjectUtils.disposeObject(_lockState);
         _lockState = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

