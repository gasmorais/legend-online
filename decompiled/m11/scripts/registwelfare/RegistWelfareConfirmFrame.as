package registwelfare
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.registwelfare.ItemBoxInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.RegistWelfareManager;
   import yishi.view.community.BaseItemView;
   
   public class RegistWelfareConfirmFrame extends Frame implements IManualSize
   {
      
      private var _data:ItemBoxInfo;
      
      private var _bg:Bitmap;
      
      private var _sellBmp:Bitmap;
      
      private var _sellPriceTxt:FilterFrameText;
      
      private var _pointImg:Image;
      
      private var _confirmBtn:IconButton;
      
      private var _contain:Sprite;
      
      public function RegistWelfareConfirmFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,405,280);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("registwelfare.RegistWelfareConfirmFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.registwelfare.buySureBg");
         _sellBmp = ComponentFactory.Instance.creatBitmap("asset.registwelfare.buySureNote");
         _sellPriceTxt = ComponentFactory.Instance.creatComponentByStylename("registwelfare.sellPriceTxt");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("registwelfare.SmallPointImg");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("registwelfare.buyConfirmBtn");
         _contain = new Sprite();
         _contain.x = 1;
         _contain.y = 69;
         addToContent(_bg);
         addToContent(_contain);
         addToContent(_sellBmp);
         addToContent(_sellPriceTxt);
         addToContent(_pointImg);
         addToContent(_confirmBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmClickHandler);
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
      
      private function __confirmClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _data.price)
         {
            RechargeAlertMannager.show();
            return;
         }
         RegistWelfareManager.instance.openChainBuy(_data.id);
         dispose();
      }
      
      public function show(param1:ItemBoxInfo) : void
      {
         _data = param1;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:Array = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         ObjectUtils.disposeAllChildren(_contain);
         var _loc6_:Array = _data.items.split("|");
         var _loc3_:int = (_bg.width - _loc6_.length * 60) / (_loc6_.length + 1);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc5_].split(",");
            _loc2_ = ComponentFactory.Instance.creatCustomObject("registwelfare.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc1_[0];
            _loc4_.count = _loc1_[1];
            _loc2_.data = _loc4_;
            _loc2_.x = _bg.x + _loc3_ * (_loc5_ + 1) + 60 * _loc5_;
            _loc2_.y = 38;
            _contain.addChild(_loc2_);
            _loc5_++;
         }
         _sellPriceTxt.text = String(_data.price);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_contain);
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sellBmp);
         _sellBmp = null;
         ObjectUtils.disposeObject(_sellPriceTxt);
         _sellPriceTxt = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         _data = null;
         super.dispose();
      }
   }
}

