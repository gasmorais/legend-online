package raveparty
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class RavePartyScoreItemView extends Component
   {
      
      private var back:MutipleImage;
      
      private var numberBitmap:BitmapData;
      
      private var levelContnier:Component;
      
      private var scoreText:FilterFrameText;
      
      private var scoreImage:Image;
      
      private var goodHbox:HBox;
      
      private var getBtn:IconButton;
      
      private var hasGetImage:Bitmap;
      
      private var _data:RavePartyRewardInfo;
      
      public function RavePartyScoreItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.back");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.RavePartyScoreItemView.numberBitmap");
         levelContnier = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.levelContnier");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.scoreText");
         scoreImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.scoreImage");
         goodHbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.goodHbox");
         getBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreItemView.getBtn");
         hasGetImage = ComponentFactory.Instance.creatBitmap("asset.RavePartyScoreItemView.hasGetImage");
         addChild(back);
         addChild(levelContnier);
         addChild(scoreText);
         addChild(scoreImage);
         addChild(goodHbox);
         addChild(getBtn);
         addChild(hasGetImage);
         getBtn.visible = false;
         hasGetImage.visible = false;
         scoreImage.tipData = LanguageMgr.GetTranslation("RavePartyScoreItemView.scoreImage.tipData");
      }
      
      private function addEvent() : void
      {
         getBtn.addEventListener("click",__onGetRewardHandler);
      }
      
      private function removeEvent() : void
      {
         if(getBtn)
         {
            getBtn.removeEventListener("click",__onGetRewardHandler);
         }
      }
      
      private function __onGetRewardHandler(param1:MouseEvent) : void
      {
         if(!_data || _data.rewardState != 1)
         {
            return;
         }
         RavePartyManager.instance.sendRavePartyRequest(2,_data.rewardType,_data.rewardLevel);
      }
      
      public function set data(param1:RavePartyRewardInfo) : void
      {
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         _data = param1;
         getBtn.visible = false;
         hasGetImage.visible = false;
         scoreImage.visible = false;
         scoreText.text = "";
         goodHbox.removeAllChild();
         if(!_data)
         {
            return;
         }
         NumberViewUtils.refreshValue(_data.rewardLevel,levelContnier,numberBitmap,12,15,10,12,"0123456789");
         scoreText.text = _data.needValue + "";
         scoreImage.visible = true;
         refreshBtnState();
         _loc5_ = 1;
         while(_loc5_ <= 6)
         {
            _loc2_ = _data["rewardItem" + _loc5_];
            if(!(_loc2_ == null || _loc2_ == ""))
            {
               _loc3_ = _loc2_.split("|");
               _loc4_ = ComponentFactory.Instance.creatCustomObject("RavePartyScoreItemView.gItem");
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc3_[0];
               _loc6_.count = _loc3_[1];
               _loc4_.data = _loc6_;
               goodHbox.addChild(_loc4_);
            }
            _loc5_++;
         }
      }
      
      public function refreshBtnState() : void
      {
         if(_data.rewardState == 0)
         {
            getBtn.visible = true;
            getBtn.enable = false;
            hasGetImage.visible = false;
         }
         else if(_data.rewardState == 1)
         {
            getBtn.visible = true;
            getBtn.enable = true;
            hasGetImage.visible = false;
         }
         else if(_data.rewardState == 2)
         {
            getBtn.visible = false;
            getBtn.enable = false;
            hasGetImage.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(numberBitmap)
         {
            ObjectUtils.disposeObject(numberBitmap);
         }
         numberBitmap = null;
         if(levelContnier)
         {
            ObjectUtils.disposeObject(levelContnier);
         }
         levelContnier = null;
         if(goodHbox)
         {
            ObjectUtils.disposeObject(goodHbox);
         }
         goodHbox = null;
         if(getBtn)
         {
            ObjectUtils.disposeObject(getBtn);
         }
         getBtn = null;
         if(hasGetImage)
         {
            ObjectUtils.disposeObject(hasGetImage);
         }
         hasGetImage = null;
         if(scoreText)
         {
            ObjectUtils.disposeObject(scoreText);
         }
         scoreText = null;
         if(scoreImage)
         {
            ObjectUtils.disposeObject(scoreImage);
         }
         scoreImage = null;
         super.dispose();
      }
   }
}

