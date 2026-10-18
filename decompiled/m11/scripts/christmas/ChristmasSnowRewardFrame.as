package christmas
{
   import avatar.view.AppellView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class ChristmasSnowRewardFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg1:Bitmap;
      
      private var _bg2:Bitmap;
      
      private var _appellName:Bitmap;
      
      private var _appellAtt:Bitmap;
      
      private var _index:int = 1;
      
      private var _appellContainer:Component;
      
      private var _appellTopView:AppellView;
      
      private var _propertyTxt:FilterFrameText;
      
      private var _panel:ScrollPanel;
      
      private var _vbox:VBox;
      
      public function ChristmasSnowRewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,354,303);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ChristmasPrayPreviewFrame.titleText.txt");
         _border = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.border");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.bg1");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.bg2");
         _appellName = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.appellName");
         _appellAtt = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayPreviewFrame.appellAtt");
         _appellContainer = new Component();
         _appellContainer.x = 0;
         _appellContainer.y = 70;
         _propertyTxt = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.propertyTxt");
         _panel = ComponentFactory.Instance.creatComponentByStylename("christmasPrayPreviewFrame.scollPanel");
         _vbox = ComponentFactory.Instance.creatCustomObject("christmasPrayPreviewFrame.vBox");
         addToContent(_border);
         addToContent(_bg2);
         addToContent(_panel);
         addToContent(_bg1);
         addToContent(_appellName);
         addToContent(_appellAtt);
         addToContent(_appellContainer);
         addToContent(_propertyTxt);
         _panel.setView(_vbox);
         initData();
      }
      
      private function initData() : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:String = null;
         var _loc6_:ChristmasLotteryTempInfo = null;
         var _loc3_:ChristmasSnowRewardItem = null;
         _panel.beginChanges();
         _vbox.beginChanges();
         var _loc10_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(4);
         var _loc1_:Array = [];
         var _loc7_:Dictionary = new Dictionary();
         for each(var _loc9_:ChristmasActivitiesTempInfo in _loc10_)
         {
            _loc8_ = 1;
            while(_loc8_ <= 4)
            {
               if(_loc9_["Reward" + _loc8_] != 0)
               {
                  _loc2_ = int(_loc9_["Reward" + _loc8_]);
                  _loc5_ = int(_loc9_["Num" + _loc8_]);
                  _loc11_ = _loc2_ + "_" + _loc5_;
                  if(_loc7_[_loc11_] == undefined)
                  {
                     _loc6_ = new ChristmasLotteryTempInfo();
                     _loc6_.ItemId = _loc2_;
                     _loc6_.Num = _loc5_;
                     _loc1_.push(_loc6_);
                     _loc7_[_loc11_] = true;
                  }
               }
               _loc8_++;
            }
         }
         var _loc4_:int = Math.ceil(_loc1_.length / 4);
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc3_ = new ChristmasSnowRewardItem(_loc8_ + 1);
            _vbox.addChild(_loc3_);
            _loc8_++;
         }
         _vbox.commitChanges();
         _panel.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      public function refreshView() : void
      {
         _bg1.visible = _appellName.visible = _appellAtt.visible = _appellContainer.visible = _propertyTxt.visible = _index == 0;
         _panel.visible = _index == 1;
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
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         refreshView();
         FrameControllerManager.instance.christmasController.setPreFrame("");
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_appellName);
         _appellName = null;
         ObjectUtils.disposeObject(_appellAtt);
         _appellAtt = null;
         ObjectUtils.disposeAllChildren(_appellContainer);
         _appellContainer = null;
         ObjectUtils.disposeAllChildren(_vbox);
         _vbox = null;
         super.dispose();
         FrameControllerManager.instance.christmasController.setPreFrame("christmas");
      }
   }
}

