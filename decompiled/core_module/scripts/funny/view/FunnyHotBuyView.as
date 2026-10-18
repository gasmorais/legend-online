package funny.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class FunnyHotBuyView extends Sprite implements Disposeable, IManualSize
   {
      
      private var _back:Bitmap;
      
      private var _title:GradientText;
      
      private var _panel:ScrollPanel;
      
      private var _describeText:FilterFrameText;
      
      private var _preBack:Bitmap;
      
      private var _previewImage:ScaleFrameImage;
      
      private var _sp:Sprite;
      
      private var _goodsBack:ScaleBitmapImage;
      
      private var _rechargeBtn:IconButton;
      
      private var _itemList:Vector.<FunnyHotBuyItem>;
      
      private var _isVIP:Boolean = false;
      
      public function FunnyHotBuyView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.funny.funnyRightViewBack1");
         _title = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.title");
         _panel = ComponentFactory.Instance.creatComponentByStylename("funnyHotBuyView.panel");
         _describeText = ComponentFactory.Instance.creatComponentByStylename("funnyRightView.describeText");
         _preBack = ComponentFactory.Instance.creatBitmap("asset.funny.rewardTitleBack");
         _previewImage = ComponentFactory.Instance.creatComponentByStylename("funny.HotBuyImage");
         _goodsBack = ComponentFactory.Instance.creatComponentByStylename("funnyHotBuyView.goodsBack");
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("funny.funnyBagView.rechargeBtn");
         _sp = new Sprite();
         addChild(_back);
         addChild(_rechargeBtn);
         addChild(_title);
         _title.text = LanguageMgr.GetTranslation("funny.view.FunnyBagView.title");
         addChild(_panel);
         _panel.setView(_sp);
         _sp.addChild(_describeText);
         _sp.addChild(_preBack);
         _preBack.y = 72;
         _sp.addChild(_previewImage);
         _previewImage.setFrame(1);
         _sp.addChild(_goodsBack);
         _itemList = new Vector.<FunnyHotBuyItem>();
      }
      
      private function clearItemList() : void
      {
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
         }
      }
      
      public function set isVIP(param1:Boolean) : void
      {
         _isVIP = param1;
      }
      
      public function setHotBuy() : void
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:FunnyHotBuyItem = null;
         clearItemList();
         if(_isVIP)
         {
            _previewImage.setFrame(2);
            _describeText.text = LanguageMgr.GetTranslation("funny.view.FunnyFrame.FunnyHotBuyView.vipDescribeText");
            _loc2_ = ShopManager.Instance.model.getTimeBuyList(1);
         }
         else
         {
            _previewImage.setFrame(1);
            _describeText.text = LanguageMgr.GetTranslation("funny.view.FunnyFrame.FunnyHotBuyView.describeText");
            _loc2_ = ShopManager.Instance.model.getTimeBuyList(0);
         }
         var _loc1_:int = int(_loc2_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = new FunnyHotBuyItem();
            _loc3_.x = 248 * (_loc4_ % 2) + 2;
            _loc3_.y = 133 * Math.floor(_loc4_ / 2) + 107;
            _loc3_.data = _loc2_[_loc4_];
            _sp.addChild(_loc3_);
            _itemList.push(_loc3_);
            _loc4_++;
         }
         _goodsBack.height = 135 * Math.ceil(_loc1_ / 2);
         if(_goodsBack.height < 270)
         {
            _goodsBack.height = 270;
         }
         _panel.invalidateViewport();
      }
      
      public function setRemainTime() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:int = 0;
         var _loc1_:int = int(_itemList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_itemList[_loc2_] && _itemList[_loc2_].data)
            {
               _loc3_ = _itemList[_loc2_].data.remainTime;
               if(_loc3_ > 0)
               {
                  _itemList[_loc2_].timeText = _loc3_;
               }
               else
               {
                  _itemList[_loc2_].data = null;
               }
            }
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         if(_rechargeBtn)
         {
            _rechargeBtn.addEventListener("click",__rechargeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_rechargeBtn)
         {
            _rechargeBtn.removeEventListener("click",__rechargeHandler);
         }
      }
      
      private function __rechargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearItemList();
         _itemList = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_describeText);
         _describeText = null;
         ObjectUtils.disposeObject(_preBack);
         _preBack = null;
         ObjectUtils.disposeObject(_previewImage);
         _previewImage = null;
         ObjectUtils.disposeObject(_goodsBack);
         _goodsBack = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeAllChildren(_sp);
         _sp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return null;
      }
   }
}

