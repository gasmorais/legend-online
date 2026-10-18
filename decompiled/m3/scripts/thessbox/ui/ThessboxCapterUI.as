package thessbox.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.view.community.BaseIconView;
   
   public class ThessboxCapterUI extends Sprite
   {
      
      protected var _chapter1:Bitmap;
      
      protected var _chapter2:Bitmap;
      
      protected var _chapter6:Bitmap;
      
      protected var _chapt1:FilterFrameText;
      
      protected var _chapt2:FilterFrameText;
      
      protected var _fristCapHbox:HBox;
      
      protected var _ch2Hbox:HBox;
      
      protected var _gotoFtBtn:IconButton;
      
      protected var _rtBtn:IconButton;
      
      protected var _fristPanel:ScrollPanel;
      
      protected var _prePanel:ScrollPanel;
      
      protected var _icon:BaseIconView;
      
      public function ThessboxCapterUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _chapter1 = ComponentFactory.Instance.creatBitmap("asset.thessbox.chapter1");
         _chapter2 = ComponentFactory.Instance.creatBitmap("asset.thessbox.chapter2");
         _chapter6 = ComponentFactory.Instance.creatBitmap("asset.thessbox.chapter6");
         _chapt1 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.chapt1");
         _chapt2 = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.chapt2");
         _fristCapHbox = ComponentFactory.Instance.creatCustomObject("ui.thessbox.fristCapHbox");
         _ch2Hbox = ComponentFactory.Instance.creatCustomObject("ui.thessbox.ch2Hbox");
         _fristPanel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.fristPanel");
         _prePanel = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.prePanel");
         _gotoFtBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.gotoFtBtn");
         _rtBtn = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.rtBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.thessbox.capterIcon");
         addChild(_chapter1);
         addChild(_chapter2);
         addChild(_chapter6);
         addChild(_chapt1);
         addChild(_chapt2);
         addChild(_icon);
         addChild(_fristPanel);
         addChild(_prePanel);
         addChild(_gotoFtBtn);
         addChild(_rtBtn);
         _fristPanel.setView(_fristCapHbox);
         _prePanel.setView(_ch2Hbox);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_chapter1);
         _chapter1 = null;
         ObjectUtils.disposeObject(_chapter2);
         _chapter2 = null;
         ObjectUtils.disposeObject(_chapter6);
         _chapter6 = null;
         ObjectUtils.disposeObject(_chapt1);
         _chapt1 = null;
         ObjectUtils.disposeObject(_chapt2);
         _chapt2 = null;
         ObjectUtils.disposeObject(_fristPanel);
         _fristPanel = null;
         ObjectUtils.disposeObject(_fristCapHbox);
         _fristCapHbox = null;
         ObjectUtils.disposeObject(_prePanel);
         _prePanel = null;
         ObjectUtils.disposeObject(_ch2Hbox);
         _ch2Hbox = null;
         ObjectUtils.disposeObject(_gotoFtBtn);
         _gotoFtBtn = null;
         ObjectUtils.disposeObject(_rtBtn);
         _rtBtn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

