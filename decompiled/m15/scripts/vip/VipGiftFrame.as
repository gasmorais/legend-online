package vip
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   
   public class VipGiftFrame extends Frame
   {
      
      private var _promptTxt:FilterFrameText;
      
      private var _topLeftBg:Bitmap;
      
      private var _topRightBg:Bitmap;
      
      private var _bottomLeftBg:Bitmap;
      
      private var _bottomRightBg:Bitmap;
      
      private var _lines:Bitmap;
      
      private var _vipGiftItem01:VipGiftItem;
      
      private var _vipGiftItem02:VipGiftItem;
      
      private var _vipGiftBackground:ScaleBitmapImage;
      
      public function VipGiftFrame()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("vip.view.VipGiftFrame.titleText");
         _vipGiftBackground = ComponentFactory.Instance.creatComponentByStylename("vip.VipGiftBackground");
         _promptTxt = ComponentFactory.Instance.creatComponentByStylename("vip.VipGiftPromptTxt");
         _topLeftBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGiftTopBg");
         _topRightBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGiftTopBg");
         _bottomLeftBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGiftBottomBg");
         _bottomRightBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGiftBottomBg");
         _lines = ComponentFactory.Instance.creatBitmap("asset.countlogin.VipLineAsset");
         _topRightBg.width = 265;
         _topRightBg.scaleX = -1;
         _topRightBg.x = _topLeftBg.x + 530;
         _bottomRightBg.width = 265;
         _bottomRightBg.scaleX = -1;
         _bottomRightBg.x = _bottomLeftBg.x + 530;
         addToContent(_vipGiftBackground);
         addToContent(_bottomLeftBg);
         addToContent(_bottomRightBg);
         addToContent(_topLeftBg);
         addToContent(_topRightBg);
         addToContent(_promptTxt);
         _promptTxt.text = LanguageMgr.GetTranslation("vip.view.VipGiftFrame.promptTxt");
         _vipGiftItem01 = new VipGiftItem();
         addToContent(_vipGiftItem01);
         _vipGiftItem01.x = -8;
         _vipGiftItem01.y = 47;
         addToContent(_lines);
         _vipGiftItem02 = new VipGiftItem();
         addToContent(_vipGiftItem02);
         _vipGiftItem02.x = -8;
         _vipGiftItem02.y = 110;
      }
      
      public function initData() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = int(VIPManager.Instance.model.vipInfo.VipGrade);
         if(_loc2_ == 0)
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_ + 1);
            _vipGiftItem01.data(_loc1_,_loc2_ + 1);
         }
         else if(_loc2_ == 9)
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_ - 1);
            _vipGiftItem01.data(_loc1_,_loc2_ - 1);
         }
         else
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_);
            _vipGiftItem01.data(_loc1_,_loc2_);
         }
         if(_loc2_ == 9)
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_);
            _vipGiftItem02.data(_loc1_,_loc2_);
         }
         else if(_loc2_ == 0)
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_ + 2);
            _vipGiftItem02.data(_loc1_,_loc2_ + 2);
         }
         else
         {
            _loc1_ = TempleteManager.instance.vipDropTemplateCate.getTemplatesByGrade(_loc2_ + 1);
            _vipGiftItem02.data(_loc1_,_loc2_ + 1);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               FrameControllerManager.instance.vipController.hideGiftFrame();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

