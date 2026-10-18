package raveparty
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.NoviceBtnGlowEffect;
   import yishi.utils.NumberViewUtils;
   
   public class RavePartyBoxImage extends Component
   {
      
      private var boxImage:Image;
      
      private var pointImage:Image;
      
      private var numberBitmap:BitmapData;
      
      private var boxTextContnier:Component;
      
      private var getEffect:NoviceBtnGlowEffect;
      
      private var index:int;
      
      private var myCurPoint:int;
      
      private var _data:RavePartyRewardInfo;
      
      public function RavePartyBoxImage(param1:int)
      {
         super();
         index = param1;
         initView();
      }
      
      private function initView() : void
      {
         boxImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyBoxImage.boxImage" + index);
         pointImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyBoxImage.pointImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.RavePartyBoxImage.numberBitmap");
         boxTextContnier = ComponentFactory.Instance.creatComponentByStylename("RavePartyBoxImage.boxTextContnier");
         getEffect = new NoviceBtnGlowEffect(boxImage,9);
         addChild(boxImage);
         addChild(pointImage);
         addChild(boxTextContnier);
      }
      
      private function addEvent() : void
      {
         boxImage.addEventListener("click",__getRewardHandler);
      }
      
      private function removeEvent() : void
      {
         if(boxImage)
         {
            boxImage.removeEventListener("click",__getRewardHandler);
         }
      }
      
      private function __getRewardHandler(param1:MouseEvent) : void
      {
         if(!_data || _data.rewardState != 1)
         {
            return;
         }
         RavePartyManager.instance.sendRavePartyRequest(2,_data.rewardType,_data.rewardLevel);
      }
      
      public function set data(param1:RavePartyRewardInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         NumberViewUtils.refreshValue(_data.needValue,boxTextContnier,numberBitmap,12,18,10,12,"0123456789");
         boxTextContnier.x = 12;
         pointImage.visible = true;
         if(_data.rewardType == 1)
         {
            myCurPoint = model.myChargePoint;
         }
         else if(_data.rewardType == 2)
         {
            myCurPoint = model.myConsumPoint;
         }
         else if(_data.rewardType == 3)
         {
            myCurPoint = model.myLeedScore;
            boxTextContnier.x = _data.needValue > 999 ? 0 : 5;
            pointImage.visible = false;
         }
         this.filters = [];
         getEffect.stop();
         if(myCurPoint >= _data.needValue && _data.rewardState == 1)
         {
            addEvent();
            getEffect.play();
            boxImage.buttonMode = true;
         }
         else if(_data.rewardState == 2)
         {
            removeEvent();
            boxImage.buttonMode = false;
            this.filters = [UIFilter.getBlackFilter()];
         }
         else
         {
            removeEvent();
            boxImage.buttonMode = false;
         }
         boxImage.tipData = getTipsStr();
      }
      
      private function getTipsStr() : String
      {
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc4_:String = LanguageMgr.GetTranslation("dayguide.LimitedSellView.ActiveBoxItemTips") + "\n";
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc1_ = _data["rewardItem" + _loc3_];
            if(!(_loc1_ == null || _loc1_ == ""))
            {
               _loc2_ = _loc1_.split("|");
               _loc4_ += getGoodsName(_loc2_[0]) + "x" + _loc2_[1] + ",\n";
            }
            _loc3_++;
         }
         return _loc4_.substring(0,_loc4_.lastIndexOf(","));
      }
      
      private function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      override public function get width() : Number
      {
         return 45;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(boxImage)
         {
            ObjectUtils.disposeObject(boxImage);
         }
         boxImage = null;
         if(pointImage)
         {
            ObjectUtils.disposeObject(pointImage);
         }
         pointImage = null;
         if(numberBitmap)
         {
            ObjectUtils.disposeObject(numberBitmap);
         }
         numberBitmap = null;
         if(boxTextContnier)
         {
            ObjectUtils.disposeObject(boxTextContnier);
         }
         boxTextContnier = null;
         if(getEffect)
         {
            ObjectUtils.disposeObject(getEffect);
         }
         getEffect = null;
         super.dispose();
      }
   }
}

