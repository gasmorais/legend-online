package cathouse
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.view.community.MagicSpringBufferAddView;
   
   public class CatHouseFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _border:ScaleBitmapImage;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _currencyBar:CatHouseCurrencyBar;
      
      private var _catCourtyard:CatCourtyard;
      
      public function CatHouseFrame()
      {
         super();
         initView();
         initBufferView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,786,620);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("cathouse.CatHouseFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.cathouse.backgroud");
         _border = ComponentFactory.Instance.creatComponentByStylename("cathouse.border");
         _currencyBar = ComponentFactory.Instance.creatCustomObject("cathouse.CatHouseCurrencyBar");
         _catCourtyard = ComponentFactory.Instance.creatCustomObject("cathouse.CatCourtyard");
         addToContent(_bg);
         addToContent(_border);
         addToContent(_currencyBar);
         addToContent(_catCourtyard);
      }
      
      private function initBufferView() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc3_);
            _loc1_ = LanguageMgr.GetTranslation("cathouse.CatHouseFrame.bufferText",_loc3_.tempInfo.AddValue);
            _loc2_ = LanguageMgr.GetTranslation("MagicSpringBufferAddView.descText.text",_loc1_);
            _bufferView.setDescText(_loc2_);
            _bufferView.x = 20;
            _bufferView.y = 40;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_currencyBar);
         _currencyBar = null;
         ObjectUtils.disposeObject(_catCourtyard);
         _catCourtyard = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         super.dispose();
      }
   }
}

