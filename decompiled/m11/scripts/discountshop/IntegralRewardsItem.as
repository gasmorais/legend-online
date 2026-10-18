package discountshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.discountshop.DiscountShopModel;
   import mvc.module.discountshop.DiscountShopScoreInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.DiscountShopManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.component.MovieButton;
   
   public class IntegralRewardsItem extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _integralText:FilterFrameText;
      
      private var _rewardsIcon:BaseItemView;
      
      private var _getImg:ScaleFrameImage;
      
      private var _rewardBtn:MovieButton;
      
      private var _data:DiscountShopScoreInfo;
      
      private var _nowCount:FilterFrameText;
      
      public function IntegralRewardsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.discountshop.rewardBg");
         _getImg = ComponentFactory.Instance.creatComponentByStylename("discountshop.getimg");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn");
         _integralText = ComponentFactory.Instance.creatComponentByStylename("discountshop.integral.integralText");
         _rewardsIcon = ComponentFactory.Instance.creatComponentByStylename("discountshop.integral.rewardsItem");
         _nowCount = ComponentFactory.Instance.creatComponentByStylename("discountshop.RewardGoodsCount");
         addChild(_back);
         addChild(_getImg);
         _getImg.setFrame(1);
         addChild(_rewardBtn);
         _rewardBtn.x = 55;
         _rewardBtn.y = 13;
         _rewardBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         _rewardBtn.addChild(_integralText);
         _rewardBtn.addChild(_rewardsIcon);
         _rewardBtn.addChild(_nowCount);
         _integralText.text = "达到7000积分";
      }
      
      private function initEvent() : void
      {
         _rewardBtn.addEventListener("click",__getRewardsHandler);
      }
      
      private function __getRewardsHandler(param1:MouseEvent) : void
      {
         if(_data.isTake)
         {
            return;
         }
         _rewardBtn.movie.movie["effect"]["effect_01"].gotoAndStop(1);
         DiscountShopManager.instance.operationDiscountShop(4,_data.score);
         removeEvent();
      }
      
      private function removeEvent() : void
      {
         if(_rewardBtn)
         {
            _rewardBtn.removeEventListener("click",__getRewardsHandler);
         }
      }
      
      public function set data(param1:DiscountShopScoreInfo) : void
      {
         _data = param1;
         this.filters = [UIFilter.getGrayFilter()];
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.itemId;
         _rewardsIcon.data = _loc2_;
         _nowCount.text = param1.count.toString();
         if(param1.isTake)
         {
            _rewardBtn.enable = false;
            _rewardBtn.filters = [UIFilter.getGrayFilter()];
            _getImg.setFrame(3);
         }
         _integralText.text = LanguageMgr.GetTranslation("discountshop.integralItem.integralNum",param1.score);
         if(discountModel.myScore >= param1.score)
         {
            this.filters = [];
            if(!param1.isTake)
            {
               _getImg.setFrame(2);
               initEvent();
               _rewardBtn.movie.movie["effect"]["effect_01"].play();
            }
         }
      }
      
      public function get discountModel() : DiscountShopModel
      {
         return DiscountShopManager.instance.model;
      }
      
      public function dispose() : void
      {
         _data = null;
         removeEvent();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_integralText)
         {
            ObjectUtils.disposeObject(_integralText);
         }
         _integralText = null;
         if(_rewardsIcon)
         {
            ObjectUtils.disposeObject(_rewardsIcon);
         }
         _rewardsIcon = null;
         if(_nowCount)
         {
            ObjectUtils.disposeObject(_nowCount);
         }
         _nowCount = null;
         if(_getImg)
         {
            ObjectUtils.disposeObject(_getImg);
         }
         _getImg = null;
         if(_rewardBtn)
         {
            ObjectUtils.disposeObject(_rewardBtn);
         }
         _rewardBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

