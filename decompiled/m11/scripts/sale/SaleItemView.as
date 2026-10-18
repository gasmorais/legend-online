package sale
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.SaleManager;
   import mvc.module.sale.SaleData;
   import mvc.module.sale.SaleModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SaleItemView extends Component
   {
      
      private var _data:SaleData;
      
      private var _titanId:int;
      
      private var _bg:Image;
      
      private var _icon:BaseItemView;
      
      private var _goodsViewBg:Image;
      
      private var _selectedLight:Image;
      
      private var _iconBg:Image;
      
      private var _smallPointImg:Bitmap;
      
      private var _smallPointImg2:Bitmap;
      
      private var _itemName:FilterFrameText;
      
      private var _leftTime:FilterFrameText;
      
      private var _auctionPrice:FilterFrameText;
      
      private var _fixedPrice:FilterFrameText;
      
      private var _auctionBtn:IconButton;
      
      private var _fixedPriceBtn:IconButton;
      
      private var _soldBtn:IconButton;
      
      private var container1:Component;
      
      private var container2:Component;
      
      private var _switchMc:MovieClip;
      
      private var _superWorth:Image;
      
      private var isFirst:Boolean = true;
      
      public function SaleItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("sale.goodsViewBg");
         _selectedLight = ComponentFactory.Instance.creatComponentByStylename("sale.selectedLight");
         _superWorth = ComponentFactory.Instance.creatComponentByStylename("sale.superWorth");
         _icon = ComponentFactory.Instance.creatCustomObject("sale.saleGoodsBaseItemView");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _smallPointImg2 = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.itemName");
         _leftTime = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.leftTime");
         _auctionPrice = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.auctionPrice");
         _fixedPrice = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.fixedPrice");
         _auctionBtn = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.auctionBtn");
         _fixedPriceBtn = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.fixedPriceBtn");
         _soldBtn = ComponentFactory.Instance.creatComponentByStylename("SaleItemView.soldBtn");
         _switchMc = ComponentFactory.Instance.creat("asset.sale.switchMC");
         _switchMc.x = 293;
         _switchMc.y = 39;
         _switchMc.stop();
         _switchMc.visible = false;
         container1 = new Component();
         container2 = new Component();
         container2.addChild(_bg);
         container2.addChild(_superWorth);
         container2.addChild(_selectedLight);
         container2.addChild(_icon);
         _icon.x = 12;
         _icon.y = 18;
         container2.addChild(_smallPointImg);
         container2.addChild(_smallPointImg2);
         _smallPointImg2.x = _smallPointImg.x = 404;
         _smallPointImg.y = 20;
         _smallPointImg2.y = 56;
         container2.addChild(_itemName);
         container2.addChild(_leftTime);
         container2.addChild(_auctionPrice);
         container2.addChild(_fixedPrice);
         container2.addChild(_soldBtn);
         _soldBtn.enable = false;
         _soldBtn.visible = false;
         container2.addChild(_fixedPriceBtn);
         container2.addChild(_auctionBtn);
         _selectedLight.visible = false;
         _selectedLight.mouseChildren = _selectedLight.mouseEnabled = false;
         _superWorth.visible = false;
         _superWorth.mouseChildren = _superWorth.mouseEnabled = false;
         container1.y = 45;
         container2.y = -45;
         container1.addChild(container2);
         addChild(container1);
         addChild(_switchMc);
      }
      
      private function rotate1() : void
      {
         TweenMax.to(container1,0.3,{
            "rotationX":180,
            "scaleY":0.01,
            "alpha":0.15,
            "onComplete":rotate2
         });
         setTimeout(function():void
         {
            _switchMc.visible = true;
            _switchMc.addFrameScript(_switchMc.totalFrames - 1,function():void
            {
               _switchMc.stop();
               _switchMc.visible = false;
            });
            _switchMc.gotoAndPlay(1);
         },145);
      }
      
      private function rotate2() : void
      {
         refreshView();
         setTimeout(function():void
         {
            TweenMax.to(container1,0.3,{
               "rotationX":0,
               "scaleY":1,
               "alpha":1,
               "onComplete":rotateCompleted
            });
         },280);
      }
      
      private function rotateCompleted() : void
      {
         container1.rotationX = 0;
         container1.transform.matrix3D = null;
         container1.y = 45;
      }
      
      public function set data(param1:SaleData) : void
      {
         if(!param1)
         {
            _data = null;
            clear();
            return;
         }
         var _loc2_:Boolean = _data == null || _data.auctionId != param1.auctionId;
         _data = param1;
         if(isFirst)
         {
            refreshView();
            isFirst = false;
         }
         else if(_loc2_)
         {
            rotate1();
         }
         else
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:GoodsInfo = null;
         _auctionBtn.visible = _data.currentBidUserId == 0 || ArmyManager.instance.thane.userId != _data.currentBidUserId;
         if(_data.startPoint == 0)
         {
            _auctionBtn.visible = false;
            _auctionPrice.visible = false;
         }
         else
         {
            _auctionPrice.visible = true;
         }
         _soldBtn.visible = _data.startPoint != 0;
         _fixedPriceBtn.visible = _data.fixPoint != 0;
         _fixedPrice.visible = _data.fixPoint != 0;
         _smallPointImg.visible = _data.startPoint != 0;
         _smallPointImg2.visible = _data.fixPoint != 0;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId);
         _itemName.text = _loc1_.TemplateName;
         _leftTime.text = getTimeString(_data.seconds);
         _leftTime.setFrame(_data.seconds > 59 ? 1 : 2);
         _auctionPrice.text = _data.currentPoint + "";
         _fixedPrice.text = _data.fixPoint + "";
         _superWorth.visible = model.specialId != 0 && _data.auctionId == model.specialId;
         if(!_icon.data || _icon.data.templateId != _loc1_.TemplateId || _icon.data.count != _data.counts)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = _loc1_.TemplateId;
            _loc2_.count = _data.counts;
            _icon.data = _loc2_;
         }
      }
      
      private function getTimeString(param1:int) : String
      {
         if(param1 < 60)
         {
            return LanguageMgr.GetTranslation("SaleItemView.lessThanOneMinute");
         }
         if(param1 < 3600)
         {
            return int(param1 / 60) + LanguageMgr.GetTranslation("yishi.utils.DateFormatter.timeStr.minShort");
         }
         return int(param1 / 3600) + LanguageMgr.GetTranslation("public.time.hour");
      }
      
      public function clear() : void
      {
         _itemName.text = "";
         _leftTime.text = "";
         _auctionPrice.text = "";
         _fixedPrice.text = "";
         _icon.data = null;
         _auctionBtn.visible = false;
         _fixedPriceBtn.visible = false;
         _soldBtn.visible = false;
         _smallPointImg.visible = false;
         _smallPointImg2.visible = false;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function unInitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
      }
      
      protected function __mouseoutHandler(param1:MouseEvent) : void
      {
         _selectedLight.visible = false;
      }
      
      protected function __mouseoverHandler(param1:MouseEvent) : void
      {
         _selectedLight.visible = true;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseoverHandler);
         addEventListener("mouseOut",__mouseoutHandler);
         _auctionBtn.addEventListener("click",_auctionBtnClickHandle);
         _fixedPriceBtn.addEventListener("click",_fixedPriceBtnClickHandle);
      }
      
      protected function _auctionBtnClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:ConfirmBidFrame = ComponentFactory.Instance.creatComponentByStylename("sale.ConfirmBidFrame");
         _loc2_.show(_data,1,__alertResponse);
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:Object = null) : void
      {
         if(param1)
         {
         }
      }
      
      protected function _fixedPriceBtnClickHandle(param1:MouseEvent) : void
      {
         var _loc2_:ConfirmBidFrame = ComponentFactory.Instance.creatComponentByStylename("sale.ConfirmBidFrame");
         _loc2_.show(_data,2,__alertResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseoverHandler);
         removeEventListener("mouseOut",__mouseoutHandler);
         _auctionBtn.removeEventListener("click",_auctionBtnClickHandle);
         _fixedPriceBtn.removeEventListener("click",_fixedPriceBtnClickHandle);
      }
      
      private function get model() : SaleModel
      {
         return SaleManager.instance.model;
      }
      
      override public function dispose() : void
      {
         this.dispatchEvent(new MouseEvent("rollOut"));
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

