package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   
   public class GoldOvertopView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _text:FilterFrameText;
      
      private var _timeID:int;
      
      public function GoldOvertopView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__onCloseBtn);
      }
      
      private function __onCloseBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GoldOvertop");
         _text = ComponentFactory.Instance.creatComponentByStylename("goldOvertop.goldOvertopFrameTxt");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("goldOvertop.CloseBtn");
         _text.text = LanguageMgr.GetTranslation("mainBar.view.GoldOvertopView.goldOvertop");
         addChild(_bg);
         addChild(_text);
         addChild(_closeBtn);
         _timeID = setTimeout(dispose,8000);
      }
      
      public function dispose() : void
      {
         clearTimeout(_timeID);
         removeEvent();
         if(_text)
         {
            _text.dispose();
         }
         _text = null;
         _bg = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseBtn);
         }
      }
   }
}

