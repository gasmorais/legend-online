package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.PageList;
   
   public class GloryShopFrame extends Frame
   {
      
      private var _shopBg:ScaleBitmapImage;
      
      private var _leftColorBg:Bitmap;
      
      private var _rightColorBg:Bitmap;
      
      private var _pageList:PageList;
      
      private var _returnBtn:IconButton;
      
      private var _scoreBg:Image;
      
      private var _scoreIcon:Bitmap;
      
      private var _scoreBmp:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _lineImg:Image;
      
      public function GloryShopFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         FrameControllerManager.instance.shopController.initGloryShopFrame();
         titleText = LanguageMgr.GetTranslation("GloryShopFrame.initView.title");
         _shopBg = ComponentFactory.Instance.creatComponentByStylename("stop.ComShopFrameDescribeBackground");
         _leftColorBg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _leftColorBg.x = 7;
         _leftColorBg.y = 3;
         _rightColorBg = ComponentFactory.Instance.creatBitmap("asset.shop.GoodsListViewBG");
         _rightColorBg.scaleX = -1;
         _rightColorBg.x = _rightColorBg.width * 2 + 7;
         _rightColorBg.y = 3;
         _pageList = ComponentFactory.Instance.creatComponentByStylename("gloryroad.pageList");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("gloryroad.returnBtn");
         _scoreBg = ComponentFactory.Instance.creatComponentByStylename("shop.gloryNumBg");
         _scoreBmp = ComponentFactory.Instance.creatBitmap("asset.shop.gloryScore");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("shop.glorySocreTxt");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("shop.gloryShopIcon");
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-3900);
         if(_loc3_)
         {
            _lineImg.tipData = _loc3_.Description;
         }
         addToContent(_shopBg);
         addToContent(_leftColorBg);
         addToContent(_rightColorBg);
         addToContent(_pageList);
         addToContent(_returnBtn);
         addToContent(_scoreBg);
         addToContent(_scoreBmp);
         addToContent(_scoreTxt);
         addToContent(_lineImg);
         var _loc1_:Array = GloryroadManager.instance.model.getShopData();
         var _loc2_:int = _loc1_.length % _pageList.pageSize;
         if(_loc2_ != 0)
         {
            _loc2_ = _pageList.pageSize - _loc2_;
            _loc1_ = _loc1_.concat(new Array(_loc2_));
         }
         _pageList.data = _loc1_;
         __updateGodwinerPoint(null);
      }
      
      private function initEvent() : void
      {
         _returnBtn.addEventListener("click",__returnClick);
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function removeEvent() : void
      {
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",__returnClick);
         }
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _scoreTxt.text = GloryroadManager.instance.model.getGloryCoinAmount().toString();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __returnClick(param1:Event) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_shopBg);
         _shopBg = null;
         ObjectUtils.disposeObject(_leftColorBg);
         _leftColorBg = null;
         ObjectUtils.disposeObject(_rightColorBg);
         _rightColorBg = null;
         ObjectUtils.disposeObject(_pageList);
         _pageList = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_scoreBg);
         _scoreBg = null;
         ObjectUtils.disposeObject(_scoreIcon);
         _scoreIcon = null;
         ObjectUtils.disposeObject(_scoreBmp);
         _scoreBmp = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_lineImg);
         _lineImg = null;
         super.dispose();
      }
   }
}

