package dayguide
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.DayGuideSocketOutManager;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.manager.InfoTipsManager;
   
   public class DayGuideFrame extends Frame implements IManualSize
   {
      
      public static var SIGN_BTN:String = "sign";
      
      public static var LUCKY_DRAW:String = "lucky_draw";
      
      private var vipGift:int = 0;
      
      private var signGift:int = 0;
      
      private var _back:ScaleBitmapImage;
      
      private var _bg:ScaleBitmapImage;
      
      private var _limitedSell:LimitedSellView;
      
      public function DayGuideFrame()
      {
         super();
         DayGuideSocketOutManager.sendDailyCount();
         initView();
         addEvent();
         refreshCount();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,600,560);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function refreshCount() : void
      {
         if(vipModel.vipInfo.IsTakeGift && Boolean(vipModel.vipInfo.IsVipAndNoExpirt))
         {
            vipGift = 1;
         }
         else
         {
            vipGift = 0;
         }
         InfoTipsManager.instance.updateValue(26,vipGift);
         InfoTipsManager.instance.updateValue(25,signGift);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("dayGuide.Back1");
         titleText = LanguageMgr.GetTranslation("dayGuide.view.DayGuideFrame.title");
         _limitedSell = ComponentFactory.Instance.creatCustomObject("dayGuide.limitedSellView");
         addToContent(_bg);
         addToContent(_limitedSell);
         DayGuideManager.instance.isShowNoActive = true;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __backCall(param1:Boolean) : void
      {
         _closeButton.enable = param1;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      private function getBtnTipView() : MovieClip
      {
         var _loc1_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         _loc1_.visible = false;
         _loc1_.x = 8;
         _loc1_.y = -3;
         return _loc1_;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         DayGuideManager.instance.page = -1;
         DayGuideManager.instance.isShowNoActive = false;
         ObjectUtils.disposeObject(_limitedSell);
         _limitedSell = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

